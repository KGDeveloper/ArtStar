//
//  MusicChooseCityView.m
//  ArtStar
//
//  Created by abc on 5/31/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicChooseCityView.h"
#import "KGCityChooseCell.h"

@interface MusicChooseCityView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *leftView;
@property (nonatomic,strong) UITableView *rightView;

@property (nonatomic,strong) NSMutableArray *cityArr;
@property (nonatomic,strong) NSMutableArray *provinceArr;

@property (nonatomic,copy) NSString *provinceName;
@property (nonatomic,copy) NSString *cityName;

@end

@implementation MusicChooseCityView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createData];
        [self setLeftListView];
        [self setRightListView];
    }
    return self;
}
- (void)createData{
    _provinceArr = [NSMutableArray arrayWithArray:[KGCity province]];
    NSArray *arr = [KGCity cityWithprovince:@"内蒙古自治区"];
    _cityArr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dic = arr[i];
        NSArray *tmp = dic.allKeys;
        for (int j = 0; j < tmp.count; j++) {
            [_cityArr addObject:tmp[j]];
        }
    }
}

- (void)setLeftListView{
    _leftView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self)/2, ViewHeight(self))];
    _leftView.delegate = self;
    _leftView.dataSource = self;
    _leftView.tableFooterView = TabLeViewFootView;
    _leftView.rowHeight = 45;
    _leftView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_leftView];
    
    [_leftView registerNib:[UINib nibWithNibName:@"KGCityChooseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGCityChooseCell"];
}
- (void)setRightListView{
    _rightView = [[UITableView alloc]initWithFrame:CGRectMake(ViewWidth(self)/2, 0, ViewWidth(self)/2, ViewHeight(self))];
    _rightView.delegate = self;
    _rightView.dataSource = self;
    _rightView.tableFooterView = TabLeViewFootView;
    _rightView.rowHeight = 45;
    _rightView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_rightView];
    
    [_rightView registerNib:[UINib nibWithNibName:@"KGCityChooseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGCityChooseCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _leftView) {
        return _provinceArr.count;
    }else{
        return _cityArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftView) {
        KGCityChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGCityChooseCell"];
        cell.backgroundView = [self tableViewNormalBackView:cell.frame];
        cell.selectedBackgroundView = [self tableViewWhiteBackView:cell.frame];
        cell.titleLab.text = _provinceArr[indexPath.row];
        return cell;
    }else{
        KGCityChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGCityChooseCell"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.titleLab.text = _cityArr[indexPath.row];
        cell.selectedBackgroundView = [self tableViewWhiteBackView:CGRectMake(ViewX(cell), ViewY(cell), ViewWidth(cell), ViewHeight(cell) - 1)];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftView) {
        _provinceName = _provinceArr[indexPath.row];
        [_cityArr removeAllObjects];
        NSArray *arr = [KGCity cityWithprovince:_provinceName];
        _cityArr = [NSMutableArray array];
        for (int i = 0; i < arr.count; i++) {
            NSDictionary *dic = arr[i];
            NSArray *tmp = dic.allKeys;
            for (int j = 0; j < tmp.count; j++) {
                [_cityArr addObject:tmp[j]];
            }
        }
        [_rightView reloadData];
    }else{
        _cityName = _cityArr[indexPath.row];
        if (self.sendProvinceNameAndCityName) {
            self.sendProvinceNameAndCityName(_provinceName,_cityName);
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
