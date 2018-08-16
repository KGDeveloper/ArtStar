//
//  MusicManagementMyThemeVC.m
//  ArtStar
//
//  Created by abc on 5/30/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicManagementMyThemeVC.h"
#import "MusicManagementMyThemeCell.h"

@interface MusicManagementMyThemeVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic,strong) UIView *topScrollView;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,copy) NSString *titleStr;

@end

@implementation MusicManagementMyThemeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"管理我的话题" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArr = [NSMutableArray array];
    _titleStr = @"1";
    [self createData];
    [self setTbaleView];
}

//MARK:--------------------------------------------顶部选择框--------------------------------------------
- (UIView *)setTopScrollView{
    _topScrollView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    _topScrollView.backgroundColor = Color_ededed;
    NSArray *titleArr = @[@"我发表的",@"我回应的",@"最近浏览"];
    for (int i = 0; i < 3; i++) {
        if (i == 0) {
            [_topScrollView addSubview:[self createButton:CGRectMake(kScreenWidth/3*i, 0, kScreenWidth/3, 48) title:titleArr[i] color:Color_333333 font:SYFont(15)]];
        }else{
            [_topScrollView addSubview:[self createButton:CGRectMake(kScreenWidth/3*i, 0, kScreenWidth/3, 48) title:titleArr[i] color:Color_999999 font:SYFont(14)]];
        }
    }
    _line = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/6 - 15,48, 60, 2)];
    _line.backgroundColor = Color_333333;
    [_topScrollView addSubview:_line];
    
    return _topScrollView;
}
//MARK:----------------------------------------创建按钮------------------------------------------------
- (UIButton *)createButton:(CGRect)frmae title:(NSString *)title color:(UIColor *)color font:(UIFont *)font{
    UIButton *srcollBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    srcollBtu.frame = frmae;
    srcollBtu.backgroundColor = [UIColor whiteColor];
    [srcollBtu setTitle:title forState:UIControlStateNormal];
    [srcollBtu setTitleColor:color forState:UIControlStateNormal];
    srcollBtu.titleLabel.font = font;
    [srcollBtu addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    return srcollBtu;
}
//MARK:---------------------------------点击事件-------------------------------------------------------
- (void)selectAction:(UIButton *)sender{
    for (id obj in _topScrollView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *normalBtu = obj;
            [normalBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
            normalBtu.titleLabel.font = SYFont(14);
        }
    }
    if ([sender.currentTitle isEqualToString:@"我发表的"]) {
        _titleStr = @"1";
    }else if ([sender.currentTitle isEqualToString:@"我回应的"]){
        _titleStr = @"2";
    }else{
        _titleStr = @"3";
    }
    [self createData];
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    sender.titleLabel.font = SYFont(15);
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
}
- (void)createData{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:utBytopic parameters:@{@"query":@{@"page":@"1",@"rows":@"15"},@"uid":[KGUserInfo shareInterace].userID,@"utnexus":_titleStr} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            NSArray *tmp = result[@"data"];
            if (tmp.count > 0) {
                weakSelf.dataArr = [NSMutableArray arrayWithArray:tmp];
            }
        }
        [weakSelf.listView reloadData];
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}
//MARK:-----------------------------------------创建列表视图-----------------------------------------------
- (void)setTbaleView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.emptyDataSetSource = self;
    _listView.emptyDataSetDelegate = self;
    _listView.rowHeight = 50;
    _listView.tableHeaderView = [self setTopScrollView];
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MusicManagementMyThemeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MusicManagementMyThemeCell"];
    
}
//MARK:------------------------------------------delegate----------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
//MARK:-------------------------------------------datasource---------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicManagementMyThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicManagementMyThemeCell"];
    NSDictionary *dic = _dataArr[indexPath.row];
    if (![dic[@"imgList"] isKindOfClass:[NSNull class]]) {
        NSArray *imageArr = dic[@"imgList"];
        NSDictionary *imageDic = [imageArr firstObject];
        [cell.themeImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"locationimg"]]];
    }
    cell.themeLab.text = [NSString stringWithFormat:@"# %@ #",dic[@"topictitle"]];
    if (![dic[@"content"] isKindOfClass:[NSNull class]]) {
        NSData *contentData = [dic[@"content"] dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *strArr = [NSJSONSerialization JSONObjectWithData:contentData options:NSJSONReadingMutableContainers error:nil];
        NSString *str = strArr[0];
        for (int i = 1; i < strArr.count; i++) {
            str = [NSString stringWithFormat:@"%@%@",str,strArr[i]];
        }
        cell.themeIntruceLab.text = str;
    }
    return cell;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return Image(@"空空如也");
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *str = @"木有内容哦~";
    NSDictionary *attributes = @{NSFontAttributeName:SYFont(15),NSForegroundColorAttributeName:Color_999999};
    return [[NSAttributedString alloc]initWithString:str attributes:attributes];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 25.0;
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
