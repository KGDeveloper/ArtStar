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

@interface CommunityVC ()<UIWebViewDelegate>

@property (nonatomic,copy) NSArray *dataArr;
@property (nonatomic,strong) JSContext *jsContext;

@end

@implementation CommunityVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavBackGroundClearColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createWebView];
}

- (void)createWebView{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, -NavTopHeight, kScreenWidth, kScreenHeight - NavButtomHeight + NavTopHeight)];
    webView.delegate = self;
    webView.dataDetectorTypes = UIDataDetectorTypeAll;
    webView.scrollView.scrollEnabled = NO;
    [webView sizeToFit];
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
    __weak typeof(self) weakSelf = self;
    self.jsContext[@"clicks"] = ^(){
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isOnLine"] integerValue] == 0) {
            NSArray *args = [JSContext currentArguments];
            [args enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf pushNoTabBarViewController:[weakSelf pushController:[NSString stringWithFormat:@"%@",[args firstObject]]] animated:YES];
                });
                *stop = YES;
            }];
        }
    };
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
