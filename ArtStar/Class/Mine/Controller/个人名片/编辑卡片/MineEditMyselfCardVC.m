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

@property (nonatomic,strong) NSMutableDictionary *userDic;
@property (nonatomic,strong) NSMutableArray *userMusicDic;
@property (nonatomic,strong) NSMutableArray *userMoviceDic;
@property (nonatomic,strong) NSMutableArray *userBookDic;

@property (nonatomic,copy) NSString *oneImage;

@end

@implementation MineEditMyselfCardVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"编辑名片" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"保存" image:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _isChooseHeaderIamge = NO;
    _isCoverImage = NO;
    
    _userDic = [NSMutableDictionary dictionary];
    _userMusicDic = [NSMutableArray array];
    _userMoviceDic = [NSMutableArray array];
    _userBookDic = [NSMutableArray array];
    
    [self createUser];
    [self setTableView];
    
}

- (void)createUser{
    [_userDic setObject:@"轩哥哥" forKey:@"username"];
    [_userDic setObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530879076512&di=063a53b2c9b69e7997dcd81118f191e2&imgtype=0&src=http%3A%2F%2Fimage001.server110.com%2F20170403%2F3b3f80288eb5f96fa69fea213400b555.jpg" forKey:@"portraitUri"];
    [_userDic setObject:@"1990-01-12" forKey:@"birthday"];
    [_userDic setObject:@"引领时尚巅峰，黑客无所不能" forKey:@"personSignature"];
    [_userDic setObject:@"帝王座" forKey:@"constellation"];
    [_userDic setObject:@{@"country":@"中国",@"province":@"北京市",@"city":@"北京市",@"district":@"朝阳区"} forKey:@"hometown"];
    [_userDic setObject:@(180) forKey:@"stature"];
    [_userDic setObject:@(75) forKey:@"weight"];
    [_userDic setObject:@"O型" forKey:@"bloodGroup"];
    [_userDic setObject:@[@{@"name":@"鼻子"},@{@"name":@"嘴"}] forKey:@"bodyparts"];
    [_userDic setObject:@[@{@"imageURL":@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1565734990,1198494824&fm=27&gp=0.jpg",@"iscover":@"0"},@{@"imageURL":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530879415806&di=7a073edc1feacd60bf24018ee47ff5eb&imgtype=jpg&src=http%3A%2F%2Fimg4.imgtn.bdimg.com%2Fit%2Fu%3D2621041864%2C2103405661%26fm%3D214%26gp%3D0.jpg",@"iscover":@"0"},@{@"imageURL":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530879424628&di=e643e014ab761d47da27cedaedcceef2&imgtype=jpg&src=http%3A%2F%2Fimg2.imgtn.bdimg.com%2Fit%2Fu%3D3828435172%2C2633378697%26fm%3D214%26gp%3D0.jpg",@"iscover":@"0" },@{@"iscover":@"1",@"imageURL":@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=154346632,3569703340&fm=27&gp=0.jpg"}] forKey:@"imageUris"];
    [_userDic setObject:@[@{@"name":@"投资人"}] forKey:@"mylabels"];
    [_userDic setObject:@[@{@"name":@"旅游"}] forKey:@"mywords"];
}

- (void)rightNavBtuAction:(UIButton *)sender{
    
    [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:_oneImage fileName:nil result:^(NSString *strPath) {
        NSLog(@"%@",strPath);
    }];
    
    
//    [KGRequestNetWorking postWothUrl:editPerBnsCard parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"user":_userDic,@"userMovice":_userMoviceDic,@"userMusic":_userMusicDic,@"userBook":_userBookDic} succ:^(id result) {
//
//    } fail:^(NSString *error) {
//
//    }];
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
    for (int i = 0; i < 3; i++) {
        MineEditVCChooseImageView *chooseView = [[MineEditVCChooseImageView alloc]initWithFrame:CGRectMake(15 + (kScreenWidth - 30 - 315)/2*i + 105*i, 10, 105, 140)];
        __weak typeof(self) mySelf = self;
        chooseView.sendChooseFileToController = ^(NSString *fileStr) {
            mySelf.oneImage = fileStr;
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
        cell.delegate = self;
        return cell;
    }else if(indexPath.row == 1){
        MineCenterMyCoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCenterMyCoverCell"];
        cell.coverImage.image = Image(@"tianjia");
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
        wordVC.foodArr = @[@"专一",@"工作狂",@"偏执狂",@"浪漫",@"内向",@"控制狂",@"爱冒险",@"善变",@"中二",@"理性",@"居家",@"感性",@"乐观",@"理想主义",@"完美主义"];
        wordVC.sportArr = @[@"专一",@"工作狂",@"偏执狂",@"浪漫",@"内向",@"控制狂",@"爱冒险",@"善变",@"中二",@"理性",@"居家",@"感性",@"乐观",@"理想主义",@"完美主义"];
        wordVC.leisureArr = @[@"专一",@"工作狂",@"偏执狂",@"浪漫",@"内向",@"控制狂",@"爱冒险",@"善变",@"中二",@"理性",@"居家",@"感性",@"乐观",@"理想主义",@"完美主义"];
        wordVC.footprintArr = @[@"专一",@"工作狂",@"偏执狂",@"浪漫",@"内向",@"控制狂",@"爱冒险",@"善变",@"中二",@"理性",@"居家",@"感性",@"乐观",@"理想主义",@"完美主义"];
        [self pushNoTabBarViewController:wordVC animated:YES];
    }
}
//MARK:--------------------------------------MineEditMyselfInfoEditCellDelegate--------------------------------------------------
- (void)touchUITableViewCellMakeSomeThingWithTitle:(NSString *)title{
    if ([title isEqualToString:@"头像"]) {
        self.cameraView.hidden = NO;
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
        }else if (mySelf.isCoverImage == YES){
            mySelf.isCoverImage = NO;
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
        if (mySelf.isCoverImage == YES) {
            mySelf.isCoverImage = NO;
        }else if (mySelf.isCoverImage == YES){
            mySelf.isCoverImage = NO;
        }
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
    
}

- (MineChooseWeightAndHeightView *)chooseWeightView{
    if (!_chooseWeightView) {
        _chooseWeightView = [[MineChooseWeightAndHeightView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _chooseWeightView.sendValueToController = ^(ChooseType type, NSString *value) {
            switch (type) {
                case ChooseHeight:
                    //:--身高--
                    NSLog(@"身高%@",value);
                    break;
                    
                default:
                    //:--体重--
                    NSLog(@"体重%@",value);
                    break;
            }
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
    myLabel.chooseArr = @[@"摄影",@"制片人",@"收藏家",@"画家"];
    myLabel.moviesArr = @[@"制片人",@"摄像",@"专一",@"工作狂",@"偏执狂",@"浪漫",@"内向",@"控制狂",@"爱冒险",@"善变",@"中二",@"理性",@"居家",@"感性",@"乐观",@"理想主义",@"完美主义"];
    myLabel.liteArr = @[@"诗人",@"工作狂",@"偏执狂",@"浪漫",@"内向",@"控制狂",@"爱冒险",@"善变",@"中二",@"理性",@"居家",@"感性",@"乐观",@"理想主义",@"完美主义"];
    myLabel.artArr = @[@"内向",@"控制狂",@"爱冒险",@"善变",@"中二",@"理性",@"居家",@"感性",@"乐观",@"理想主义",@"完美主义"];
    myLabel.desigArr = @[@"建筑设计",@"室内设计",@"工业设计",@"服装设计",@"平面设计",@"内向",@"控制狂",@"爱冒险",@"善变",@"中二",@"理性",@"居家",@"感性",@"乐观",@"理想主义",@"完美主义"];
    myLabel.musicArr = @[@"音乐人",@"内向",@"控制狂",@"爱冒险",@"善变",@"中二",@"理性",@"居家",@"感性",@"乐观",@"理想主义",@"完美主义"];
    myLabel.perfacmArr = @[@"导演",@"演员",@"制片人",@"内向",@"控制狂",@"爱冒险",@"善变",@"中二",@"理性",@"居家",@"感性",@"乐观",@"理想主义",@"完美主义"];
    myLabel.customArr = @[@"+"];
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
