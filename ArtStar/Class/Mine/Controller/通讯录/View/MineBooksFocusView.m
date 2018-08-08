//
//  MineBooksFocusView.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineBooksFocusView.h"
#import "MineBooksFriendsTableViewCell.h"

@interface MineBooksFocusView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) UIButton *leftBtu;
@property (nonatomic,strong) UIButton *rightBtu;
@property (nonatomic,strong) UIView *line;

@property (nonatomic,assign) BOOL isNews;

@end

@implementation MineBooksFocusView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _isNews = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self setTableView];
    }
    return self;
}

- (void)setTableView{
    
    _leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtu.frame = CGRectMake(0, 0, ViewWidth(self)/2, 50);
    [_leftBtu setTitle:@"关注的人" forState:UIControlStateNormal];
    [_leftBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _leftBtu.titleLabel.font = SYFont(14);
    [_leftBtu addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftBtu];
    
    _rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtu.frame = CGRectMake(ViewWidth(self)/2, 0, ViewWidth(self)/2, 50);
    [_rightBtu setTitle:@"新闻账号" forState:UIControlStateNormal];
    [_rightBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _rightBtu.titleLabel.font = SYFont(13);
    [_rightBtu addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBtu];
    
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(0, 49, ViewWidth(self), 1)];
    lowLine.backgroundColor = Color_ededed;
    [self addSubview:lowLine];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(ViewWidth(self)/4 - 23, 48, 55, 2)];
    _line.backgroundColor = Color_333333;
    [self addSubview:_line];
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, ViewWidth(self), ViewHeight(self) - 50)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.emptyDataSetSource = self;
    _listView.emptyDataSetDelegate = self;
    _listView.rowHeight = 70;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineBooksFriendsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineBooksFriendsTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isNews == YES) {
        return _newsArr.count;
    }else{
        return _peopleArr.count;
    }
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    UITableViewRowAction *topAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    topAction.backgroundColor = Color_999999;
    
    UITableViewRowAction *nikeNameAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"备注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    nikeNameAction.backgroundColor = Color_999999;
    
    UITableViewRowAction *cancleAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"取消关注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    cancleAction.backgroundColor = Color_333333;
    return @[cancleAction,nikeNameAction,topAction];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineBooksFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineBooksFriendsTableViewCell"];
    if (_isNews == YES) {
        cell.foucsBtu.hidden = NO;
        [cell.foucsBtu setTitle:@"已关注" forState:UIControlStateNormal];
        cell.foucsBtu.backgroundColor = Color_999999;
        cell.imageWidth.constant = 0;
    }else{
        cell.foucsBtu.hidden = YES;
        cell.imageWidth.constant = 40;
    }
    return cell;
}

- (void)leftClick:(UIButton *)sender{
    [_rightBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _rightBtu.titleLabel.font = SYFont(13);
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    sender.titleLabel.font = SYFont(14);
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    _isNews = NO;
    [_listView reloadData];
}

- (void)rightClick:(UIButton *)sender{
    [_leftBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _leftBtu.titleLabel.font = SYFont(13);
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    sender.titleLabel.font = SYFont(14);
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    _isNews = YES;
    [_listView reloadData];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return Image(@"空空如也");
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *str = @"没有数据哦~";
    NSDictionary *attributes = @{NSFontAttributeName:SYFont(15),NSForegroundColorAttributeName:Color_999999};
    return [[NSAttributedString alloc]initWithString:str attributes:attributes];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 25.0;
}

- (void)setPeopleArr:(NSArray *)peopleArr{
    _peopleArr = peopleArr;
    [_listView reloadData];
}
- (void)setNewsArr:(NSArray *)newsArr{
    _newsArr = newsArr;
    [_listView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
