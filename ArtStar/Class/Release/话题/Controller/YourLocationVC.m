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
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>


@interface YourLocationVC ()<UITableViewDelegate,UITableViewDataSource,SearchBarViewDelegate,AMapSearchDelegate>
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

@property (nonatomic,strong) AMapSearchAPI *searchApi;
@property (nonatomic,copy) NSString *currentType;
@property (nonatomic,assign) NSInteger searchPage;

@end


@implementation YourLocationVC

/**
 根据中心点坐标来搜周边的POI.

 @param coord 中心点经纬度
 */
- (void)searchPointWithCenterCoordinate:(CLLocationCoordinate2D)coord{
    [AMapServices sharedServices].apiKey = GeocodeApiKey;
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc]init];
    request.location = [AMapGeoPoint locationWithLatitude:coord.latitude longitude:coord.longitude];
    request.types = @"";
    request.sortrule = 0;
    request.radius = 3000;
    request.page = self.searchPage;
    request.requireExtension = YES;
    request.requireSubPOIs = YES;
    [self.searchApi AMapPOIAroundSearch:request];
}

- (void)searchReGeocodeWithCoordnate:(CLLocationCoordinate2D)coordinate{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc]init];
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    [self.searchApi AMapReGoecodeSearch:regeo];
}

- (void)initSearchApi{
    self.searchPage = 1;
    [AMapServices sharedServices].apiKey = GeocodeApiKey;
    self.searchApi = [[AMapSearchAPI alloc]init];
    self.searchApi.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"我的位置" image:Image(@"back")];

    self.dataArr = [NSMutableArray array];
    self.allData = [NSMutableArray array];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self cllLocation];
    [self initSearchApi];
    [self setTableView];
    
}


- (void)cllLocation{
    KGLocationCityManager *manager = [KGLocationCityManager shareManager];
    [manager obtainYourLocation];
    __weak typeof(self) mySelf = self;
    manager.ToObtainYourLocation = ^(NSString *city, double latitude, double longitude) {
        
        [mySelf searchPointWithCenterCoordinate:CLLocationCoordinate2DMake(latitude, longitude)];
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
    NSDictionary *dic = _dataArr[indexPath.row];
    cell.locationLab.text = dic[@"name"];
    cell.posenLab.text = dic[@"address"];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _dataArr[indexPath.row];
    if (self.nowLocation) {
        self.nowLocation(dic[@"name"]);
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

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    NSArray *arr = response.pois;
    __weak typeof(self) mySelf = self;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AMapPOI *poi = obj;
        [mySelf.dataArr addObject:@{@"name":poi.name,@"address":poi.address}];
    }];
    [_locationView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[MBProgressHUD showHUDAddedTo:self.view animated:YES] bwm_hideWithTitle:@"请求出错，请重新尝试" hideAfter:1];
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
