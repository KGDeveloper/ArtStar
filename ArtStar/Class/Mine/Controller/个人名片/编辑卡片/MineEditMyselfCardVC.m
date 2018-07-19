//
//  MineEditMyselfCardVC.m
//  ArtStar
//
//  Created by abc on 6/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MineEditMyselfCardVC.h"
#import "MineEditVCChooseImageView.h"
#import "MineEditMyselfInfoEditCell.h"
#import "MineCenterMyCoverCell.h"
#import "MineSchoolAndWorksCell.h"
#import "MineEditMyLabelCell.h"
#import "MineLoveMoviesAndMusicAndBooksCell.h"
#import "MineWordLoveFoodsCell.h"
#import "DatePickerView.h"
#import "MineChooseWeightAndHeightView.h"
#import "MineWorksIndustryView.h"

#import "MineLoadCoverVC.h"
#import "MineChooseMyHomeVC.h"
#import "MineMySelfWordVC.h"
#import "MineMyselfWordChooseYourLoveVC.h"
#import "MineMyselfLabelVC.h"

#import "MineCenterHometownModel.h"

@interface MineEditMyselfCardVC ()
<UITableViewDelegate,
UITableViewDataSource,
MineEditMyselfInfoEditCellDelegate,
KGCameraDelegate,
DatePickerViewDelegate,
MineCenterMyCoverCellDelegate,
MineSchoolAndWorksCellDelegate,
MineEditMyLabelCellDelegate,
MineLoveMoviesAndMusicAndBooksCellDelegate,
UITextFieldDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) KGCamera *cameraView;
@property (nonatomic,assign) BOOL isChooseHeaderIamge;
@property (nonatomic,assign) BOOL isCoverImage;
@property (nonatomic,strong) DatePickerView *dataPickView;
@property (nonatomic,strong) MineChooseWeightAndHeightView *chooseWeightView;
@property (nonatomic,strong) MineWorksIndustryView *worksIndustryView;

@property (nonatomic,strong) NSMutableDictionary *userInfoDic;
@property (nonatomic,strong) NSMutableArray *userMusicDic;
@property (nonatomic,copy) NSString *coverImage;//:--封面--
@property (nonatomic,copy) NSString *coverNowImage;
@property (nonatomic,copy) NSString *headerImage;//:--头像--
@property (nonatomic,strong) NSMutableArray *imageUris;//:--保存选择的图片--
@property (nonatomic,strong) NSMutableArray *imageUrisHttp;//:--保存选择的图片地址--
@property (nonatomic,strong) NSMutableArray *headerImageArr;//:--保存选择的图片地址--
@property (nonatomic,strong) NSMutableArray *mylabelArr;//:--我的标签--
@property (nonatomic,strong) NSMutableArray *mylabelChooseArr;//:--我的标签--

@property (nonatomic,strong) UITextField *cellText;
//MARK:--------------------------------------喜欢的--------------------------------------------------
@property (nonatomic,strong) NSMutableArray *loveBooks;//:--我的标签--
@property (nonatomic,strong) NSMutableArray *loveMovies;//:--我的标签--


@end

@implementation MineEditMyselfCardVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"编辑名片" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"保存" image:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _isChooseHeaderIamge = NO;
    _isCoverImage = NO;
    
    _userInfoDic = [NSMutableDictionary dictionary];
    _userMusicDic = [NSMutableArray array];
    _imageUris = [NSMutableArray array];
    _imageUrisHttp = [NSMutableArray array];
    _headerImageArr = [NSMutableArray array];
    _mylabelArr = [NSMutableArray array];
    _loveBooks = [NSMutableArray array];
    _loveMovies = [NSMutableArray array];
    NSArray *array = _model.mylabels;
    for (int i = 0; i < array.count; i++) {
        NSDictionary *dic = array[i];
        [_mylabelArr addObject:@{@"name":dic[@"name"],@"id":dic[@"id"]}];
    }
    NSArray *tmp = _model.imageUris;
    for (int i = 0; i < tmp.count; i++) {
        MineSelfCenterImageLIstModel *model = [MineSelfCenterImageLIstModel mj_objectWithKeyValues:tmp[i]];
        if ([model.iscover integerValue] == 1) {
            if (model.imageURL.length > 0 && model.imageURL != nil) {
                _coverNowImage = model.imageURL;
            }else{
                 _coverNowImage = @"http://img.zcool.cn/community/014dda5548dc320000019ae9402052.jpg@1280w_1l_2o_100sh.jpg";
            }
        }
    }
    [self setTableView];
    
}

- (void)rightNavBtuAction:(UIButton *)sender{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) mySelf = self;
    if (_imageUris.count > 0) {
        for (int i = 0; i < _imageUris.count ; i++) {
            [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:_imageUris[i] fileName:nil result:^(NSString *strPath) {
                NSDictionary *dic = @{@"imageURL":strPath,@"iscover":@"0"};
                [mySelf.imageUrisHttp addObject:dic];
                if (mySelf.imageUrisHttp.count == mySelf.imageUris.count) {
                    [mySelf uploadData];
                }
            }];
        }
    }else{
        [self uploadData];
    }
}

- (void)uploadData{
    __weak typeof(self) mySelf = self;
    if (_imageUrisHttp.count > 0) {
        [_userInfoDic setObject:_imageUrisHttp forKey:@"imageUris"];
    }
    if (_mylabelChooseArr.count > 0) {
        [_userInfoDic setObject:_mylabelChooseArr forKey:@"mylabels"];
    }
    [_userInfoDic setObject:_model.username forKey:@"username"];
    if (_model.personSignature != nil || _model.personSignature != NULL) {
        [_userInfoDic setObject:_model.personSignature forKey:@"personSignature"];
    }
    if (_model.school != nil || _model.school != NULL) {
        [_userInfoDic setObject:_model.school forKey:@"school"];
    }
    [KGRequestNetWorking postWothUrl:editPerBnsCard parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"user":_userInfoDic,@"userMovice":_loveMovies,@"userMusic":_userMusicDic,@"userBook":_loveBooks} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            if (mySelf.refreshCenterListView) {
                mySelf.refreshCenterListView();
            }
            [mySelf.navigationController popViewControllerAnimated:YES];
        }
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    }];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableHeaderView = [self setTableViewHeader];
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineEditMyselfInfoEditCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineEditMyselfInfoEditCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineCenterMyCoverCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineCenterMyCoverCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineSchoolAndWorksCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineSchoolAndWorksCell"];
    [_listView registerClass:[MineEditMyLabelCell class] forCellReuseIdentifier:@"MineEditMyLabelCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineLoveMoviesAndMusicAndBooksCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineLoveMoviesAndMusicAndBooksCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineWordLoveFoodsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineWordLoveFoodsCell"];
    
}
//MARK:--------------------------------------创建头视图选择照片--------------------------------------------------
- (UIView *)setTableViewHeader{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 175)];
    NSArray *tmp = _model.imageUris;
    for (int i = 0; i < tmp.count; i++) {
        MineSelfCenterImageLIstModel *model = [MineSelfCenterImageLIstModel mj_objectWithKeyValues:tmp[i]];
        if ([model.iscover integerValue] == 0) {
            [_headerImageArr addObject:model];
        }
    }
    for (int i = 0; i < 3; i++) {
        MineEditVCChooseImageView *chooseView = [[MineEditVCChooseImageView alloc]initWithFrame:CGRectMake(15 + (kScreenWidth - 30 - 315)/2*i + 105*i, 10, 105, 140)];
        if (i < _headerImageArr.count) {
            MineSelfCenterImageLIstModel *model = [MineSelfCenterImageLIstModel mj_objectWithKeyValues:_headerImageArr[i]];
            chooseView.model = model;
        }
        __weak typeof(self) mySelf = self;
        chooseView.sendChooseFileToController = ^(NSString *fileStr) {
            [mySelf.imageUris addObject:fileStr];
        };
        chooseView.deleteChooseFileFromArr = ^(NSString *fileStr) {
            [mySelf.imageUris removeObject:fileStr];
        };
        [headerView addSubview:chooseView];
    }
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 475;
    }else if(indexPath.row == 1){
        return (kScreenWidth - 30)/690*534 + 65;
    }else if (indexPath.row == 2){
        return 155;
    }else if(indexPath.row == 3){
        MineEditMyLabelCell *cell = [MineEditMyLabelCell new];
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < self.mylabelArr.count; i++) {
            NSDictionary *dic = self.mylabelArr[i];
            [arr addObject:dic[@"name"]];
        }
        return [cell arrayToHeight:arr.copy];
    }else if(indexPath.row == 4){
        return 770;
    }else{
        return 555;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MineEditMyselfInfoEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineEditMyselfInfoEditCell"];
        cell.nikNameTF.text = _model.username;
        cell.brithdayLab.text = [NSString stringWithFormat:@"%@  %@",_model.birthday,_model.constellation];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:_model.portraitUri]];
        cell.heightLab.text = [NSString stringWithFormat:@"%@cm",_model.stature];
        cell.weightLab.text = [NSString stringWithFormat:@"%@KG",_model.weight];
        cell.introudceTF.text = _model.personSignature;
        MineCenterHometownModel *model = [MineCenterHometownModel mj_objectWithKeyValues:_model.hometown];
        cell.homeLab.text = [NSString stringWithFormat:@"%@-%@-%@",model.country,model.province,model.city];
        cell.delegate = self;
        return cell;
    }else if(indexPath.row == 1){
        MineCenterMyCoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCenterMyCoverCell"];
        [cell.coverImage sd_setImageWithURL:[NSURL URLWithString:_coverNowImage]];
        cell.delegate = self;
        return cell;
    }else if(indexPath.row == 2){
        MineSchoolAndWorksCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSchoolAndWorksCell"];
        cell.delegate = self;
        NSDictionary *dic = [_model.industries firstObject];
        cell.workName.text = dic[@"name"];
        cell.schoolName.text = _model.school;
        cell.schoolName.delegate = self;
        _cellText = cell.schoolName;
        return cell;
    }else if(indexPath.row == 3){
        MineEditMyLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineEditMyLabelCell"];
        cell.delegate = self;
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < self.mylabelArr.count; i++) {
            NSDictionary *dic = self.mylabelArr[i];
            [arr addObject:dic[@"name"]];
        }
        cell.titleArr = arr.copy;
        if (arr.count > 0) {
            [cell showLabel];
        }else{
            [cell hidenLabel];
        }
        return cell;
    }else if(indexPath.row == 4){
        MineLoveMoviesAndMusicAndBooksCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineLoveMoviesAndMusicAndBooksCell"];
        cell.bookArr = _model.userBooks;
        cell.moviesArr = _model.userMovices;
        cell.delegate = self;
        return cell;
    }else{
        MineWordLoveFoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineWordLoveFoodsCell"];
        NSArray *arr = _model.mywords;
        __block NSMutableArray *tmpfoodArr = [NSMutableArray array];
        __block NSMutableArray *tmpsportArr = [NSMutableArray array];
        __block NSMutableArray *tmpleiArr = [NSMutableArray array];
        __block NSMutableArray *tmpfootpointArr = [NSMutableArray array];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *tmpDic = obj;
            if ([tmpDic[@"pid"] integerValue] == 4) {
                [tmpfoodArr addObject:tmpDic];
            }else if ([tmpDic[@"pid"] integerValue] == 5){
                [tmpsportArr addObject:tmpDic];
            }else if ([tmpDic[@"pid"] integerValue] == 6){
                [tmpleiArr addObject:tmpDic];
            }else if ([tmpDic[@"pid"] integerValue] == 7){
                [tmpfootpointArr addObject:tmpDic];
            }
        }];
        
        [cell addArray:tmpfoodArr toView:cell.foodView];
        [cell addArray:tmpsportArr toView:cell.sportView];
        [cell addArray:tmpleiArr toView:cell.typeView];
        [cell addArray:tmpfootpointArr toView:cell.footView];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        self.cameraView.hidden = NO;
        _isCoverImage = YES;
    }else if (indexPath.row == 5){
        MineMySelfWordVC *wordVC = [[MineMySelfWordVC alloc]init];
        __weak typeof(self) mySelf = self;
        wordVC.myWords = _model.mywords;
        wordVC.sendChooseWords = ^(NSArray *foodArr, NSArray *spotArr, NSArray *leisureArr, NSArray *footPointArr) {
            NSMutableArray *arr = [NSMutableArray arrayWithArray:foodArr];
            [arr addObjectsFromArray:spotArr];
            [arr addObjectsFromArray:leisureArr];
            [arr addObjectsFromArray:footPointArr];
            [mySelf.userInfoDic setObject:arr forKey:@"mywords"];
        };
        [self pushNoTabBarViewController:wordVC animated:YES];
    }
}
//MARK:--------------------------------------MineEditMyselfInfoEditCellDelegate--------------------------------------------------
- (void)sendIntroudceToController:(NSString *)introudce{
    _model.personSignature = introudce;
}
- (void)sendNikNameToController:(NSString *)nikName{
    _model.username = nikName;
}
- (void)touchUITableViewCellMakeSomeThingWithTitle:(NSString *)title{
    if ([title isEqualToString:@"头像"]) {
        self.cameraView.hidden = NO;
        self.isChooseHeaderIamge = YES;
    }else if ([title isEqualToString:@"生日"]){
        self.dataPickView.hidden = NO;
    }else if ([title isEqualToString:@"身高"]){
        self.chooseWeightView.hidden = NO;
        self.chooseWeightView.minValue = 0;
        self.chooseWeightView.maxValue = 300;
        self.chooseWeightView.unitStr = @"cm";
        self.chooseWeightView.type = ChooseHeight;
    }else if ([title isEqualToString:@"体重"]){
        self.chooseWeightView.hidden = NO;
        self.chooseWeightView.minValue = 0;
        self.chooseWeightView.maxValue = 300;
        self.chooseWeightView.unitStr = @"kg";
        self.chooseWeightView.type = ChooseWeight;
    }else{
        MineChooseMyHomeVC *homeVC = [[MineChooseMyHomeVC alloc]init];
        __weak typeof(self) mySelf = self;
        homeVC.chooseHomeTwon = ^(NSString *country, NSString *provices, NSString *city) {
            mySelf.model.hometown = @{@"country":country,@"province":provices,@"city":city};
            [mySelf.userInfoDic setObject:@{@"country":country,@"province":provices,@"city":city} forKey:@"hometown"];
        };
        [self pushNoTabBarViewController:homeVC animated:YES];
    }
}
- (KGCamera *)cameraView{
    if (!_cameraView) {
        _cameraView = [[KGCamera alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _cameraView.delegate = self;
        [self.navigationController.view addSubview:_cameraView];
    }
    return _cameraView;
}
//MARK:------------------------------------------KGCameraDelegate----------------------------------------------
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
        if (mySelf.isCoverImage == YES) {
            mySelf.isCoverImage = NO;
            mySelf.coverImage = [[KGQiniuUploadManager shareInstance] getImagePath:[images firstObject]];
            [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:mySelf.coverImage fileName:nil result:^(NSString *strPath) {
                NSDictionary *dic = @{@"imageURL":strPath,@"iscover":@"1"};
                mySelf.coverNowImage = strPath;
                [mySelf.imageUrisHttp addObject:dic];
            }];
        }else if (mySelf.isChooseHeaderIamge == YES){
            mySelf.isChooseHeaderIamge = NO;
            mySelf.headerImage = [[KGQiniuUploadManager shareInstance] getImagePath:[images firstObject]];
            [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:mySelf.headerImage fileName:nil result:^(NSString *strPath) {
                mySelf.model.portraitUri = strPath;
                [mySelf.userInfoDic setObject:strPath forKey:@"portraitUri"];
            }];
        }
        NSIndexPath *dex = [NSIndexPath indexPathForRow:0 inSection:0];
        [mySelf.listView reloadRowAtIndexPath:dex withRowAnimation:UITableViewRowAnimationAutomatic];
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
        if (mySelf.isCoverImage == YES) {
            mySelf.isCoverImage = NO;
            mySelf.coverImage = [[KGQiniuUploadManager shareInstance] getImagePath:image];
            [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:mySelf.coverImage fileName:nil result:^(NSString *strPath) {
                mySelf.coverNowImage = strPath;
                NSDictionary *dic = @{@"imageURL":strPath,@"iscover":@"1"};
                [mySelf.imageUrisHttp addObject:dic];
            }];
        }else if (mySelf.isChooseHeaderIamge == YES){
            mySelf.isChooseHeaderIamge = NO;
            mySelf.headerImage = [[KGQiniuUploadManager shareInstance] getImagePath:image];
            [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:mySelf.headerImage fileName:nil result:^(NSString *strPath) {
                mySelf.model.portraitUri = strPath;
                [mySelf.userInfoDic setObject:strPath forKey:@"portraitUri"];
            }];
        }
        NSIndexPath *dex = [NSIndexPath indexPathForRow:0 inSection:0];
        [mySelf.listView reloadRowAtIndexPath:dex withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    [self presentViewController:camera animated:YES completion:nil];
    self.cameraView.hidden = YES;
}
//MARK:--根据日期判断星座--
-(NSString *)getAstroWithMonth:(int)m day:(int)d{
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    if (m<1||m>12||d<1||d>31){return @"错误日期格式!";}
    if(m==2 && d>29){return @"错误日期格式!";}
    else if(m==4 || m==6 || m==9 || m==11) {
        if (d>30) {return @"错误日期格式!!!";}
    }
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    return result;
}
//MARK:--日期选择器--
- (DatePickerView *)dataPickView{
    if (!_dataPickView) {
        _dataPickView = [[DatePickerView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 250 - NavButtomHeight, kScreenWidth, 250)];
        _dataPickView.hidden = YES;
        _dataPickView.delegate = self;
        [self.view addSubview:_dataPickView];
    }
    return _dataPickView;
}
- (void)getSelectDate:(NSString *)date type:(DateType)type{
    NSInteger year = [[date componentsSeparatedByString:@"/"][0] integerValue];
    NSInteger month = [[date componentsSeparatedByString:@"/"][1] integerValue];
    NSInteger day = [[date componentsSeparatedByString:@"/"][2] integerValue];
    NSString *birthday = [date stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    NSString *starStr = [self getAstroWithMonth:(int)month day:(int)day];
    _model.birthday = birthday;
    _model.constellation = [NSString stringWithFormat:@"%@座",starStr];
    [_userInfoDic setObject:birthday forKey:@"birthday"];
    [_userInfoDic setObject:[NSString stringWithFormat:@"%@座",starStr] forKey:@"constellation"];
    NSIndexPath *dex = [NSIndexPath indexPathForRow:0 inSection:0];
    [_listView reloadRowAtIndexPath:dex withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (MineChooseWeightAndHeightView *)chooseWeightView{
    if (!_chooseWeightView) {
        _chooseWeightView = [[MineChooseWeightAndHeightView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        __weak typeof(self) mySelf = self;
        _chooseWeightView.sendValueToController = ^(ChooseType type, NSString *value) {
            switch (type) {
                case ChooseHeight:
                    //:--身高--
                    mySelf.model.stature = @([value integerValue]);
                    [mySelf.userInfoDic setObject:@([value integerValue]) forKey:@"stature"];
                    break;
                    
                default:
                    //:--体重--
                    mySelf.model.weight = @([value integerValue]);
                    [mySelf.userInfoDic setObject:@([value integerValue]) forKey:@"weight"];
                    break;
            }
            NSIndexPath *dex = [NSIndexPath indexPathForRow:0 inSection:0];
            [mySelf.listView reloadRowAtIndexPath:dex withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [self.navigationController.view addSubview:_chooseWeightView];
    }
    return _chooseWeightView;
}
//MARK:----------------------------------------MineCenterMyCoverCellDelegate------------------------------------------------
- (void)pushControllerLoadResult{
    MineLoadCoverVC *vc = [[MineLoadCoverVC alloc]init];
    vc.coverImage = _coverNowImage;
    [self pushNoTabBarViewController:vc animated:YES];
}
//MARK:------------------------------------选择行业----------------------------------------------------
- (MineWorksIndustryView *)worksIndustryView{
    if (!_worksIndustryView) {
        _worksIndustryView = [[MineWorksIndustryView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        __weak typeof(self) mySelf = self;
        _worksIndustryView.cancelStr = @"确定";
        _worksIndustryView.sendChooseworks = ^(NSString *name, NSString *ID) {
            dispatch_queue_t deleteQueue = dispatch_queue_create("请求删除旧行业", DISPATCH_QUEUE_SERIAL);
            dispatch_sync(deleteQueue, ^{
                NSDictionary *dic = [mySelf.model.industries firstObject];
                if (dic[@"id"] != nil) {
                    [KGRequestNetWorking postWothUrl:industrydeleteByid parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":dic[@"id"]} succ:^(id result) {
                        
                    } fail:^(NSError *error) {
                        
                    }];
                }
            });
            mySelf.model.industries = @[@{@"name":name,@"id":ID}];
            NSDictionary *dic = [mySelf.model.industries firstObject];
            if (dic != nil) {
                [mySelf.userInfoDic setObject:@[@{@"id":dic[@"id"]}] forKey:@"industries"];
            }
            NSIndexPath *dex = [NSIndexPath indexPathForRow:2 inSection:0];
            [mySelf.listView reloadRowAtIndexPath:dex withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [self.navigationController.view addSubview:_worksIndustryView];
    }
    return _worksIndustryView;
}
//MARK:--------------------------------------MineSchoolAndWorksCellDelegate--------------------------------------------------
- (void)showWorksIndutryView{
    self.worksIndustryView.hidden = NO;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _cellText) {
        _model.school = _cellText.text;
        NSIndexPath *dex = [NSIndexPath indexPathForRow:2 inSection:0];
        [_listView reloadRowAtIndexPath:dex withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
//MARK:---------------------------------------MineEditMyLabelCellDelegate-------------------------------------------------
- (void)pushMyWordViewController{
    MineMyselfLabelVC *myLabel = [[MineMyselfLabelVC alloc]init];
    myLabel.dataArr = self.mylabelArr.copy;
    __weak typeof(self) mySelf = self;
    mySelf.mylabelChooseArr = [NSMutableArray array];
    myLabel.sendChooseArr = ^(NSArray *myLabels) {
        for (int i = 0; i < myLabels.count; i++) {
            NSDictionary *dic = myLabels[i];
            if (mySelf.mylabelArr.count > 0) {
                __block BOOL isHave = NO;
                [mySelf.mylabelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isEqual:dic]) {//:--判断是否是请求下来的--
                        isHave = YES;
                        *stop = YES;
                    }
                }];
                if (isHave == NO) {
                    [mySelf.mylabelArr addObject:dic];
                    for (int i = 0; i < mySelf.mylabelChooseArr.count; i++) {
                        NSDictionary *tmp = mySelf.mylabelChooseArr[i];
                        if ([tmp isEqual:dic]) {//:--判断是否第一次跳转已经添加了--
                            break;
                        }else{
                            [mySelf.mylabelChooseArr addObject:dic];
                        }
                    }
                }
            }else{
                mySelf.mylabelArr = [NSMutableArray arrayWithArray:myLabels];
                mySelf.mylabelChooseArr = [NSMutableArray arrayWithArray:myLabels];
        }
        }
        NSIndexPath *dex = [NSIndexPath indexPathForRow:3 inSection:0];
        [mySelf.listView reloadRowAtIndexPath:dex withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    [self pushNoTabBarViewController:myLabel animated:YES];
}
//MARK:----------------------------------------MineLoveMoviesAndMusicAndBooksCellDelegate------------------------------------------------
- (void)pushToViewControllerChooseYourLove:(NSString *)title{
    MineMyselfWordChooseYourLoveVC *chooseVC = [[MineMyselfWordChooseYourLoveVC alloc]init];
    __weak typeof(self) mySelf = self;
    if ([title isEqualToString:@"电影"]) {
        chooseVC.titleStr = @"喜欢的电影";
        chooseVC.oldArr = _model.userMovices;
        chooseVC.sendYourLoveArr = ^(NSArray *dataArr) {
            for (int i = 0; i < dataArr.count; i++) {
                NSDictionary *dic = dataArr[i];
                if (mySelf.model.userMovices.count > 0) {
                    for (NSDictionary *obj in mySelf.model.userMovices) {
                        if ([dic isEqual:obj]) {
                            break;
                        }else{
                            if (mySelf.loveMovies.count > 0) {
                                for (NSDictionary *tmpObj in mySelf.loveMovies) {
                                    if ([dic isEqual:tmpObj]) {
                                        break;
                                    }else{
                                        [mySelf.loveMovies addObject:dic];
                                    }
                                }
                            }
                        }
                    }
                }else{
                    if (mySelf.loveMovies.count > 0) {
                        [mySelf.loveMovies enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([dic isEqual:obj]) {
                                *stop = YES;
                            }else{
                                [mySelf.loveMovies addObject:dic];
                            }
                        }];
                    }else{
                        [mySelf.loveMovies addObject:dic];
                    }
                }
            }
            mySelf.model.userMovices = dataArr;
            NSIndexPath *dex = [NSIndexPath indexPathForRow:4 inSection:0];
            [mySelf.listView reloadRowAtIndexPath:dex withRowAnimation:UITableViewRowAnimationAutomatic];
        };
    }else if ([title isEqualToString:@"音乐"]){
        chooseVC.titleStr = @"喜欢的音乐";
    }else{
        chooseVC.titleStr = @"喜欢的书籍";
        chooseVC.oldArr = _model.userBooks;
        chooseVC.sendYourLoveArr = ^(NSArray *dataArr) {
            for (int i = 0; i < dataArr.count; i++) {
                NSDictionary *dic = dataArr[i];
                if (mySelf.model.userBooks.count > 0) {
                    for (NSDictionary *obj in mySelf.model.userBooks) {
                        if ([dic isEqual:obj]) {break;}else{
                            if (mySelf.loveBooks.count > 0) {
                                for (NSDictionary *newObj in mySelf.loveBooks) {
                                    if ([dic isEqual:newObj]) {break;}else{[mySelf.loveBooks addObject:dic];}
                                }
                            }
                        }
                    }
                }else{
                    if (mySelf.loveBooks.count > 0) {
                        [mySelf.loveBooks enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([dic isEqual:obj]) {*stop = YES;}else{[mySelf.loveBooks addObject:dic];}
                        }];
                    }else{
                        [mySelf.loveBooks addObject:dic];
                    }
                }
            }
            mySelf.model.userBooks = dataArr;
            NSIndexPath *dex = [NSIndexPath indexPathForRow:4 inSection:0];
            [mySelf.listView reloadRowAtIndexPath:dex withRowAnimation:UITableViewRowAnimationAutomatic];
        };
    }
    [self pushNoTabBarViewController:chooseVC animated:YES];
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
