//
//  InstitutionsVC.m
//  ArtStar
//
//  Created by abc on 5/29/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "InstitutionsVC.h"
#import "InstitutionsDetailHeaderView.h"
#import "DomIntroduceCell.h"
#import "MusicAboutCell.h"
#import "MusicPhotosCell.h"
#import "MusicCommentCell.h"
#import "MusicBuyTicketCell.h"
#import "MusicSimilarToRecommendCell.h"
#import "HotInstitutionsDetailVC.h"
#import "KGTicketView.h"
#import "InstittutionsExbitionTableViewCell.h"
#import "AcitvitryClockSuccessAddScoreView.h"

@interface InstitutionsVC ()<UITableViewDelegate,UITableViewDataSource,MusicPhotosCellDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) InstitutionsDetailHeaderView *headerView;
@property (nonatomic,strong) KGTicketView *ticketView;
@property (nonatomic,strong) NSMutableDictionary *dataDic;
@property (nonatomic,strong) UIButton *clockBtu;
@property (nonatomic,strong) AcitvitryClockSuccessAddScoreView *scroeView;

@end

@implementation InstitutionsVC


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _dataDic = [NSMutableDictionary dictionary];
}

- (void)setTableView{
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.tableHeaderView = [self tabViewHeaderView];
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view insertSubview:_listView atIndex:1];
    
    [_listView registerNib:[UINib nibWithNibName:@"DomIntroduceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DomIntroduceCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MusicAboutCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MusicAboutCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MusicPhotosCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MusicPhotosCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MusicCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MusicCommentCell"];
    [_listView registerClass:[MusicSimilarToRecommendCell class] forCellReuseIdentifier:@"MusicSimilarToRecommendCell"];
    [_listView registerClass:[InstittutionsExbitionTableViewCell class] forCellReuseIdentifier:@"InstittutionsExbitionTableViewCell"];
}

- (InstitutionsDetailHeaderView *)tabViewHeaderView{
    _headerView = [[InstitutionsDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/750*480)];
    if (_dataDic[@"images"]) {
        _headerView.imageArr = _dataDic[@"images"];
    }else{
        _headerView.imageArr = _dataDic[@"imgList"];
    }
    _headerView.title = _dataDic[@"username"];
    return _headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataDic[@"showList"] && ![_dataDic[@"showList"] isKindOfClass:[NSNull class]]) {
        return 5;
    }
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataDic[@"showList"] && ![_dataDic[@"showList"] isKindOfClass:[NSNull class]]) {
        if (indexPath.row == 0) {
            return 235;
        }else if(indexPath.row == 1){
            return (kScreenWidth - 30)/690*280*3 + 196;
        }else if (indexPath.row == 2){
            return 220;
        }else if (indexPath.row == 3){
            return 220;
        }else{
            return 395;
        }
    }else{
        if (indexPath.row == 0) {
            return 235;
        }else if (indexPath.row == 1){
            return 220;
        }else if (indexPath.row == 2){
            return 220;
        }else{
            return 395;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataDic[@"showList"] && ![_dataDic[@"showList"] isKindOfClass:[NSNull class]]) {
        if (indexPath.row == 0) {
            DomIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DomIntroduceCell"];
            if (![_dataDic[@"blurb"] isKindOfClass:[NSNull class]]){
                cell.detailLab.attributedText = [TransformChineseToPinying string:_dataDic[@"blurb"] font:SYFont(14) space:10];
            }else{
                cell.detailLab.text = @"暂无介绍";
            }
            if(![_dataDic[@"potime"] isKindOfClass:[NSNull class]]){
                cell.starTime.text = _dataDic[@"potime"];
            }else{
                cell.starTime.text = @"暂无相关时间";
            }
            cell.topTime.text = @"";
            cell.endTime.text = @"";
            cell.nameLab.text = _dataDic[@"username"];
            return cell;
        }else if(indexPath.row == 1){
            InstittutionsExbitionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstittutionsExbitionTableViewCell"];
            if (![_dataDic[@"showList"] isKindOfClass:[NSNull class]]) {
                cell.showArr = _dataDic[@"showList"];
            }
            return cell;
        }else if (indexPath.row == 2){
            MusicPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicPhotosCell"];
            NSArray *tmp = _dataDic[@"images"];
            if(tmp.count > 0){
                __block NSMutableArray *imageArr = [NSMutableArray array];
                [tmp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dic = obj;
                    [imageArr addObject:dic[@"imageURL"]];
                }];
                cell.imageArr = imageArr.copy;
                cell.countLab.text = [NSString stringWithFormat:@"相册(%li)",imageArr.count];
            }
            cell.adressLab.text = _dataDic[@"address"];
            [cell.spaceLab setTitle:[NSString stringWithFormat:@"%@m",_dataDic[@"distance"]] forState:UIControlStateNormal];
            cell.delegate = self;
            return cell;
        }else if (indexPath.row == 3){
            MusicCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicCommentCell"];
            cell.topCount = @"3.5";
            cell.centerCount = @"3.0";
            return cell;
        }else{
            MusicSimilarToRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicSimilarToRecommendCell"];
            cell.dataArr = _dataDic[@"merchant"];
            if(![_dataDic[@"merchantList"] isKindOfClass:[NSNull class]]){
                cell.dataArr = _dataDic[@"merchantList"];
            }
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            DomIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DomIntroduceCell"];
            if (![_dataDic[@"blurb"] isKindOfClass:[NSNull class]]){
                cell.detailLab.attributedText = [TransformChineseToPinying string:_dataDic[@"blurb"] font:SYFont(14) space:10];
            }else{
                cell.detailLab.text = @"暂无介绍";
            }
            cell.topTime.text = @"";
            cell.endTime.text = @"";
            cell.nameLab.text = _dataDic[@"username"];
            if(![_dataDic[@"potime"] isKindOfClass:[NSNull class]]){
                cell.starTime.text = _dataDic[@"potime"];
            }else{
                cell.starTime.text = @"暂无相关时间";
            }
            return cell;
        }else if (indexPath.row == 1){
            MusicPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicPhotosCell"];
            NSArray *tmp = _dataDic[@"images"];
            if(tmp.count > 0){
                __block NSMutableArray *imageArr = [NSMutableArray array];
                [tmp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dic = obj;
                    [imageArr addObject:dic[@"imageURL"]];
                }];
                cell.imageArr = imageArr.copy;
                cell.countLab.text = [NSString stringWithFormat:@"相册(%lu)",(unsigned long)imageArr.count];
            }
            cell.adressLab.text = _dataDic[@"address"];
            [cell.spaceLab setTitle:[NSString stringWithFormat:@"%@m",_dataDic[@"distance"]] forState:UIControlStateNormal];
            cell.delegate = self;
            return cell;
        }else if (indexPath.row == 2){
            MusicCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicCommentCell"];
            cell.topCount = @"3.5";
            cell.centerCount = @"3.0";
            return cell;
        }else{
            MusicSimilarToRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicSimilarToRecommendCell"];
            cell.dataArr = _dataDic[@"merchant"];
            return cell;
        }
    }
}

- (void)tletePhoneAction{
    if(![_dataDic[@"telphone"] isKindOfClass:[NSNull class]]){
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",_dataDic[@"telphone"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    }else{
        [MBProgressHUD bwm_showTitle:@"暂无电话" toView:self.view hideAfter:1];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        [self pushNoTabBarViewController:[[HotInstitutionsDetailVC alloc]init] animated:YES];
    }
}
// MARK: --买票，这个功能暂未开放--
- (void)setTicket{
    _ticketView = [[KGTicketView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    __weak typeof(self) weakSelf = self;
    _ticketView.theTicketAction = ^{
        [MBProgressHUD bwm_showTitle:@"该功能尚未实现哦~" toView:weakSelf.view hideAfter:1];
    };
    _ticketView.backgroundColor = [UIColor colorWithHexString:@"#4d4d4d"];
    [self.view insertSubview:_ticketView atIndex:99];
}
// MARK: --根据Url判断加载活动机构详情页还是普通机构详情页--
- (void)setUrl:(NSString *)url{
    _url = url;
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if ([url isEqualToString:findOneMerchant]) {//:--普通机构详情--
        [KGRequestNetWorking postWothUrl:url parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":_postID,@"longitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLongitude"],@"latitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLatitude"]} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            if ([result[@"code"] integerValue] == 200) {
                NSArray *tmp = result[@"data"];
                weakSelf.dataDic = [NSMutableDictionary dictionaryWithDictionary:[tmp firstObject]];
                [weakSelf setTableView];
                [weakSelf setTicket];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        }];
    }else if ([url isEqualToString:findOneMerchantParticulars]){
        [KGRequestNetWorking postWothUrl:findOneMerchantParticulars parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":_postID,@"longitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLongitude"],@"latitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLatitude"]} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            if ([result[@"code"] integerValue] == 200) {
                NSArray *tmp = result[@"data"];
                weakSelf.dataDic = [NSMutableDictionary dictionaryWithDictionary:[tmp firstObject]];
                [weakSelf setTableView];
                [weakSelf setTicket];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        }];
    }else{
        [KGRequestNetWorking postWothUrl:url parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"pid":_postID,@"uid":[KGUserInfo shareInterace].userID,@"userlatitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLatitude"],@"userLongitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLongitude"],@"query":@{@"page":@"1",@"rows":@"15"},@"typename":@""} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            if ([result[@"code"] integerValue] == 200) {
                NSArray *tmp = result[@"data"];
                weakSelf.dataDic = [NSMutableDictionary dictionaryWithDictionary:[tmp firstObject]];
                if ([weakSelf.dataDic[@"types"] integerValue] == 0) {
                    [weakSelf setUpClock:Image(@"打卡")];
                }else{
                    [weakSelf setUpClock:Image(@"打卡不可点击")];
                }
                [weakSelf setTableView];
                [weakSelf setTicket];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        }];
    }
}
// MARK: --创建打卡按钮--
- (void)setUpClock:(UIImage *)image{
    _clockBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _clockBtu.frame =CGRectMake(kScreenWidth - 70, kScreenHeight - 120, 40, 40);
    [_clockBtu setImage:image forState:UIControlStateNormal];
    [_clockBtu addTarget:self action:@selector(clockAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:_clockBtu atIndex:99];
}

- (void)clockAction:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    if ([sender.currentImage isEqual:Image(@"打卡")]) {
        [sender setImage:Image(@"打卡不可点击") forState:UIControlStateNormal];
        [KGRequestNetWorking postWothUrl:firstTimePunchings parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"uid":[KGUserInfo shareInterace].userID,@"mid":_postID,@"mName":_dataDic[@"username"],@"types":_dataDic[@"types"],@"userLongitude":[[NSUserDefaults standardUserDefaults]objectForKey:@"YourLocationLongitude"],@"userlatitude":[[NSUserDefaults standardUserDefaults]objectForKey:@"YourLocationLatitude"],@"longitude":_dataDic[@"longitude"],@"latitude":_dataDic[@"latitude"]} succ:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                if ([result[@"message"] isEqualToString:@"打卡成功！"]) {
                    if ([weakSelf.dataDic[@"integral"] integerValue] == 20) {
                        weakSelf.scroeView.scroe = Image(@"20积分");
                    }else if ([weakSelf.dataDic[@"integral"] integerValue] == 40){
                        weakSelf.scroeView.scroe = Image(@"40积分");
                    }else{
                        weakSelf.scroeView.scroe = Image(@"50积分");
                    }
                }else{
                    [MBProgressHUD bwm_showTitle:result[@"message"] toView:weakSelf.view hideAfter:1];
                }
            }else{
                [MBProgressHUD bwm_showTitle:@"打卡失败" toView:weakSelf.view hideAfter:1];
                [sender setImage:Image(@"打卡") forState:UIControlStateNormal];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD bwm_showTitle:@"打卡失败" toView:weakSelf.view hideAfter:1];
            [sender setImage:Image(@"打卡") forState:UIControlStateNormal];
        }];
    }
}
// MARK: --显示加积分页面--
- (AcitvitryClockSuccessAddScoreView *)scroeView{
    if (!_scroeView) {
        _scroeView = [[AcitvitryClockSuccessAddScoreView alloc]initWithFrame:self.view.bounds];
        [self.navigationController.view addSubview:_scroeView];
    }
    return _scroeView;
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
