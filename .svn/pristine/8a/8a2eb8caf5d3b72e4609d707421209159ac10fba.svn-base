//
//  HotMoviesDetailVC.m
//  ArtStar
//
//  Created by abc on 5/30/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HotMoviesDetailVC.h"
#import "HotMoviesDetailHeaderView.h"
#import "MusicCommentCell.h"
#import "HotMoviesDetailIntroudceCell.h"
#import "HotMoviesDetailCommentNormalCell.h"
#import "HotMoviesDetailCommentCell.h"
#import "HotmoviesActorCell.h"


@interface HotMoviesDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) HotMoviesDetailHeaderView *headerView;

@end

@implementation HotMoviesDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"后来的我们" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"more popup message")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTbaleView];
}

- (HotMoviesDetailHeaderView *)setTbaleViewHeaderView{
    
    _headerView = [[HotMoviesDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 235)];
    return _headerView;
}

- (void)setTbaleView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.tableHeaderView = [self setTbaleViewHeaderView];
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MusicCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MusicCommentCell"];
    [_listView registerClass:[HotMoviesDetailIntroudceCell class] forCellReuseIdentifier:@"HotMoviesDetailIntroudceCell"];
    [_listView registerNib:[UINib nibWithNibName:@"HotmoviesActorCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HotmoviesActorCell"];
    [_listView registerNib:[UINib nibWithNibName:@"HotMoviesDetailCommentNormalCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HotMoviesDetailCommentNormalCell"];
    [_listView registerClass:[HotMoviesDetailCommentCell class] forCellReuseIdentifier:@"HotMoviesDetailCommentCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        HotMoviesDetailIntroudceCell *cell = [HotMoviesDetailIntroudceCell new];
        return [cell cellHeightWithModel:@"北京故宫是中国明清两代的皇家宫殿，旧称为紫禁城，位于北京中轴线的中心，是中国古代宫廷建筑之精华。北京故宫以三大殿为中心，占地面积72万平方米，建筑面积约15万平方米，有大小宫殿七十多座，房屋九千余间。是世界上现存规模最大、保存最为完整的木质结构古建筑之一。"];
    }else if (indexPath.row == 1){
        return 215;
    }else if (indexPath.row == 2){
        return 43;
    }else{
        return 140;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        HotMoviesDetailIntroudceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotMoviesDetailIntroudceCell"];
        cell.introudceStr = @"北京故宫是中国明清两代的皇家宫殿，旧称为紫禁城，位于北京中轴线的中心，是中国古代宫廷建筑之精华。北京故宫以三大殿为中心，占地面积72万平方米，建筑面积约15万平方米，有大小宫殿七十多座，房屋九千余间。是世界上现存规模最大、保存最为完整的木质结构古建筑之一。";
        return cell;
    }else if (indexPath.row == 1){
        HotmoviesActorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotmoviesActorCell"];
        cell.actorArr = @[@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527681289646&di=f11eaf089d5d64f790538f5d36a45a0e&imgtype=0&src=http%3A%2F%2Fs6.sinaimg.cn%2Fsmall%2F003Bip3Tzy6NFTWpWx7a5%26690",@"name":@"杜敏赫",@"actor":@"导演"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527681289646&di=9a198f13be14e31bf76ec997eea44fe2&imgtype=0&src=http%3A%2F%2Fimg.tvzn.com%2Fperson%2Fimages%2F1681.jpg",@"name":@"金承秀",@"actor":@"演员"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527681289645&di=090c3da0b278c1a8839a56b46dc8c092&imgtype=0&src=http%3A%2F%2Ftupian.g312.com%2Fuploadimg%2F1428614602.jpg",@"name":@"于千景",@"actor":@"蛇女"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527681289645&di=db3467996ec644c5dbcfe30fef1a6765&imgtype=0&src=http%3A%2F%2Fjz.n63.com%2Fjz%2Fimg.php%2Fthumbnail%2FCNxuesemeigui%2Fjz.n63.com_dz_wzs_z_th_s_n_n_ll.jpg",@"name":@"茹萍",@"actor":@"大娃"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527681289645&di=c54e6ecf3d7ce62927cb5e30243db902&imgtype=0&src=http%3A%2F%2Ftupian.g312.com%2Fuploadimg%2F1452055938.jpg",@"name":@"钟汉良",@"actor":@"二娃"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527681289643&di=c0733ada00f739ad134636a0422bd9c0&imgtype=0&src=http%3A%2F%2Fwww.bjwzfd.com%2Fupload%2Fimg%2F8tONgNRLl9aw3hfPpivZIIzxaYQI9-UC8yc0VX4CEVZFSZW9bmJ1M0mTI5vO7yT-LfOWC13Vzg.jpg",@"name":@"不认识",@"actor":@"三娃"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527681289638&di=79f186e15063ff732321bafe657abeef&imgtype=0&src=http%3A%2F%2Fwww.g312.com%2Fuploadimg%2F1417215896.png",@"name":@"猪八戒",@"actor":@"四娃"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527681289637&di=51d15b04733926c64e3c320344b3a089&imgtype=0&src=http%3A%2F%2Fimg.tvzn.com%2Fperson%2Fimages%2F1441.jpg",@"name":@"逗比",@"actor":@"五娃"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527681289635&di=13334f8d2574d16fae4d68319a32e2f4&imgtype=0&src=http%3A%2F%2Fwww.cute38.com%2Fuploads%2Fallimg%2F150103%2F020AUV2_0.jpg",@"name":@"大叔",@"actor":@"六娃"}];
        return cell;
    }else if (indexPath.row == 2){
        HotMoviesDetailCommentNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotMoviesDetailCommentNormalCell"];
        return cell;
    }
    else{
        HotMoviesDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotMoviesDetailCommentCell"];
        return cell;
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
