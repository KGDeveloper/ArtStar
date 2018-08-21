//
//  KGSearchBarAndSearchView.m
//  ArtStar
//
//  Created by abc on 5/24/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "KGSearchBarAndSearchView.h"
#import "KGSearchViewCell.h"

@interface KGSearchBarAndSearchView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) KGSearchBarTF *searchTF;

@property (nonatomic,strong) UIView *hotView;
@property (nonatomic,strong) UIView *historyView;

@end

@implementation KGSearchBarAndSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
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
    _listView.tableHeaderView = [self tableViewHeaderView];
    _listView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"KGSearchViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGSearchViewCell"];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _historyArr.count;
}

- (UIView *)tableViewHeaderView{
    _hotView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    UILabel *topLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, ViewWidth(self),30)];
    topLab.text = @"热搜";
    topLab.textColor = Color_333333;
    topLab.font = SYFont(15);
    [_hotView addSubview:topLab];
    
    _historyView = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(_hotView) - 50, ViewWidth(_hotView), 50)];
    [_hotView addSubview:_historyView];
    
    UILabel *historyLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100,30)];
    historyLab.text = @"历史搜索";
    historyLab.textColor = Color_333333;
    historyLab.font = SYFont(15);
    [_historyView addSubview:historyLab];
    
    UIButton *deleteBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtu.frame = CGRectMake(ViewWidth(_historyView) - 37, 3, 22, 27);
    [deleteBtu setImage:Image(@"empty") forState:UIControlStateNormal];
    [deleteBtu addTarget:self action:@selector(deleteBtuClick) forControlEvents:UIControlEventTouchUpInside];
    [_historyView addSubview:deleteBtu];
    
    return _hotView;
}

- (void)deleteBtuClick{
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:_searchUrl parameters:@{@"uid":[KGUserInfo shareInterace].userID} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            mySelf.historyArr = nil;
            [mySelf.listView reloadData];
        }
    } fail:^(NSError *error) {
        
    }];
    [_listView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGSearchViewCell"];
    NSDictionary *dic = _historyArr[indexPath.row];
    cell.historyLab.text = dic[@"searchfor"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _historyArr[indexPath.row];
    if (self.clickSearchTitle) {
        self.clickSearchTitle(dic[@"searchfor"]);
    }
    self.hidden = YES;
}

- (void)setHotArr:(NSArray *)hotArr{
    _hotArr = hotArr;
    CGFloat width = 15;
    CGFloat height = 70;
    NSInteger count = 0;
    for (int i = 0; i < hotArr.count; i++) {
        NSDictionary *dic = hotArr[i];
        if (width + [TransformChineseToPinying stringWidthFromString:dic[@"searchfor"] font:FZFont(15) width:ViewWidth(self)] > ViewWidth(self)) {
            width = 15;
            count ++;
            height = 70 + 30*count;
        }
        [_hotView addSubview:[self createButtonWithFrame:CGRectMake(width, height, [TransformChineseToPinying stringWidthFromString:dic[@"searchfor"] font:FZFont(15) width:ViewWidth(self)], 15) title:dic[@"searchfor"] font:SYFont(12) color:[UIColor colorWithHexString:@"#666666"]]];
        width = width + 20 + [TransformChineseToPinying stringWidthFromString:dic[@"searchfor"] font:FZFont(15) width:ViewWidth(self)];
    }
    
    _hotView.frame = CGRectMake(ViewX(_hotView), ViewY(_hotView), ViewWidth(_hotView), height + 40 + 50);
    _historyView.frame = CGRectMake(0, ViewHeight(_hotView) - 50, ViewWidth(_hotView), 50);
    
    [_listView reloadData];
}

- (void)setHistoryArr:(NSArray *)historyArr{
    _historyArr = historyArr;
    [_listView reloadData];
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

- (void)titleBtuClick:(UIButton *)sender{
    if (self.clickSearchTitle) {
        self.clickSearchTitle(sender.currentTitle);
    }
}

- (void)cancelClick{
    self.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_listView reloadData];
    if (self.searchResult) {
        self.searchResult(textField.text);
    }
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
