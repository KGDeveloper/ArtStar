//
//  ReadBooksDetailVC.m
//  ArtStar
//
//  Created by abc on 6/5/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "ReadBooksDetailVC.h"
#import "ReadBooksHeaderViewCell.h"
#import "BuyBooksCell.h"
#import "BooksIntroudceCell.h"
#import "MusicCommentCell.h"
#import "BooksYourLoveCell.h"
#import "ReadBooksCell.h"
#import "ReadBooksWriteYourIdeaVC.h"

@interface ReadBooksDetailVC ()<UITableViewDelegate,UITableViewDataSource,ReadBooksHeaderViewCellDelegate>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation ReadBooksDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTableView];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44 - NavTopHeight, kScreenWidth, kScreenHeight - 44 + NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"ReadBooksHeaderViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ReadBooksHeaderViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"BuyBooksCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BuyBooksCell"];
    [_listView registerNib:[UINib nibWithNibName:@"BooksIntroudceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BooksIntroudceCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MusicCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MusicCommentCell"];
    [_listView registerNib:[UINib nibWithNibName:@"BooksYourLoveCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BooksYourLoveCell"];
    [_listView registerNib:[UINib nibWithNibName:@"ReadBooksCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ReadBooksCell"];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return kScreenWidth/750*480 + 355;
    }else if(indexPath.row == 1){
        return 70;
    }else if(indexPath.row == 2){
        return 180;
    }else if(indexPath.row == 3){
        return 220;
    }else if(indexPath.row == 4){
        return 35;
    }else{
        return 155;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ReadBooksHeaderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReadBooksHeaderViewCell"];
        cell.returnTop.constant = NavTopHeight - 34;
        cell.shareTop.constant = NavTopHeight - 34;
        cell.delegate = self;
        return cell;
    }else if(indexPath.row == 1){
        BuyBooksCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyBooksCell"];
        return cell;
    }else if(indexPath.row == 2){
        BooksIntroudceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BooksIntroudceCell"];
        cell.detaialLab.attributedText = [TransformChineseToPinying string:@"小时候在课本里看到《老人与海》的片段，想当然的认为那是海明威早期的作品，因为那种简洁的语言，在孩童们的眼中，实在是太好理解，相比较中国的古文或诗词，那种翻译过来的文章却更好懂，因为好懂，所以居然会生出轻看的意思。长大后读全本的《老人与海》，在前言里发现，原来这本书出版于1952年，而《太阳照常升起》、《永别了，武器》、《丧钟为谁而鸣》等作品，却是在此前的二三十年代写就的。大学时候有时间读这些书，发现那些书里的故事更具备“迷惘的一代”的特质，但是书中不间断的对话、永不停歇的酒会、男人女人之间的欲念纠缠，也曾经让我几次废书而叹：为什么我就读不完这些经典呢？" font:SYFont(14) space:10];
        return cell;
    }else if(indexPath.row == 3){
        MusicCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicCommentCell"];
        cell.topCount = @"3.5";
        cell.centerCount = @"3.0";
        return cell;
    }else if(indexPath.row == 4){
        BooksYourLoveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BooksYourLoveCell"];
        return cell;
    }else{
        ReadBooksCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReadBooksCell"];
        return cell;
    }
}
//MARK:----------------------------------------ReadBooksHeaderViewCellDelegate------------------------------------------------
- (void)popViewControler{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)shareBooks{
    
}
- (void)sendMyIdea:(NSString *)idea{
    ReadBooksWriteYourIdeaVC *vc = [[ReadBooksWriteYourIdeaVC alloc]init];
    vc.status = idea;
    [self pushNoTabBarViewController:vc animated:YES];
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
