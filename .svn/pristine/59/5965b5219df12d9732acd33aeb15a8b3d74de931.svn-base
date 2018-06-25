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

@interface MapAllCityScreeningView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *leftView;
@property (nonatomic,strong) UITableView *rightView;
@property (nonatomic,strong) NSMutableArray *countryArr;
@property (nonatomic,strong) NSMutableArray *addressArr;

@end

@implementation MapAllCityScreeningView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setCityName:(NSString *)cityName{
    _cityName = cityName;
    
    _countryArr = [NSMutableArray array];
    _addressArr = [NSMutableArray array];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:@"http://restapi.amap.com/v3/config/district" parameters:@{@"keywords":cityName,@"subdistrict":@"3",@"key":GeocodeApiKey} succ:^(id result) {
        NSArray *districtsArr = [result[@"districts"] firstObject][@"districts"];
        NSArray *areaArr = districtsArr[0][@"districts"];
        mySelf.countryArr = [MapChooseCityAreaModel mj_objectArrayWithKeyValuesArray:areaArr];
        [mySelf.countryArr insertObject:@"全城" atIndex:0];
        [mySelf.leftView reloadData];
    } fail:^(NSString *error) {
        
    }];
    
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
        if (indexPath.row == 0) {
            cell.titleLab.text = _countryArr[indexPath.row];
        }else{
            MapChooseCityAreaModel *model = _countryArr[indexPath.row];
            cell.titleLab.text = model.name;
        }
        return cell;
    }else{
        KGCityChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGCityChooseCell"];
        cell.backgroundView = [self tableViewWhiteBackView:cell.frame];
        cell.selectedBackgroundView = [self tableViewWhiteBackView:cell.frame];
        if (indexPath.row == 0) {
            cell.titleLab.text = _addressArr[indexPath.row];
        }else{
            MapChooseCityAreaModel *model = _addressArr[indexPath.row];
            cell.titleLab.text = model.name;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftView) {
        if (indexPath.row == 0) {
            [_addressArr removeAllObjects];
        }else{
            MapChooseCityAreaModel *model = _countryArr[indexPath.row];
            _addressArr = [MapChooseCityAreaModel mj_objectArrayWithKeyValuesArray:model.districts];
            [_addressArr insertObject:@"不限制" atIndex:0];
        }
        [_rightView reloadData];
    }else{
        if (indexPath.row == 0) {
            
        }else{
            
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
