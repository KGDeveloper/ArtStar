//
//  MapSpaceToYourView.m
//  ArtStar
//
//  Created by abc on 2018/6/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MapSpaceToYourView.h"
#import "KGCityChooseCell.h"

@interface MapSpaceToYourView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *leftView;
@property (nonatomic,strong) NSMutableArray *countryArr;

@end

@implementation MapSpaceToYourView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _countryArr = [NSMutableArray arrayWithObjects:@"离我最近",@"价格最低",@"好评优先", nil];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    _leftView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), 200)];
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
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGCityChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGCityChooseCell"];
    cell.backgroundView = [self tableViewNormalBackView:cell.frame];
    cell.selectedBackgroundView = [self tableViewWhiteBackView:cell.frame];
    cell.titleLab.text = _countryArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.sendSpace) {
        self.sendSpace(_countryArr[indexPath.row]);
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
