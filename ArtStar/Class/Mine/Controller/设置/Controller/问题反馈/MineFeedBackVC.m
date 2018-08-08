//
//  MineFeedBackVC.m
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineFeedBackVC.h"
#import "MineFeedBackChooseTableViewCell.h"
#import "MineFeedBackIdeaTableViewCell.h"
#import "MineFeedBackPictureTableViewCell.h"
#import "MineTheIdentityJoinTableViewCell.h"

@interface MineFeedBackVC ()<UITableViewDelegate,UITableViewDataSource,MineFeedBackChooseTableViewCellDelegate,MineFeedBackIdeaTableViewCellDelegate,MineFeedBackPictureTableViewCellDelegate,KGCameraDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,copy) NSArray *headerArr;
/**
 数据请求内容
 */
@property (nonatomic,strong) NSMutableDictionary *parameters;
/**
 保存选择照片
 */
@property (nonatomic,strong) NSMutableArray *photoArr;
/**
 选择照片
 */
@property (nonatomic,strong) KGCamera *cameraView;

@end

@implementation MineFeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"意见反馈" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _headerArr = @[@"请选择问题发生场景",@"请输入详细问题和意见",@"请提供问题相关截图或照片",@""];
    _parameters = [NSMutableDictionary dictionary];
    [_parameters setObject:[KGUserInfo shareInterace].userID forKey:@"uid"];
    [_parameters setObject:@"" forKey:@"r_context"];
    _photoArr = [NSMutableArray array];
    
    [self setUI];
}

- (void)setUI{
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineFeedBackChooseTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineFeedBackChooseTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineFeedBackIdeaTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineFeedBackIdeaTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineFeedBackPictureTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineFeedBackPictureTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineTheIdentityJoinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineTheIdentityJoinTableViewCell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 246;
    }else if (indexPath.section == 1){
        return 100;
    }else if (indexPath.section == 2){
        return 105;
    }else{
        return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    header.backgroundColor = Color_fafafa;
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 40)];
    lab.textColor = Color_333333;
    lab.text = _headerArr[section];
    lab.font = SYFont(12);
    [header addSubview:lab];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return 0;
    }else{
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MineFeedBackChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineFeedBackChooseTableViewCell"];
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 1){
        MineFeedBackIdeaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineFeedBackIdeaTableViewCell"];
        cell.ideaTF.delegate = cell;
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 2){
        MineFeedBackPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineFeedBackPictureTableViewCell"];
        cell.backView.contentSize = CGSizeMake(90*5, 75);
        if (_photoArr.count > 0) {
            cell.photosArr = _photoArr.copy;
        }else{
            cell.photosArr = @[];
        }
        cell.delegate = self;
        return cell;
    }else{
        MineTheIdentityJoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTheIdentityJoinTableViewCell"];
        cell.textLab.text = @"提交";
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            __weak typeof(self) weakSelf = self;
            if (_parameters[@"r_type"]) {
                if (_photoArr.count > 0) {
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    [KGRequestNetWorking postWothUrl:AddRetroactions parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"retroaction":_parameters,@"urls":_photoArr} succ:^(id result) {
                        if ([result[@"code"] integerValue] == 200) {
                            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
                            [MBProgressHUD bwm_showTitle:@"反馈成功" toView:weakSelf.view hideAfter:1];
                        }else{
                            [MBProgressHUD bwm_showTitle:@"反馈失败" toView:weakSelf.view hideAfter:1];
                        }
                    } fail:^(NSError *error) {
                        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
                        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
                        [MBProgressHUD bwm_showTitle:@"请求出错" toView:weakSelf.view hideAfter:1];
                    }];
                }else{
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    [KGRequestNetWorking postWothUrl:AddRetroactions parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"retroaction":_parameters,@"urls":@[]} succ:^(id result) {
                        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
                        if ([result[@"code"] integerValue] == 200) {
                            [MBProgressHUD bwm_showTitle:@"反馈成功" toView:weakSelf.view hideAfter:1];
                        }else{
                            [MBProgressHUD bwm_showTitle:@"反馈失败" toView:weakSelf.view hideAfter:1];
                        }
                    } fail:^(NSError *error) {
                        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
                        [MBProgressHUD bwm_showTitle:@"请求出错" toView:weakSelf.view hideAfter:1];
                    }];
                }
            }else{
                [MBProgressHUD bwm_showTitle:@"请选择反馈类型" toView:self.view hideAfter:1];
            }
        }
    }
}
// MARK: --MineFeedBackChooseTableViewCellDelegate--
- (void)sendChooseResonToController:(NSString *)reson{
    [_parameters setObject:reson forKey:@"r_type"];
}
// MARK: --MineFeedBackIdeaTableViewCellDelegate--
- (void)sendIdeaToController:(NSString *)idea{
    [_parameters setObject:idea forKey:@"r_context"];
}
// MARK: --MineFeedBackPictureTableViewCellDelegate--
- (void)chooseImage{
    self.cameraView.hidden = NO;
}
- (KGCamera *)cameraView{
    if (!_cameraView) {
        _cameraView = [[KGCamera alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _cameraView.delegate = self;
        [self.navigationController.view addSubview:_cameraView];
    }
    return _cameraView;
}
//MARK:--KGCameraDelegate--
/**
 本地上传
 */
- (void)touchPhoto{
    ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc]init];
    ac.maxSelectCount = 3;
    ac.allowSelectGif = NO;
    ac.allowSelectVideo = NO;
    ac.allowSelectImage = YES;
    ac.sender = self;
    __weak typeof(self) mySelf = self;
    [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        [MBProgressHUD showHUDAddedTo:mySelf.view animated:YES];
        for (int i = 0; i < images.count; i++) {
            [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:[[KGQiniuUploadManager shareInstance] getImagePath:images[i]] fileName:nil result:^(NSString *strPath) {
                [mySelf.photoArr addObject:strPath];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
                [mySelf.listView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
                [MBProgressHUD hideAllHUDsForView:mySelf.view animated:YES];
            }];
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
    camera.allowRecordVideo = NO;
    camera.sessionPreset = ZLCaptureSessionPreset1280x720;
    camera.maxRecordDuration = 10;
    camera.circleProgressColor = [UIColor redColor];
    camera.doneBlock = ^(UIImage *image , NSURL *videoUrl) {
        [MBProgressHUD showHUDAddedTo:mySelf.view animated:YES];
        [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:[[KGQiniuUploadManager shareInstance] getImagePath:image] fileName:nil result:^(NSString *strPath) {
            [mySelf.photoArr addObject:strPath];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
            [mySelf.listView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
            [MBProgressHUD hideAllHUDsForView:mySelf.view animated:YES];
        }];
    };
    [self presentViewController:camera animated:YES completion:nil];
    self.cameraView.hidden = YES;
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
