//
//  KGSearchChatHistoryView.m
//  ArtStar
//
//  Created by abc on 2018/7/2.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGSearchChatHistoryView.h"
#import "KGSearchViewCell.h"

@interface KGSearchChatHistoryView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) KGSearchBarTF *searchTF;

@property (nonatomic,strong) UIView *hotView;
@property (nonatomic,strong) UIView *historyView;

@property (nonatomic,strong) NSMutableArray *searchArr;

@end

@implementation KGSearchChatHistoryView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _searchArr = [NSMutableArray array];
        self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    _searchTF = [[KGSearchBarTF alloc]initWithFrame:CGRectMake(15, NavTopHeight - 35, ViewWidth(self) - 75, 25)];
    _searchTF.placeholder = @"搜索";
    _searchTF.leftView = [[UIImageView alloc]initWithImage:Image(@"search")];
    _searchTF.leftViewMode = UITextFieldViewModeAlways;
    _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTF.delegate = self;
    _searchTF.font = SYFont(12);
    _searchTF.layer.cornerRadius = 5;
    _searchTF.layer.masksToBounds = YES;
    _searchTF.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    _searchTF.returnKeyType = UIReturnKeySearch;
    [self addSubview:_searchTF];
    
    UIButton *rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtu.frame = CGRectMake(ViewWidth(self) - 60, NavTopHeight - 35, 60, 25);
    [rightBtu setTitle:@"取消" forState:UIControlStateNormal];
    rightBtu.titleLabel.font = SYFont(14);
    [rightBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    [rightBtu addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtu];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, NavTopHeight, ViewWidth(self), 1)];
    line.backgroundColor = Color_ededed;
    [self addSubview:line];
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 1, ViewWidth(self), ViewHeight(self) - NavTopHeight - 1)];
    _listView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.rowHeight = 25;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"KGSearchViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGSearchViewCell"];
    
}

- (UIView *)tableViewBackView{
    UIView *backView = [[UIView alloc]initWithFrame:_listView.bounds];
    backView.backgroundColor = Color_fafafa;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, kScreenWidth, 15)];
    titleLab.text = @"快速搜索聊天内容";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font =SYFont(12);
    titleLab.textColor = Color_333333;
    [backView addSubview:titleLab];
    
    UIButton *leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtu.frame = CGRectMake(0,0, kScreenWidth/3, 30);
    [leftBtu setTitle:@"链接" forState:UIControlStateNormal];
    [leftBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    leftBtu.titleLabel.font = SYFont(12);
    [leftBtu addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:leftBtu];
    
    UIButton *centerBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    centerBtu.frame = CGRectMake(kScreenWidth/3,0, kScreenWidth/3, 30);
    [centerBtu setTitle:@"音乐" forState:UIControlStateNormal];
    [centerBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    centerBtu.titleLabel.font = SYFont(12);
    [centerBtu addTarget:self action:@selector(centerAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:centerBtu];
    
    UIButton *rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtu.frame = CGRectMake(kScreenWidth/3*2,0, kScreenWidth/3, 30);
    [rightBtu setTitle:@"图片" forState:UIControlStateNormal];
    [rightBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    rightBtu.titleLabel.font = SYFont(12);
    [rightBtu addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:rightBtu];
    
    return backView;
}

- (void)leftAction{
    
}
- (void)centerAction{
    
}
- (void)rightAction{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _searchArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGSearchViewCell"];
    cell.historyLab.text = _searchArr[indexPath.row];
    return cell;
}

- (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font color:(UIColor *)color{
    UIButton *titleBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtu.frame = frame;
    [titleBtu setTitle:title forState:UIControlStateNormal];
    [titleBtu setTitleColor:color forState:UIControlStateNormal];
    titleBtu.titleLabel.font = font;
    [titleBtu addTarget:self action:@selector(titleBtuClick:) forControlEvents:UIControlEventTouchUpInside];
    return titleBtu;
}

- (void)cancelClick{
    self.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    BOOL isAdd = YES;
    for (NSString *obj in _searchArr) {
        if ([textField.text isEqualToString:obj]) {
            isAdd = NO;
        }
    }
    if (isAdd == YES) {
        [_searchArr addObject:textField.text];
    }
    [_listView reloadData];
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
