//
//  MusicManagementMyThemeVC.m
//  ArtStar
//
//  Created by abc on 5/30/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicManagementMyThemeVC.h"
#import "MusicManagementMyThemeCell.h"

@interface MusicManagementMyThemeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *topScrollView;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UITableView *listView;

@end

@implementation MusicManagementMyThemeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"管理我的话题" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTbaleView];
}

//MARK:--------------------------------------------顶部选择框--------------------------------------------
- (UIView *)setTopScrollView{
    _topScrollView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    _topScrollView.backgroundColor = Color_ededed;
    NSArray *titleArr = @[@"全部话题",@"我发表的",@"我回应的",@"最近浏览"];
    for (int i = 0; i < 4; i++) {
        if (i == 0) {
            [_topScrollView addSubview:[self createButton:CGRectMake(kScreenWidth/4*i, 0, kScreenWidth/4, 48) title:titleArr[i] color:Color_333333 font:SYFont(15)]];
        }else{
            [_topScrollView addSubview:[self createButton:CGRectMake(kScreenWidth/4*i, 0, kScreenWidth/4, 48) title:titleArr[i] color:Color_999999 font:SYFont(14)]];
        }
    }
    _line = [[UIView alloc]initWithFrame:CGRectMake(15,48, 60, 2)];
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
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    sender.titleLabel.font = SYFont(15);
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
}
//MARK:-----------------------------------------创建列表视图-----------------------------------------------
- (void)setTbaleView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.rowHeight = 50;
    _listView.tableHeaderView = [self setTopScrollView];
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MusicManagementMyThemeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MusicManagementMyThemeCell"];
    
}
//MARK:------------------------------------------delegate----------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
//MARK:-------------------------------------------datasource---------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicManagementMyThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicManagementMyThemeCell"];
    return cell;
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
