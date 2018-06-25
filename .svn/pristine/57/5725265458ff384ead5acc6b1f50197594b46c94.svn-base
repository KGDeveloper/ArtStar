//
//  YourLocationVC.m
//  ArtStar
//
//  Created by abc on 5/14/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "YourLocationVC.h"
#import "SearchBarView.h"
#import "YourLocationTableViewCell.h"
#import "YourLocationModel.h"

@interface YourLocationVC ()<UITableViewDelegate,UITableViewDataSource,SearchBarViewDelegate>
//:--显示地理位置的列表视图--
@property (nonatomic,strong) UITableView *locationView;
//:--自定义搜索框--
@property (nonatomic,strong) SearchBarView *searchBar;
//:--附近所有标志性建筑物--
@property (nonatomic,strong) NSMutableArray *dataArr;
//:--搜索后数据--
@property (nonatomic,strong) NSMutableArray *searchArr;
//:--保存所有数据--
@property (nonatomic,strong) NSMutableArray *allData;

@property (nonatomic,copy) NSString *locationStr;

@end


@implementation YourLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftBtuWithTitle:@"我的位置" image:Image(@"back")];
    
    self.dataArr = [NSMutableArray array];
    self.allData = [NSMutableArray array];
    
    [self cllLocation];
    [self setTableView];
}

- (void)cllLocation{
    KGLocationCityManager *manager = [KGLocationCityManager shareManager];
    [manager obtainYourLocation];
    __weak typeof(self) mySelf = self;
    manager.ToObtainYourLocation = ^(NSString *city, double latitude, double longitude) {
        mySelf.locationStr = [NSString stringWithFormat:@"%f,%f",longitude,latitude];
        [mySelf setData:mySelf.locationStr];
    };
}

//MARK:--创建搜索框--
- (SearchBarView *)searchBar{
    if (!_searchBar) {
        _searchBar = [[SearchBarView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _searchBar.delegate = self;
    }
    return _searchBar;
}
//MARK:--创建位置显示列表--
- (void)setTableView{
    self.locationView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight) style:UITableViewStylePlain];
    self.locationView.backgroundColor = Color_f2f2f2;
    self.locationView.delegate = self;
    self.locationView.dataSource = self;
    self.locationView.rowHeight = 60;
    self.locationView.tableHeaderView = self.searchBar;
    self.locationView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.locationView];
}
//MARK:--UITableViewDelegate--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
//MARK:--UITableViewDataSource--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YourLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YourLocationTableViewCell" owner:self options:nil] lastObject];
    }
    YourLocationModel *model = _dataArr[indexPath.row];
    cell.locationLab.text = model.name;
    cell.posenLab.text = model.type;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YourLocationModel *model = _dataArr[indexPath.row];
    if (self.nowLocation) {
        self.nowLocation(model.name);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//MARK:--SearchBarViewDelegate--
- (void)sendSearhTextToCOntroller:(NSString *)text{
    if ([text isEqualToString:@""]) {
        NSArray *arr = _allData.copy;
        _dataArr = [NSMutableArray arrayWithArray:arr];
        [_locationView reloadData];
    }else{
        _searchArr = [NSMutableArray array];
        for (int i = 0; i < _dataArr.count; i++) {
            YourLocationModel *model = _dataArr[i];
            if ([TransformChineseToPinying containsString:[TransformChineseToPinying transform:model.name] text:text]) {
                [_searchArr addObject:model];
            }
        }
        [_dataArr removeAllObjects];
        _dataArr = _searchArr;
        [_locationView reloadData];
    }
}

- (void)setData:(NSString *)location{
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:@"http://restapi.amap.com/v3/geocode/regeo" parameters:@{@"key":GeocodeApiKey,@"location":location,@"radius":@"3000",@"extensions":@"all",@"batch":@"true",@"roadlevel":@"0"} succ:^(id result) {
        NSArray *regeocodeArr = result[@"regeocodes"];
        NSDictionary *regeocodeDic = regeocodeArr[0];
        NSArray *poisArr = regeocodeDic[@"pois"];
        mySelf.dataArr = [YourLocationModel mj_objectArrayWithKeyValuesArray:poisArr];
        mySelf.allData = mySelf.dataArr.copy;
        [mySelf.locationView reloadData];
    } fail:^(NSString *error) {
        
    }];
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
