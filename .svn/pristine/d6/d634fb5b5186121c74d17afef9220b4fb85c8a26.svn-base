//
//  MyselfCenterVideo+Music+BookVC.m
//  ArtStar
//
//  Created by abc on 6/6/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MyselfCenterVideo+Music+BookVC.h"
#import "MyselfLoveMoviesCell.h"
#import "MyselfLoveMusicCell.h"

@interface MyselfCenterVideo_Music_BookVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation MyselfCenterVideo_Music_BookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithTitle:@"影音书" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTableView];
    
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MyselfLoveMoviesCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyselfLoveMoviesCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MyselfLoveMusicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyselfLoveMusicCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return 200;
    }else{
        return 215;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        MyselfLoveMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyselfLoveMusicCell"];
        cell.imageArr = @[@{@"image":@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1010392637,4035799959&fm=27&gp=0.jpg",@"name":@"黑凤梨"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528275449561&di=569c4c3563508fe733aea87ba0c70797&imgtype=0&src=http%3A%2F%2Fm.360buyimg.com%2Fn7%2Fjfs%2Ft649%2F47%2F983807328%2F330185%2F30d51416%2F549e4afaNf116350f.jpg",@"name":@"月牙弯弯"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528275449560&di=a69773abf2033b59b83a682d2c11859c&imgtype=0&src=http%3A%2F%2Fcbu01.alicdn.com%2Fimg%2Fibank%2F2014%2F484%2F869%2F1446968484_574100578.220x220.jpg",@"name":@"反转地球"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528275449560&di=175a5029c25dda1a116dd11faa57a527&imgtype=0&src=http%3A%2F%2Fm.360buyimg.com%2Fn7%2Fg14%2FM03%2F0B%2F1D%2FrBEhVlLM7esIAAAAAAHOAdXqZYYAAH0hAIIIz8AAc4Z254.jpg",@"name":@"三十六计"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528275449560&di=47660b193250cf9f3f63d07ff394d30e&imgtype=0&src=http%3A%2F%2Fm.360buyimg.com%2Fn7%2Fjfs%2Ft187%2F219%2F1636756690%2F168145%2Fea2d4200%2F53b6476fN6a2398fb.jpg",@"name":@"刀山火海"}];
        return cell;
    }else if(indexPath.row == 0){
        MyselfLoveMoviesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyselfLoveMoviesCell"];
        cell.imageArr = @[@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528275297478&di=531a7b329876c15cbe5b1509fc22be22&imgtype=0&src=http%3A%2F%2Fl.paipaitxt.com%2F118851%2Fphoto%2FMon_1201%2F22156_09c61325934910cd4565a4bb840c5.jpg",@"name":@"KILLER ELITE"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528275297478&di=221289a8ffda4a056efcf38e311b656a&imgtype=0&src=http%3A%2F%2Fl.paipaitxt.com%2F118851%2Fphoto%2FMon_1201%2F21699_ea671325933006e84bbc34841bcee.jpg",@"name":@"女人如花"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528275297477&di=a0bae4049c0967683f4c08ef21a4b5b5&imgtype=0&src=http%3A%2F%2Fwww.shtickets.cn%2Fimages%2Fhotpic%2F2008%2F6092_b.jpg",@"name":@"江山美人"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528275297474&di=fe9e769329abe893f1d91a0187996a61&imgtype=0&src=http%3A%2F%2Fwww.shtickets.cn%2Fimages%2Fhotpic%2F2007%2F4858_b.jpg",@"name":@"江汉怪物"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528275392693&di=c1eb90db0d59f11ffd1b9afd25387ea6&imgtype=jpg&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D2438910538%2C1955660357%26fm%3D214%26gp%3D0.jpg",@"name":@"小小飞虎队"}];
        cell.titleLab.text = @"喜欢的电影";
        return cell;
    }else{
        MyselfLoveMoviesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyselfLoveMoviesCell"];
        cell.imageArr = @[@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528275152498&di=619eba355b16e50bd9384c717a5ed030&imgtype=0&src=http%3A%2F%2Fimg1.youlu.net%2F%3Ftype%3Dbook_n%26name%3D97878018389880044080.jpg",@"name":@"从赢得尊重开始"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528275152497&di=e6942f4ca39f9e60a25a23a18f479038&imgtype=0&src=http%3A%2F%2Fimg2.scimg.cn%2Fuserupload%2Fproductscover%2F260x260%2F201309%2F15%2F20137923880417755.jpg",@"name":@"贞观后之语"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528275152495&di=ca2f8fe586d808e34367f40f804caccd&imgtype=0&src=http%3A%2F%2Fimg.nbtv.cn%2Fc0%2Fc20%2F14fcaa35b4a4a.jpg",@"name":@"奇趣谜"},@{@"image":@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3408345725,1921613058&fm=15&gp=0.jpg",@"name":@"心理学"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528275152493&di=e1ced410714a12e720f25f6917bf4cca&imgtype=0&src=http%3A%2F%2Fi8.qhimg.com%2Fdr%2F200__%2Ft01f73919d569428a75.jpg",@"name":@"环境污染"}];
        cell.titleLab.text = @"喜欢的书籍";
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
