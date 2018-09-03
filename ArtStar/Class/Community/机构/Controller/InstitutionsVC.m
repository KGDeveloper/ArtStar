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

@interface InstitutionsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) InstitutionsDetailHeaderView *headerView;
@property (nonatomic,strong) KGTicketView *ticketView;

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

    [self setTableView];
    [self setTicket];
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
    _headerView.imageArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527589600112&di=b40c73fe5905b6934ba069598703f121&imgtype=0&src=http%3A%2F%2Fimg.boqiicdn.com%2FData%2FBbs%2FUsers%2F130%2F13029%2F1302919%2FimgFile1334165213.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527589608723&di=de4b656156a1d54bdcb851ae26a5edac&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D845222470%2C3427863885%26fm%3D214%26gp%3D0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527589600112&di=983c0325ee45e4787b6c5536fb6deb1e&imgtype=0&src=http%3A%2F%2Fimage17-c.poco.cn%2Fmypoco%2Fmyphoto%2F20150917%2F21%2F6429132620150917215747069_640.jpg%3F1024x656_120",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527589622588&di=9c3429e44d5306f8dfc1cfb5d42681b7&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D1244518725%2C3588355648%26fm%3D214%26gp%3D0.jpg"];
    return _headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        DomIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DomIntroduceCell"];
        cell.detailLab.attributedText = [TransformChineseToPinying string:@"迪拜位于阿拉伯半岛中部、阿拉伯湾南岸，是海湾地区中心。与南亚次大陆隔海相望，与卡塔尔为邻、与沙特阿拉伯交界、与阿曼毗连。迪拜常住人口约280万人，本地人口占15%左右，外籍人士来自全球200多个国家和地区。常住迪拜的华人有约34万人，其他外籍人士来自诸如埃及、黎巴嫩、约旦、伊朗、印度、巴基斯坦、菲律宾等" font:SYFont(14) space:10];
        return cell;
    }else if(indexPath.row == 1){
        InstittutionsExbitionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstittutionsExbitionTableViewCell"];
        return cell;
    }else if (indexPath.row == 2){
        MusicPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicPhotosCell"];
        cell.imageArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527594277926&di=1c5e8efa9ec4298f2d2e9019551fb4af&imgtype=0&src=http%3A%2F%2Fmvimg1.meitudata.com%2F551428726064e1455.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527594277926&di=ecf64d8da3a2a2c4cfb71e0663a16b98&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fb90e7bec54e736d1cee22fdc91504fc2d4626975.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527594277926&di=0c5f99e7586b0737857dd28e53eae222&imgtype=0&src=http%3A%2F%2Fmvimg2.meitudata.com%2F56ade118046556370.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527594277925&di=9fc70f7bb6dab7f2e1f3d80a25d4e261&imgtype=0&src=http%3A%2F%2Fmvimg11.meitudata.com%2F587ffce9e93e31195.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527594277925&di=bc69a18ca14d37694fe775315fff4adf&imgtype=0&src=http%3A%2F%2Fmvimg2.meitudata.com%2F5628644450d489158.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527594277923&di=efc33be025e29124c80cd0e0d5850307&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F4e4a20a4462309f7a4da66c6780e0cf3d6cad6a9.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527594277921&di=7866001dac76b397c0350136d3e40748&imgtype=0&src=http%3A%2F%2Fmvimg1.meitudata.com%2F569c5f51f00315041.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527594277919&di=2cb946b8d61a7dde7a19824041219307&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fc8ea15ce36d3d5390d8daf173087e950342ab0b6.jpg"];
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
        [MBProgressHUD bwm_showTitle:@"尚未开放哦~" toView:weakSelf.view hideAfter:1];
    };
    _ticketView.backgroundColor = [UIColor colorWithHexString:@"#4d4d4d"];
    [self.view insertSubview:_ticketView atIndex:99];
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
