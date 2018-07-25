//
//  MineAddYourLoveSearchView.m
//  ArtStar
//
//  Created by abc on 2018/6/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineAddYourLoveSearchView.h"
#import "MineTextField.h"
#import "MineSearchYourLoveCell.h"

@interface MineAddYourLoveSearchView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) MineTextField *searchTF;
@property (nonatomic,strong) MineLoveMoviesModel *movie;
@property (nonatomic,strong) MineLoveMusicModel *music;
@property (nonatomic,strong) MineLoveBookModel *book;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation MineAddYourLoveSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_fafafa;
        _dataArr = [NSMutableArray array];
        [self setTableView];
    }
    return self;
}

- (void)setTableView{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, NavTopHeight)];
    topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topView];
    
    _searchTF = [[MineTextField alloc]initWithFrame:CGRectMake(15,NavTopHeight - 35, kScreenWidth - 75, 25)];
    _searchTF.backgroundColor = Color_ededed;
    _searchTF.font = SYFont(12);
    _searchTF.placeholder = @"请输入搜索您喜欢的";
    _searchTF.leftView = [[UIImageView alloc]initWithImage:Image(@"搜索")];
    _searchTF.leftViewMode = UITextFieldViewModeAlways;
    _searchTF.layer.cornerRadius = 5;
    _searchTF.layer.masksToBounds = YES;
    _searchTF.delegate = self;
    _searchTF.returnKeyType = UIReturnKeySearch;
    [topView addSubview:_searchTF];
    
    UIButton *cancelBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtu.frame = CGRectMake(ViewWidth(self) - 60, NavTopHeight - 35, 45, 25);
    [cancelBtu setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    cancelBtu.titleLabel.font = SYFont(13);
    cancelBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [cancelBtu addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancelBtu];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, NavTopHeight - 1, kScreenWidth, 1)];
    line.backgroundColor = Color_ededed;
    [topView addSubview:line];
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.dataSource = self;
    _listView.delegate = self;
    _listView.rowHeight = 50;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineSearchYourLoveCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineSearchYourLoveCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineSearchYourLoveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSearchYourLoveCell"];
    if (_type == LoveMovie) {
        MineLoveMoviesModel *model = _dataArr[indexPath.row];
        cell.titleLab.text = [NSString stringWithFormat:@"%@  %@",model.movieName,model.director];
    }else if (_type == LoveMusic){
        MineLoveMusicModel *model = _dataArr[indexPath.row];
        cell.titleLab.text = [NSString stringWithFormat:@"%@  %@",model.bookName,model.writer];
    }else if (_type == LoveBook){
        MineLoveBookModel *model = _dataArr[indexPath.row];
        cell.titleLab.text = [NSString stringWithFormat:@"%@  %@",model.bookName,model.writer];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.sendChoose) {
        switch (_type) {
            case LoveMovie:
                self.sendChoose(_dataArr[indexPath.row], nil, nil);
                break;
            case LoveMusic:
                self.sendChoose(nil, _music, nil);
                break;
            case LoveBook:
                self.sendChoose(nil, nil, _dataArr[indexPath.row]);
                break;
            default:
                break;
        }
    }
    self.hidden = YES;
}

- (void)cancelClick{
    self.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    NSString *url = nil;
    switch (_type) {
        case LoveMovie:
            url = likeMoviceName;
            break;
        case LoveMusic:
            url = likeMusicName;
            break;
        case LoveBook:
            url = likeBookName;
            break;
        default:
            break;
    }
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:url parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"name":textField.text,@"query":@{@"page":@"1",@"rows":@"20"}} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            [mySelf.dataArr removeAllObjects];
            if (mySelf.type == LoveMovie) {
                for (int i = 0; i < arr.count; i++) {
                    NSDictionary *dic = arr[i];
                    MineLoveMoviesModel *model = [MineLoveMoviesModel mj_objectWithKeyValues:dic];
                    [mySelf.dataArr addObject:model];
                }
            }else if (mySelf.type == LoveMusic){
                
            }else if (mySelf.type == LoveBook){
                for (int i = 0; i < arr.count; i++) {
                    NSDictionary *dic = arr[i];
                    MineLoveBookModel *model = [MineLoveBookModel mj_objectWithKeyValues:dic];
                    [mySelf.dataArr addObject:model];
                }
            }
            [mySelf.listView reloadData];
        }
        [MBProgressHUD hideHUDForView:mySelf animated:YES];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:mySelf animated:YES];
    }];
    
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
