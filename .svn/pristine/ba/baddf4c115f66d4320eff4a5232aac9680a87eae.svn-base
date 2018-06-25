//
//  MapTypeChooseView.m
//  ArtStar
//
//  Created by abc on 2018/6/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MapTypeChooseView.h"
#import "KGCityChooseCell.h"

@interface MapTypeChooseView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *leftView;
@property (nonatomic,strong) UITableView *rightView;
@property (nonatomic,strong) NSMutableArray *countryArr;
@property (nonatomic,strong) NSMutableArray *addressArr;
@property (nonatomic,assign) MapType type;

@end

@implementation MapTypeChooseView

- (instancetype)initWithFrame:(CGRect)frame type:(MapType)type{
    if (self = [super initWithFrame:frame]) {
        [self createDataWithType:type];
        [self setUI];
    }
    return self;
}

- (void)setMytype:(MapType)mytype{
    _mytype = mytype;
    _type = mytype;
    [self createDataWithType:mytype];
}

- (void)createDataWithType:(MapType)type{
    
    _countryArr = [NSMutableArray array];
    _addressArr = [NSMutableArray array];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"MapTypePlist" ofType:@"plist"];
    if (type == MapTypeInstitutions) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
        NSDictionary *tmpDic = dic[@"文化场所"];
        _countryArr = [NSMutableArray arrayWithArray:tmpDic.allKeys.copy];
        [_leftView reloadData];
        [_rightView reloadData];
    }else{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
        NSDictionary *tmpDic = dic[@"文化消费"];
        _countryArr = tmpDic.allKeys.copy;
        [_leftView reloadData];
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
    _rightView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
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
        cell.textLabel.text = _countryArr[indexPath.row];
        cell.selectedBackgroundView = [self tableViewWhiteBackView:cell.frame];
        return cell;
    }else{
        KGCityChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGCityChooseCell"];
        cell.backgroundView = [self tableViewWhiteBackView:cell.frame];
        cell.textLabel.text = _addressArr[indexPath.row];
        cell.selectedBackgroundView = [self tableViewNormalBackView:cell.frame];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == MapTypeInstitutions) {
        if (tableView == _leftView) {
            
        }
    }else{
        if (tableView == _leftView) {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"MapTypePlist" ofType:@"plist"];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
            NSDictionary *tmpDic = dic[@"文化消费"];
            NSDictionary *detailDic = tmpDic[_countryArr[indexPath.row]];
            _addressArr = detailDic.allKeys.copy;
            [_rightView reloadData];
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
