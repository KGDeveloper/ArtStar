//
//  CommunityVC.m
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "CommunityVC.h"

#import "KGMusicVC.h"
#import "MoviesVC.h"
#import "CommunityGoodFoodVC.h"
#import "CommunityExhibitionVC.h"
#import "CommunityDramaVC.h"
#import "CommunityLiteratureVC.h"
#import "HeadLinesVC.h"
#import "CommunityBooksVC.h"
#import "CommunityVideoVC.h"
#import "CommunityDesigVC.h"
#import "CommunityArtsVC.h"
#import "CommunityFriendsVC.h"
#import "CommunityInstitutionsVC.h"
#import "CommunityThemeVC.h"

@interface CommunityVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *dataArr;

@end

@implementation CommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArr = @[@"音乐",@"书籍",@"交友",@"头条",@"展览",@"戏剧",@"摄影",@"文学",@"机构",@"电影",@"美术",@"设计",@"话题",@"美食"];
    
    UITableView *listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavButtomHeight - NavTopHeight - 49)];
    listView.delegate = self;
    listView.dataSource = self;
    listView.rowHeight = 50;
    [self.view addSubview:listView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushNoTabBarViewController:[self pushController:_dataArr[indexPath.row]] animated:YES];
}

- (BaseVC *)pushController:(NSString *)name{
    if ([name isEqualToString:@"音乐"]) {
        return [[KGMusicVC alloc] init];
    }else if ([name isEqualToString:@"电影"]){
        return [[MoviesVC alloc]init];
    }else if ([name isEqualToString:@"话题"]){
        return [[CommunityThemeVC alloc] init];
    }else if ([name isEqualToString:@"机构"]){
        return [[CommunityInstitutionsVC alloc]init];
    }else if ([name isEqualToString:@"交友"]){
        return [[CommunityFriendsVC alloc]init];
    }else if ([name isEqualToString:@"美食"]){
        return [[CommunityGoodFoodVC alloc]init];
    }else if ([name isEqualToString:@"美术"]){
        return [[CommunityArtsVC alloc]init];
    }else if ([name isEqualToString:@"设计"]){
        return [[CommunityDesigVC alloc]init];
    }else if ([name isEqualToString:@"摄影"]){
        return [[CommunityVideoVC alloc]init];
    }else if ([name isEqualToString:@"书籍"]){
        return [[CommunityBooksVC alloc]init];
    }else if ([name isEqualToString:@"头条"]){
        return [[HeadLinesVC alloc]init];
    }else if ([name isEqualToString:@"文学"]){
        return [[CommunityLiteratureVC alloc]init];
    }else if ([name isEqualToString:@"戏剧"]){
        return [[CommunityDramaVC alloc]init];
    }else{
        return [[CommunityExhibitionVC alloc]init];
    }
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
