//
//  MapAllCityScreeningView.m
//  ArtStar
//
//  Created by abc on 2018/6/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MapAllCityScreeningView.h"
#import "MapChooseCityAreaModel.h"
#import "KGCityChooseCell.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface MapAllCityScreeningView ()<UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate>

@property (nonatomic,strong) UITableView *leftView;
@property (nonatomic,strong) UITableView *rightView;
@property (nonatomic,strong) NSMutableArray *countryArr;
@property (nonatomic,strong) NSMutableArray *addressArr;
@property (nonatomic,strong) AMapSearchAPI *search;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,copy) NSString *perviseStr;

@end

@implementation MapAllCityScreeningView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _countryArr = [NSMutableArray array];
        _addressArr = [NSMutableArray array];
        _type = 0;
        [self setUI];
    }
    return self;
}

- (void)setCityName:(NSString *)cityName{
    _cityName = cityName;
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [AMapServices sharedServices].apiKey = GeocodeApiKey;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    AMapDistrictSearchRequest *dist = [[AMapDistrictSearchRequest alloc] init];
    dist.keywords = cityName;
    if ([cityName isEqualToString:@"北京市"] || [cityName isEqualToString:@"上海市"] || [cityName isEqualToString:@"天津市"] || [cityName isEqualToString:@"重庆市"]) {
        dist.keywords = [[cityName componentsSeparatedByString:@"市"] firstObject];
    }
    dist.requireExtension = YES;
    [self.search AMapDistrictSearch:dist];
}
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}
- (void)onDistrictSearchDone:(AMapDistrictSearchRequest *)request response:(AMapDistrictSearchResponse *)response{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
    if (response == nil){
        return;
    }
    NSArray *districtsArr = response.districts;
    AMapDistrict *dist = nil;
    dist = [districtsArr lastObject];
    NSArray *disArr = dist.districts;
    if (_type == 0) {
        _addressArr = [NSMutableArray array];
        [_countryArr addObjectsFromArray:disArr];
        [_leftView reloadData];
    }else{
        _addressArr = [NSMutableArray array];
        [_addressArr addObjectsFromArray:disArr];
        [_rightView reloadData];
    }
}
- (void)setUI{
    _leftView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self)/2, ViewHeight(self))];
    _leftView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    _leftView.delegate = self;
    _leftView.dataSource = self;
    _leftView.tableFooterView = TabLeViewFootView;
    _leftView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftView.bounces = NO;
    _leftView.showsVerticalScrollIndicator = NO;
    _leftView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_leftView];
    
    [_leftView registerNib:[UINib nibWithNibName:@"KGCityChooseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGCityChooseCell"];
    
    _rightView = [[UITableView alloc]initWithFrame:CGRectMake(ViewWidth(self)/2, 0, ViewWidth(self)/2, ViewHeight(self))];
    _rightView.backgroundColor = [UIColor whiteColor];
    _rightView.delegate = self;
    _rightView.dataSource = self;
    _rightView.tableFooterView = TabLeViewFootView;
    _rightView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightView.bounces = NO;
    _rightView.showsVerticalScrollIndicator = NO;
    _rightView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_rightView];
    
    [_rightView registerNib:[UINib nibWithNibName:@"KGCityChooseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGCityChooseCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _leftView) {
        return _countryArr.count;
    }else{
        return _addressArr.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftView) {
        KGCityChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGCityChooseCell"];
        cell.backgroundView = [self tableViewNormalBackView:cell.frame];
        cell.selectedBackgroundView = [self tableViewWhiteBackView:cell.frame];
        AMapDistrict *dic = _countryArr[indexPath.row];
        cell.titleLab.text = dic.name;
        return cell;
    }else{
        KGCityChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGCityChooseCell"];
        cell.backgroundView = [self tableViewWhiteBackView:cell.frame];
        cell.selectedBackgroundView = [self tableViewWhiteBackView:cell.frame];
        AMapDistrict *dic = _addressArr[indexPath.row];
        cell.titleLab.text = dic.name;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftView) {
        AMapDistrict *dic = _countryArr[indexPath.row];
        _type = 1;
        self.cityName = dic.name;
        _perviseStr = dic.name;
    }else{
        AMapDistrict *dic = _addressArr[indexPath.row];
        if (self.sendCityDis) {
            self.sendCityDis([NSString stringWithFormat:@"%@%@",_perviseStr,dic.name]);
        }
    }
}

- (UIView *)tableViewWhiteBackView:(CGRect)frame{
    UIView *backView = [[UIView alloc]initWithFrame:frame];
    backView.backgroundColor = [UIColor whiteColor];
    return backView;
}
- (UIView *)tableViewNormalBackView:(CGRect)frame{
    UIView *backView = [[UIView alloc]initWithFrame:frame];
    backView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    return backView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
