//
//  HeadLinesDetaialAllCommentVC.m
//  ArtStar
//
//  Created by abc on 5/28/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HeadLinesDetaialAllCommentVC.h"
#import "HeadLinesDetaialCommentCell.h"
#import "KGCommentTF.h"

@interface HeadLinesDetaialAllCommentVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) KGCommentTF *commentTF;

@end

@implementation HeadLinesDetaialAllCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithTitle:@"全部评论(300)" image:Image(@"back")];
    
    [self setTbaleView];
    [self setLowView];
}
- (void)setLowView{
    UIView *lowView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    lowView.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:lowView atIndex:99];
    
    UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(lowView), 1)];
    tmp.backgroundColor = Color_ededed;
    [lowView addSubview:tmp];
    
    _commentTF = [[KGCommentTF alloc]initWithFrame:CGRectMake(15, 10, ViewWidth(lowView) - 30, 30)];
    _commentTF.placeholder = @"写一个评论 ...";
    _commentTF.font = SYFont(12);
    _commentTF.textColor = Color_333333;
    _commentTF.returnKeyType = UIReturnKeyGo;
    _commentTF.delegate = self;
    _commentTF.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
    _commentTF.layer.borderWidth = 1;
    _commentTF.layer.cornerRadius = 5;
    _commentTF.layer.masksToBounds = YES;
    [lowView addSubview:_commentTF];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //MARK:--在这里做发送--
    return YES;
}
- (void)setTbaleView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50) style:UITableViewStylePlain];
    _listView.backgroundColor = [UIColor whiteColor];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"HeadLinesDetaialCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HeadLinesDetaialCommentCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HeadLinesDetaialCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLinesDetaialCommentCell"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
