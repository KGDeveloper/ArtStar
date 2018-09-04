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

@interface InstitutionsVC ()<UITableViewDelegate,UITableViewDataSource,MusicPhotosCellDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) InstitutionsDetailHeaderView *headerView;
@property (nonatomic,strong) KGTicketView *ticketView;
@property (nonatomic,strong) NSMutableDictionary *dataDic;

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
    [self requestData];
}

- (void)setTableView{
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.tableHeaderView = [self tabViewHeaderView];
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
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
            cell.detailLab.attributedText = [TransformChineseToPinying string:_dataDic[@"blurb"] font:SYFont(14) space:10];
            return cell;
        }else if(indexPath.row == 1){
            InstittutionsExbitionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstittutionsExbitionTableViewCell"];
            return cell;
        }else if (indexPath.row == 2){
            MusicPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicPhotosCell"];
            cell.imageArr = @[];
            return cell;
        }else if (indexPath.row == 3){
            MusicCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicCommentCell"];
            cell.topCount = @"3.5";
            cell.centerCount = @"3.0";
            return cell;
        }else{
            MusicSimilarToRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicSimilarToRecommendCell"];
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            DomIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DomIntroduceCell"];
            cell.detailLab.attributedText = [TransformChineseToPinying string:_dataDic[@"blurb"] font:SYFont(14) space:10];
            cell.topTime.text = @"";
            cell.endTime.text = @"";
            cell.nameLab.text = _dataDic[@"username"];
            cell.starTime.text = _dataDic[@"potime"];
            return cell;
        }else if (indexPath.row == 1){
            MusicPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicPhotosCell"];
            NSArray *tmp = _dataDic[@"images"];
            __block NSMutableArray *imageArr = [NSMutableArray array];
            [tmp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dic = obj;
                [imageArr addObject:dic[@"imageURL"]];
            }];
            cell.imageArr = imageArr.copy;
            cell.countLab.text = [NSString stringWithFormat:@"相册(%li)",imageArr.count];
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
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",@"10010"];//_dataDic[@"cNumber"]
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        [self pushNoTabBarViewController:[[HotInstitutionsDetailVC alloc]init] animated:YES];
    }
}

- (void)setTicket{
    _ticketView = [[KGTicketView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    __weak typeof(self) weakSelf = self;
    _ticketView.theTicketAction = ^{
        [MBProgressHUD bwm_showTitle:@"该功能尚未实现哦~" toView:weakSelf.view hideAfter:1];
    };
    _ticketView.backgroundColor = [UIColor colorWithHexString:@"#4d4d4d"];
    [self.view insertSubview:_ticketView atIndex:99];
}
// MARK: --请求场馆详情--
- (void)requestData{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if ([_url isEqualToString:findOneMerchant]) {//:--普通机构详情--
        [KGRequestNetWorking postWothUrl:_url parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":_postID,@"longitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLongitude"],@"latitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLatitude"]} succ:^(id result) {
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
        [KGRequestNetWorking postWothUrl:_url parameters:@{} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        }];
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
