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
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface TalentVC ()<UITableViewDelegate,UITableViewDataSource,TlentIntroudceTableViewCellDelegate,UITextFieldDelegate,KGCameraDelegate,TalentPushPhotosTableViewCellDelegate,AMapSearchDelegate>

@property (nonatomic,strong) UITableView *listView;
/**
 cell的标题数组
 */
@property (nonatomic,copy) NSArray *plholderArr;
/**
 请求参数
 */
@property (nonatomic,strong) NSMutableDictionary *parasmart;
/**
 用来监测点击的是哪个cell上的输入框
 */
@property (nonatomic,strong) UITextField *cellTF;
/**
 选择拍摄还是选择的弹窗
 */
@property (nonatomic,strong) KGCamera *cameraView;
/**
 用来区分选择照片以及拍摄时时视频还是照片
 */
@property (nonatomic,assign) NSInteger type;
/**
 保存选择或者拍摄的照片的数组
 */
@property (nonatomic,strong) NSMutableArray *imageArr;
/**
 保存选择或者拍摄的照片上传完成后的地址的数组
 */
@property (nonatomic,strong) NSMutableArray *dataImageArr;
/**
 视频原路径
 */
@property (nonatomic,strong) NSURL *videoStr;
/**
 判断视频是否上传完成
 */
@property (nonatomic,assign) BOOL videoIsUlLoad;
/**
 高德地图搜索APi
 */
@property (nonatomic,strong) AMapSearchAPI *search;

@end

@implementation TalentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"我要做达人" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"提交" image:nil];
    self.view.backgroundColor = Color_f2f2f2;
    // !!!: --每个Cell的标题--
    _plholderArr = @[@"请输入标题",@"请输入机构/场所名称",@"请输入地址",@"请输入场所电话(选填)",@"请对你上传的地标做一番介绍吧！"];
    
    _parasmart = [NSMutableDictionary dictionary];
    _imageArr = [NSMutableArray array];
    _videoIsUlLoad = YES;
    
    [self setTableView];
    [self initSearchApi];
}
// MARK: --得区分消失动画，因为有两种方式跳转过来，第一种就是发布view通过pre方式，第二种通过push方式--
- (void)leftNavBtuAction:(UIButton *)sender{
    if ([_status isEqualToString:@"积分"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
// MARK: --因为除了视频，其他都是必须填写的，所以要逐个排查是否按照规则填写--
- (void)rightNavBtuAction:(UIButton *)sender{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (_parasmart[@"headline"]) {//:--是否填写标题--
        if (_parasmart[@"siteName"]) {//:--场馆名称--
            if (_parasmart[@"siteAddress"]) {//:--场馆地址--
                if (_parasmart[@"siteIntroduce"]) {//:--场景介绍--
                    if (_parasmart[@"location"]) {//:--拍摄位置--
                        if (_parasmart[@"images"]) {//:--描述场景的照片数组--
                            [self uploadImage];
                            if (_parasmart[@"siteVideo"]) {//:--场景视频--
                                _videoIsUlLoad = NO;
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
// MARK: --上传视频，开启异步线程是为了减少用户等待时间--
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
// MARK: --上传照片,异步上传是为了减少用户等待时间--
- (void)uploadImage{
    __weak typeof(self) mySelf = self;
    __block NSArray *arr = _parasmart[@"images"];
    _dataImageArr = [NSMutableArray array];
    dispatch_queue_t imageQueue = dispatch_queue_create("上传图片", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(imageQueue, ^{
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:[[KGQiniuUploadManager shareInstance] getImagePath:obj] fileName:nil result:^(NSString *strPath) {
                [mySelf.dataImageArr addObject:strPath];
                [mySelf uploadData];
            }];
        }];
    });
}
// MARK: --请求服务器保存数据--
- (void)uploadData{
    __weak typeof(self) mySelf = self;
    NSArray *arr = _parasmart[@"images"];
    if (_dataImageArr.count == arr.count && _videoIsUlLoad == YES) {
        [mySelf.parasmart setObject:_dataImageArr forKey:@"images"];
        [mySelf.parasmart setObject:[KGUserInfo shareInterace].userID forKey:@"uid"];
        [KGRequestNetWorking postWothUrl:saveMerchantIssue parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"intelligentIssue":_parasmart} succ:^(id result) {
            [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
            if ([result[@"code"] integerValue] == 200) {
                [[MBProgressHUD showHUDAddedTo:mySelf.view animated:YES] bwm_hideWithTitle:@"发布成功" hideAfter:1];
                UIApplication *app = [UIApplication sharedApplication];
                TabBarVC *vc =  [[TabBarVC alloc]init];
                vc.selectedIndex = 2;
                app.keyWindow.rootViewController = vc;
            }else{
                //:--防止再次提交的时候程序奔溃--
                [mySelf.parasmart setObject:mySelf.imageArr forKey:@"images"];
                [mySelf.parasmart setObject:mySelf.videoStr forKey:@"siteVideo"];
                [[MBProgressHUD showHUDAddedTo:mySelf.view animated:YES] bwm_hideWithTitle:@"发布失败" hideAfter:1];
            }
        } fail:^(NSError *error) {
            //:--防止再次提交的时候程序奔溃--
            [mySelf.parasmart setObject:mySelf.imageArr forKey:@"images"];
            [mySelf.parasmart setObject:mySelf.videoStr forKey:@"siteVideo"];
            [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
        }];
    }
}
// MARK: --加载界面--
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
            cell.plholderLab.hidden = YES;
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
        [self geoAddress:textField.text];
    }else if (textField.tag == 103){
        [_parasmart setObject:textField.text forKey:@"siteTelephone"];
    }
}
- (void)initSearchApi{
    [AMapServices sharedServices].apiKey = GeocodeApiKey;
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
}
- (void)geoAddress:(NSString *)str{
    AMapGeocodeSearchRequest *request = [[AMapGeocodeSearchRequest alloc]init];
    request.address = str;
    [_search AMapGeocodeSearch:request];
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    if (response.geocodes.count == 0) {
        return;
    }
    NSArray *locationArr = response.geocodes;
    AMapGeocode *geoCode = [locationArr firstObject];
    AMapGeoPoint *geoPoint = geoCode.location;
    [_parasmart setObject:@(geoPoint.longitude) forKey:@"longitude"];
    [_parasmart setObject:@(geoPoint.latitude) forKey:@"latitude"];
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
                    mySelf.videoStr = urlAsset.URL;
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
            mySelf.videoStr = videoUrl;
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
