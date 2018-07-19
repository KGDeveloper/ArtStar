//
//  TalentVC.m
//  ArtStar
//
//  Created by abc on 5/7/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "TalentVC.h"
#import "TelentTitleTableViewCell.h"
#import "TlentIntroudceTableViewCell.h"
#import "TalentPushPhotosTableViewCell.h"
#import "YourLocationVC.h"
#import <Photos/Photos.h>

@interface TalentVC ()<UITableViewDelegate,UITableViewDataSource,TlentIntroudceTableViewCellDelegate,UITextFieldDelegate,KGCameraDelegate,TalentPushPhotosTableViewCellDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,copy) NSArray *plholderArr;
@property (nonatomic,strong) NSMutableDictionary *parasmart;
@property (nonatomic,strong) UITextField *cellTF;
@property (nonatomic,strong) KGCamera *cameraView;
@property (nonatomic,assign) NSInteger type;

@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) NSMutableArray *dataImageArr;
@property (nonatomic,assign) BOOL videoIsUlLoad;

@end

@implementation TalentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"我要做达人" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"提交" image:nil];
    self.view.backgroundColor = Color_f2f2f2;
    
    _plholderArr = @[@"请输入标题",@"请输入机构/场所名称",@"请输入地址",@"请输入场所电话(选填)",@"请对你上传的地标做一番介绍吧！"];
    
    _parasmart = [NSMutableDictionary dictionary];
    _imageArr = [NSMutableArray array];
    _videoIsUlLoad = NO;
    
    [self setTableView];
}

- (void)leftNavBtuAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightNavBtuAction:(UIButton *)sender{
   
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (_parasmart[@"headline"]) {
        if (_parasmart[@"siteName"]) {
            if (_parasmart[@"siteAddress"]) {
                if (_parasmart[@"siteIntroduce"]) {
                    if (_parasmart[@"location"]) {
                        if (_parasmart[@"images"]) {
                            [self uploadImage];
                            if (_parasmart[@"siteVideo"]) {
                                [self uploadVideo];
                            }
                        }else{
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [[MBProgressHUD showHUDAddedTo:self.view animated:YES] bwm_hideWithTitle:@"请添加地标专属照片" hideAfter:1];
                        }
                    }else{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [[MBProgressHUD showHUDAddedTo:self.view animated:YES] bwm_hideWithTitle:@"请确定你当前的位置" hideAfter:1];
                    }
                }else{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [[MBProgressHUD showHUDAddedTo:self.view animated:YES] bwm_hideWithTitle:@"请填写对上传地标的介绍" hideAfter:1];
                }
            }else{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [[MBProgressHUD showHUDAddedTo:self.view animated:YES] bwm_hideWithTitle:@"请填写场所地址" hideAfter:1];
            }
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[MBProgressHUD showHUDAddedTo:self.view animated:YES] bwm_hideWithTitle:@"请填写场所名称" hideAfter:1];
        }
    }else{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [[MBProgressHUD showHUDAddedTo:self.view animated:YES] bwm_hideWithTitle:@"请填写标题" hideAfter:1];
    }
}

- (void)uploadVideo{
    __weak typeof(self) mySelf = self;
    dispatch_queue_t videoQueue = dispatch_queue_create("上传视频", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(videoQueue, ^{
        [[KGQiniuUploadManager shareInstance] uploadDataToQiniuWithData:mySelf.parasmart[@"siteVideo"] result:^(NSString *strPath) {
            [mySelf.parasmart setObject:strPath forKey:@"siteVideo"];
            mySelf.videoIsUlLoad = YES;
            [mySelf uploadData];
        }];
    });
}
- (void)uploadImage{
    __weak typeof(self) mySelf = self;
    __block NSArray *arr = _parasmart[@"images"];
    _dataImageArr = [NSMutableArray array];
    dispatch_queue_t imageQueue = dispatch_queue_create("上传图片", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(imageQueue, ^{
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%@",obj);
            [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:[[KGQiniuUploadManager shareInstance] getImagePath:obj] fileName:nil result:^(NSString *strPath) {
                NSLog(@"%@",obj);
                [mySelf.dataImageArr addObject:strPath];
                [mySelf uploadData];
            }];
        }];
    });
}

- (void)uploadData{
    __weak typeof(self) mySelf = self;
    NSArray *arr = _parasmart[@"images"];
    if (_dataImageArr.count == arr.count) {
        [mySelf.parasmart setObject:_dataImageArr forKey:@"images"];
        [KGRequestNetWorking postWothUrl:saveMerchantIssue parameters:mySelf.parasmart succ:^(id result) {
            
            [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
        } fail:^(NSError *error) {
            [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
        }];
    }
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.dataSource = self;
    _listView.delegate = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"TelentTitleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TelentTitleTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"TlentIntroudceTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TlentIntroudceTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"TalentPushPhotosTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TalentPushPhotosTableViewCell"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 4) {
        return 60;
    }else if (indexPath.row == 4){
        return 210;
    }else if (indexPath.row == 5){
        if (_parasmart[@"images"]) {
            TalentPushPhotosTableViewCell *cell = [TalentPushPhotosTableViewCell new];
            return [cell cellHeightFromArray:_parasmart[@"images"]];
        }else{
            return 183;
        }
    }else{
        return 183;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 4) {
        TelentTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TelentTitleTableViewCell"];
        cell.textTF.placeholder = _plholderArr[indexPath.row];
        if (indexPath.row == 0 && _parasmart[@"headline"]) {
            cell.textTF.text = _parasmart[@"headline"];
        }else if (indexPath.row == 1 && _parasmart[@"siteName"]){
            cell.textTF.text = _parasmart[@"siteName"];
        }else if (indexPath.row == 2 && _parasmart[@"siteAddress"]){
            cell.textTF.text = _parasmart[@"siteAddress"];
        }else{
            cell.textTF.text = _parasmart[@"siteTelephone"];
        }
        cell.textTF.delegate = self;
        _cellTF = cell.textTF;
        _cellTF.tag = indexPath.row + 100;
        return cell;
    }else if (indexPath.row == 4){
        TlentIntroudceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TlentIntroudceTableViewCell"];
        cell.delegate = self;
        if (_parasmart[@"siteIntroduce"]) {
            cell.introudceTV.text = _parasmart[@"siteIntroduce"];
        }
        if (_parasmart[@"location"]) {
            [cell.locationBtu setTitle:_parasmart[@"location"] forState:UIControlStateNormal];
        }
        return cell;
    }else if (indexPath.row == 5){
        TalentPushPhotosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TalentPushPhotosTableViewCell"];
        cell.titleLab.text = @"上传地标专属照片";
        cell.delegate = self;
        cell.cellIndex = indexPath.row;
        if (_parasmart[@"images"]) {
            cell.imageArr = _parasmart[@"images"];
        }else{
            cell.imageArr = @[];
        }
        return cell;
    }else{
        TalentPushPhotosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TalentPushPhotosTableViewCell"];
        cell.titleLab.text = @"上传小视频(选填)";
        cell.delegate = self;
        cell.cellIndex = indexPath.row;
        if (_parasmart[@"siteVideo"]) {
            cell.videoStr = _parasmart[@"siteVideo"];
        }else{
            cell.videoStr = nil;
        }
        return cell;
    }
}

//MARK:-----------------------------------------TlentIntroudceTableViewCellDelegate-----------------------------------------------
- (void)whereAreYour{
    YourLocationVC *locationVC = [[YourLocationVC alloc]init];
    __weak typeof(self) mySelf = self;
    locationVC.nowLocation = ^(NSString *location) {
        [mySelf.parasmart setObject:location forKey:@"location"];
        NSIndexPath *index = [NSIndexPath indexPathForRow:4 inSection:0];
        [mySelf.listView reloadRowAtIndexPath:index withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    [self pushNoTabBarViewController:locationVC animated:YES];
}
- (void)sendYouIntroudceToController:(NSString *)text{
    [_parasmart setObject:text forKey:@"siteIntroduce"];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 100) {
        [_parasmart setObject:textField.text forKey:@"headline"];
    }else if (textField.tag == 101){
        [_parasmart setObject:textField.text forKey:@"siteName"];
    }else if (textField.tag == 102){
        [_parasmart setObject:textField.text forKey:@"siteAddress"];
    }else if (textField.tag == 103){
        [_parasmart setObject:textField.text forKey:@"siteTelephone"];
    }
}

//MARK:--选择照片--
- (KGCamera *)cameraView{
    if (!_cameraView) {
        _cameraView = [[KGCamera alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _cameraView.hidden = YES;
        _cameraView.delegate = self;
        [self.view insertSubview:_cameraView atIndex:99];
    }
    return _cameraView;
}
//MARK:--代理方法--
/**
 本地上传
 */
- (void)touchPhoto{
    ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc]init];
    if (self.type == 6) {
        ac.maxSelectCount = 1;
        ac.allowSelectGif = YES;
        ac.allowSelectVideo = YES;
        ac.allowSelectImage = NO;
    }else{
        ac.maxSelectCount = 9;
        ac.allowSelectGif = NO;
        ac.allowSelectVideo = NO;
        ac.allowSelectImage = YES;
    }
    ac.sender = self;
    __weak typeof(self) mySelf = self;
    [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        if (assets.count > 0) {
            PHAsset *phAsset = [assets lastObject];
            if (phAsset.mediaType == PHAssetMediaTypeVideo) {
                PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc]init];
                options.version = PHImageRequestOptionsVersionCurrent;
                options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
                PHImageManager *manager = [PHImageManager defaultManager];
                [manager requestAVAssetForVideo:phAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                    AVURLAsset *urlAsset = (AVURLAsset *)asset;
                    [mySelf.parasmart setObject:urlAsset.URL forKey:@"siteVideo"];
                    NSIndexPath *index = [NSIndexPath indexPathForRow:6 inSection:0];
                    [mySelf.listView reloadRowAtIndexPath:index withRowAnimation:UITableViewRowAnimationAutomatic];
                }];
            }
        }
        if (images.count > 0) {
            [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (mySelf.imageArr.count < 9) {
                    [mySelf.imageArr addObject:obj];
                }else{
                    *stop = YES;
                }
            }];
            [mySelf.parasmart setObject:mySelf.imageArr forKey:@"images"];
            NSIndexPath *index = [NSIndexPath indexPathForRow:5 inSection:0];
            [mySelf.listView reloadRowAtIndexPath:index withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
    }];
    [ac showPhotoLibrary];
    self.cameraView.hidden = YES;
}
/**
 拍照上传
 */
- (void)touchCamera{
    __weak typeof(self) mySelf = self;
    ZLCustomCamera *camera = [[ZLCustomCamera alloc]init];
    if (self.type == 6) {
        camera.allowRecordVideo = YES;
    }else{
        camera.allowRecordVideo = NO;
    }
    camera.sessionPreset = ZLCaptureSessionPreset1280x720;
    camera.maxRecordDuration = 10;
    camera.circleProgressColor = [UIColor redColor];
    camera.doneBlock = ^(UIImage *image, NSURL *videoUrl) {
        if (mySelf.type == 5) {
            if (mySelf.imageArr.count < 9) {
                [mySelf.imageArr addObject:image];
                [mySelf.parasmart setObject:mySelf.imageArr forKey:@"images"];
                NSIndexPath *index = [NSIndexPath indexPathForRow:5 inSection:0];
                [mySelf.listView reloadRowAtIndexPath:index withRowAnimation:UITableViewRowAnimationAutomatic];
            }else{
                [[MBProgressHUD showHUDAddedTo:mySelf.view animated:YES] bwm_hideWithTitle:@"最多只能选择9张图片" hideAfter:1];
            }
        }else{
            [mySelf.parasmart setObject:videoUrl forKey:@"siteVideo"];
            NSIndexPath *index = [NSIndexPath indexPathForRow:6 inSection:0];
            [mySelf.listView reloadRowAtIndexPath:index withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    };
    [self presentViewController:camera animated:YES completion:nil];
    self.cameraView.hidden = YES;
}
//MARK:------------------------------------------添加代理事件----------------------------------------------
- (void)touchAddButtonWithIndex:(NSInteger)index{
    _type = index;
    self.cameraView.hidden = NO;
}
//MARK:---------------------------------------删除代理事件-------------------------------------------------
- (void)deleteImageFrameCell:(UIImage *)image{
    [_imageArr removeObject:image];
    [_parasmart setObject:_imageArr forKey:@"images"];
    NSIndexPath *index = [NSIndexPath indexPathForRow:5 inSection:0];
    [_listView reloadRowAtIndexPath:index withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)deleteVideos{
    [_parasmart removeObjectForKey:@"siteVideo"];
    NSIndexPath *index = [NSIndexPath indexPathForRow:6 inSection:0];
    [_listView reloadRowAtIndexPath:index withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
