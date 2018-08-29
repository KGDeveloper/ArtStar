//
//  CommunityVC.m
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "CommunityVC.h"
#import <JavaScriptCore/JavaScriptCore.h>
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

@protocol JSObjcDelegate <JSExport>

- (void)clackBall;

@end

@interface CommunityVC ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property (nonatomic,copy) NSArray *dataArr;
@property (nonatomic,strong) JSContext *jsContext;

@end

@implementation CommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:2/255.0 green:10/255.0 blue:18/255.0 alpha:1];
    
    [self createWebView];
//    _dataArr = @[@"音乐",@"书籍",@"交友",@"头条",@"展览",@"戏剧",@"摄影",@"文学",@"机构",@"电影",@"美术",@"设计",@"话题",@"美食"];
//
//    UITableView *listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavButtomHeight - NavTopHeight - 49)];
//    listView.delegate = self;
//    listView.dataSource = self;
//    listView.rowHeight = 50;
//    [self.view addSubview:listView];
    
}

- (void)createWebView{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavButtomHeight)];
    webView.delegate = self;
    webView.dataDetectorTypes = UIDataDetectorTypeAll;
    webView.scrollView.scrollEnabled = NO;
    NSString *mainBoundPath = [[NSBundle mainBundle] bundlePath];
    NSString *basePath = [NSString stringWithFormat:@"%@",mainBoundPath];
    NSURL *baseUrl = [NSURL fileURLWithPath:basePath isDirectory:YES];
    NSString *htmlPath = [NSString stringWithFormat:@"%@/index.html",basePath];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:htmlString baseURL:baseUrl];
    [self.view addSubview:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"clicks"] = ^(){
        NSArray *args = [JSContext currentArguments];
        for (id obj in args) {
            NSLog(@"%@",obj);
        }
    };
}

- (void)clackBall{
    NSLog(@"212");
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
        KGMusicVC *vc = [[KGMusicVC alloc] init];
        vc.titleName = @"音乐";
        return vc;
    }else if ([name isEqualToString:@"电影"]){
        MoviesVC *vc = [[MoviesVC alloc]init];
        vc.titleName = @"电影";
        return vc;
    }else if ([name isEqualToString:@"话题"]){
        CommunityThemeVC *vc = [[CommunityThemeVC alloc] init];
        return vc;
    }else if ([name isEqualToString:@"机构"]){
        CommunityInstitutionsVC *vc = [[CommunityInstitutionsVC alloc]init];
        vc.titleName = @"机构";
        return vc;
    }else if ([name isEqualToString:@"交友"]){
        CommunityFriendsVC *vc = [[CommunityFriendsVC alloc]init];
        vc.titleName = @"交友";
        return vc;
    }else if ([name isEqualToString:@"美食"]){
        CommunityGoodFoodVC *vc = [[CommunityGoodFoodVC alloc]init];
        vc.titleName = @"美食";
        return vc;
    }else if ([name isEqualToString:@"美术"]){
        CommunityArtsVC *vc = [[CommunityArtsVC alloc]init];
        vc.titleName = @"美术";
        return vc;
    }else if ([name isEqualToString:@"设计"]){
        CommunityDesigVC *vc = [[CommunityDesigVC alloc]init];
        vc.titleName = @"设计";
        return vc;
    }else if ([name isEqualToString:@"摄影"]){
        CommunityVideoVC *vc = [[CommunityVideoVC alloc]init];
        vc.titleName = @"摄影";
        return vc;
    }else if ([name isEqualToString:@"书籍"]){
        CommunityBooksVC *vc = [[CommunityBooksVC alloc]init];
        vc.titleName = @"书籍";
        return vc;
    }else if ([name isEqualToString:@"头条"]){
        HeadLinesVC *vc = [[HeadLinesVC alloc]init];
        vc.titleName = @"头条";
        return vc;
    }else if ([name isEqualToString:@"文学"]){
        CommunityLiteratureVC *vc = [[CommunityLiteratureVC alloc]init];
        vc.titleName = @"文学";
        return vc;
    }else if ([name isEqualToString:@"戏剧"]){
        CommunityDramaVC *vc = [[CommunityDramaVC alloc]init];
        vc.titleName = @"戏剧";
        return vc;
    }else{
        CommunityExhibitionVC *vc = [[CommunityExhibitionVC alloc]init];
        vc.titleName = @"展览";
        return vc;
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
