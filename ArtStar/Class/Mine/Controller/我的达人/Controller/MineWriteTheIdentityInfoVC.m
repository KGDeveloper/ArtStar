//
//  MineWriteTheIdentityInfoVC.m
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineWriteTheIdentityInfoVC.h"
#import "MineChooseIndustryTableViewCell.h"
#import "MineUnitAndPositionTableViewCell.h"
#import "MinePushIDCardTableViewCell.h"
#import "MineTheIdentityJoinTableViewCell.h"
#import "MineWorksIndustryView.h"

@interface MineWriteTheIdentityInfoVC ()<UITableViewDelegate,UITableViewDataSource,MineChooseIndustryTableViewCellDelegate,MineUnitAndPositionTableViewCellDelegate,MinePushIDCardTableViewCellDelegate,KGCameraDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) MineWorksIndustryView *chooseWorks;
/**
 保存资料
 */
@property (nonatomic,strong) NSMutableDictionary *dataDic;
/**
 行业
 */
@property (nonatomic,copy) NSString *industryName;
/**
 选择拍照页面
 */
@property (nonatomic,strong) KGCamera *cameraView;
@property (nonatomic,copy) NSString *status;

@end

@implementation MineWriteTheIdentityInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"填写认证信息" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataDic = [NSMutableDictionary dictionary];
    [_dataDic setValuesForKeysWithDictionary:_msgDic];
    [_dataDic setObject:[KGUserInfo shareInterace].userID forKey:@"uid"];
    
    [self setTableView];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.scrollEnabled = NO;
    _listView.backgroundColor = Color_fafafa;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineChooseIndustryTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineChooseIndustryTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineUnitAndPositionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineUnitAndPositionTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MinePushIDCardTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MinePushIDCardTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineTheIdentityJoinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineTheIdentityJoinTableViewCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 60;
    }else if (indexPath.row == 1){
        return 111;
    }else if (indexPath.row == 4){
        return 70;
    }else{
        return 175;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MineChooseIndustryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineChooseIndustryTableViewCell"];
        cell.delegate = self;
        if (_industryName != nil) {
            cell.detailLab.text = _industryName;
        }
        return cell;
    }else if (indexPath.row == 1){
        MineUnitAndPositionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineUnitAndPositionTableViewCell"];
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 2){
        MinePushIDCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MinePushIDCardTableViewCell"];
        cell.delegate = self;
        cell.rightBtu.hidden = NO;
        if (_dataDic[@"identityCardFront"]) {
            [cell.leftBtu setImageWithURL:[NSURL URLWithString:_dataDic[@"identityCardFront"]] forState:UIControlStateNormal placeholder:nil];
        }
        if (_dataDic[@"identityCardContrary"]){
            [cell.rightBtu setImageWithURL:[NSURL URLWithString:_dataDic[@"identityCardContrary"]] forState:UIControlStateNormal placeholder:nil];
        }
        return cell;
    }else if (indexPath.row == 3){
        MinePushIDCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MinePushIDCardTableViewCell"];
        cell.titleLab.text = @"上传以下证件材料(例如工牌等)";
        [cell.leftBtu setImage:Image(@"职业证明材料") forState:UIControlStateNormal];
        cell.rightBtu.hidden = YES;
        cell.delegate = self;
        if (_dataDic[@"cARTEPROFESSIONELLE"]) {
            [cell.leftBtu setImageWithURL:[NSURL URLWithString:_dataDic[@"cARTEPROFESSIONELLE"]] forState:UIControlStateNormal placeholder:nil];
        }
        return cell;
    }else{
        MineTheIdentityJoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTheIdentityJoinTableViewCell"];
        cell.textLab.text = @"完成(2/2)";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        if (_dataDic[@"identityCardFront"]) {
            if (_dataDic[@"identityCardContrary"]) {
                if (_dataDic[@"cARTEPROFESSIONELLE"]) {
                    if (_dataDic[@"industry"]) {
                        [self requestData];
                    }else{
                        [MBProgressHUD bwm_showTitle:@"请选择所在行业" toView:self.view hideAfter:1];
                    }
                }else{
                    [MBProgressHUD bwm_showTitle:@"请添加证件材料" toView:self.view hideAfter:1];
                }
            }else{
                [MBProgressHUD bwm_showTitle:@"请添加身份证反面" toView:self.view hideAfter:1];
            }
        }else{
            [MBProgressHUD bwm_showTitle:@"请添加身份证正面" toView:self.view hideAfter:1];
        }
    }
}
- (void)requestData{
    [MBProgressHUD bwm_showHUDAddedTo:self.view title:@"正在保存上传..."];
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[KGUserInfo shareInterace].userTokenCode forKey:@"tokenCode"];
    [parameters setObject:_dataDic forKey:@"authentication"];
    [KGRequestNetWorking postWothUrl:saveCelestialBodyAttestation parameters:parameters succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"codeo"] integerValue] == 200) {
            [MBProgressHUD bwm_showTitle:@"保存成功,请等待审核！" toView:weakSelf.view hideAfter:1];
        }else{
            [MBProgressHUD bwm_showTitle:@"保存失败,请查看填写内容" toView:weakSelf.view hideAfter:1];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [MBProgressHUD bwm_showTitle:@"网络出错" toView:weakSelf.view hideAfter:1];
    }];
}
// MARK: --选择行业--
- (MineWorksIndustryView *)chooseWorks{
    if (!_chooseWorks) {
        _chooseWorks = [[MineWorksIndustryView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _chooseWorks.cancelStr = @"确定";
        __weak typeof(self) weakSelf = self;
        _chooseWorks.sendChooseworks = ^(NSString *name, NSString *ID) {
            [weakSelf.dataDic setObject:@([ID integerValue]) forKey:@"industry"];
            weakSelf.industryName = name;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [weakSelf.listView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [self.navigationController.view addSubview:_chooseWorks];
    }
    return _chooseWorks;
}
// MARK: --MineUnitAndPositionTableViewCellDelegate--
- (void)sendUnitPosition:(NSString *)unit position:(NSString *)position{
    if (unit != nil) {
        [_dataDic setObject:unit forKey:@"companyName"];
    }else{
        [_dataDic setObject:position forKey:@"position"];
    }
}
//MARK:--MineChooseIndustryTableViewCellDelegate--
- (void)showIndustryViewChooseJob{
    self.chooseWorks.hidden = NO;
}
// MARK: --MinePushIDCardTableViewCellDelegate--
- (void)chooseImage:(NSString *)btu{
    _status = btu;
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
    ac.maxSelectCount = 1;
    ac.allowSelectGif = NO;
    ac.allowSelectVideo = NO;
    ac.allowSelectImage = YES;
    ac.sender = self;
    __weak typeof(self) mySelf = self;
    [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        [MBProgressHUD showHUDAddedTo:mySelf.view animated:YES];
        if ([mySelf.status isEqualToString:@"正面"]) {
            [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:[[KGQiniuUploadManager shareInstance] getImagePath:[images firstObject]] fileName:nil result:^(NSString *strPath) {
                [mySelf.dataDic setObject:strPath forKey:@"identityCardFront"];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
                [mySelf.listView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
                [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
            }];
        }else if ([mySelf.status isEqualToString:@"反面"]){
            [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:[[KGQiniuUploadManager shareInstance] getImagePath:[images firstObject]] fileName:nil result:^(NSString *strPath) {
                [mySelf.dataDic setObject:strPath forKey:@"identityCardContrary"];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
                [mySelf.listView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
                [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
            }];
        }else{
            [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:[[KGQiniuUploadManager shareInstance] getImagePath:[images firstObject]] fileName:nil result:^(NSString *strPath) {
                [mySelf.dataDic setObject:strPath forKey:@"cARTEPROFESSIONELLE"];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
                [mySelf.listView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
                [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
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
        if ([mySelf.status isEqualToString:@"正面"]) {
            [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:[[KGQiniuUploadManager shareInstance] getImagePath:image] fileName:nil result:^(NSString *strPath) {
                [mySelf.dataDic setObject:strPath forKey:@"identityCardFront"];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
                [mySelf.listView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
                [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
            }];
        }else if ([mySelf.status isEqualToString:@"反面"]){
            [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:[[KGQiniuUploadManager shareInstance] getImagePath:image] fileName:nil result:^(NSString *strPath) {
                [mySelf.dataDic setObject:strPath forKey:@"identityCardContrary"];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
                [mySelf.listView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
                [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
            }];
        }else{
            [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:[[KGQiniuUploadManager shareInstance] getImagePath:image] fileName:nil result:^(NSString *strPath) {
                [mySelf.dataDic setObject:strPath forKey:@"cARTEPROFESSIONELLE"];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
                [mySelf.listView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
                [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
            }];
        }
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
