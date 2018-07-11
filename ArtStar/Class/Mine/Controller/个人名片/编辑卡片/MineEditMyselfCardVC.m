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
MineLoveMoviesAndMusicAndBooksCellDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) KGCamera *cameraView;
@property (nonatomic,assign) BOOL isChooseHeaderIamge;
@property (nonatomic,assign) BOOL isCoverImage;
@property (nonatomic,strong) DatePickerView *dataPickView;
@property (nonatomic,strong) MineChooseWeightAndHeightView *chooseWeightView;
@property (nonatomic,strong) MineWorksIndustryView *worksIndustryView;

@property (nonatomic,strong) NSMutableDictionary *userInfoDic;
@property (nonatomic,strong) NSMutableArray *userMusicDic;
@property (nonatomic,strong) NSMutableArray *userMoviceDic;
@property (nonatomic,strong) NSMutableArray *userBookDic;
@property (nonatomic,copy) NSString *coverImage;//:--封面--
@property (nonatomic,copy) NSString *headerImage;//:--头像--
@property (nonatomic,strong) NSMutableArray *imageUris;//:--保存选择的图片--
@property (nonatomic,strong) NSMutableArray *imageUrisHttp;//:--保存选择的图片地址--
@property (nonatomic,strong) NSMutableArray *headerImageArr;//:--保存选择的图片地址--

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
    _userMoviceDic = [NSMutableArray array];
    _userBookDic = [NSMutableArray array];
    _imageUris = [NSMutableArray array];
    _imageUrisHttp = [NSMutableArray array];
    _headerImageArr = [NSMutableArray array];
    
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
    [_userInfoDic setObject:_imageUrisHttp forKey:@"imageUris"];
    [_userInfoDic setObject:_model.username forKey:@"username"];
    [KGRequestNetWorking postWothUrl:editPerBnsCard parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"user":_userInfoDic,@"userMovice":_userMoviceDic,@"userMusic":_userMusicDic,@"userBook":_userBookDic} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            if (mySelf.refreshCenterListView) {
                mySelf.refreshCenterListView();
            }
            [mySelf.navigationController popViewControllerAnimated:YES];
        }
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    } fail:^(NSString *error) {
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
        return 50;
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
        NSArray *tmp = _model.imageUris;
        for (int i = 0; i < tmp.count; i++) {
            MineSelfCenterImageLIstModel *model = [MineSelfCenterImageLIstModel mj_objectWithKeyValues:tmp[i]];
            if ([model.iscover integerValue] == 1) {
                [cell.coverImage sd_setImageWithURL:[NSURL URLWithString:model.imageURL]];
            }
        }
        cell.delegate = self;
        return cell;
    }else if(indexPath.row == 2){
        MineSchoolAndWorksCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSchoolAndWorksCell"];
        cell.delegate = self;
        return cell;
    }else if(indexPath.row == 3){
        MineEditMyLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineEditMyLabelCell"];
        cell.delegate = self;
        [cell hidenLabel];
        return cell;
    }else if(indexPath.row == 4){
        MineLoveMoviesAndMusicAndBooksCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineLoveMoviesAndMusicAndBooksCell"];
        cell.delegate = self;
        return cell;
    }else{
        MineWordLoveFoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineWordLoveFoodsCell"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        self.cameraView.hidden = NO;
        _isCoverImage = YES;
    }else if (indexPath.row == 5){
        MineMySelfWordVC *wordVC = [[MineMySelfWordVC alloc]init];
        [self pushNoTabBarViewController:wordVC animated:YES];
    }
}
//MARK:--------------------------------------MineEditMyselfInfoEditCellDelegate--------------------------------------------------
- (void)sendIntroudceToController:(NSString *)introudce{
    [_userInfoDic setObject:introudce forKey:@"personSignature"];
}
- (void)sendNikNameToController:(NSString *)nikName{
    [_userInfoDic setObject:nikName forKey:@"username"];
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
        [mySelf.listView reloadData];
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
        [mySelf.listView reloadData];
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
    [_listView reloadData];
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
            [mySelf.listView reloadData];
        };
        [self.navigationController.view addSubview:_chooseWeightView];
    }
    return _chooseWeightView;
}
//MARK:----------------------------------------MineCenterMyCoverCellDelegate------------------------------------------------
- (void)pushControllerLoadResult{
    [self pushNoTabBarViewController:[[MineLoadCoverVC alloc]init] animated:YES];
}
//MARK:------------------------------------选择行业----------------------------------------------------
- (MineWorksIndustryView *)worksIndustryView{
    if (!_worksIndustryView) {
        _worksIndustryView = [[MineWorksIndustryView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.navigationController.view addSubview:_worksIndustryView];
    }
    return _worksIndustryView;
}
//MARK:--------------------------------------MineSchoolAndWorksCellDelegate--------------------------------------------------
- (void)showWorksIndutryView{
    self.worksIndustryView.hidden = NO;
}
//MARK:---------------------------------------MineEditMyLabelCellDelegate-------------------------------------------------
- (void)pushMyWordViewController{
    MineMyselfLabelVC *myLabel = [[MineMyselfLabelVC alloc]init];
    __weak typeof(self) mySelf = self;
    myLabel.sendChooseArr = ^(NSArray *myLabels) {
        
    };
    [self pushNoTabBarViewController:myLabel animated:YES];
}
//MARK:----------------------------------------MineLoveMoviesAndMusicAndBooksCellDelegate------------------------------------------------
- (void)pushToViewControllerChooseYourLove:(NSString *)title{
    if ([title isEqualToString:@"电影"]) {
        MineMyselfWordChooseYourLoveVC *chooseVC = [[MineMyselfWordChooseYourLoveVC alloc]init];
        chooseVC.titleStr = @"喜欢的电影";
        [self pushNoTabBarViewController:chooseVC animated:YES];
    }else if ([title isEqualToString:@"音乐"]){
        MineMyselfWordChooseYourLoveVC *chooseVC = [[MineMyselfWordChooseYourLoveVC alloc]init];
        chooseVC.titleStr = @"喜欢的音乐";
        [self pushNoTabBarViewController:chooseVC animated:YES];
    }else{
        MineMyselfWordChooseYourLoveVC *chooseVC = [[MineMyselfWordChooseYourLoveVC alloc]init];
        chooseVC.titleStr = @"喜欢的书籍";
        [self pushNoTabBarViewController:chooseVC animated:YES];
    }
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
