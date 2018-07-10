//
//  PreviewVC.m
//  ArtStar
//
//  Created by abc on 5/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "PreviewVC.h"
#import "PreviewVerticalView.h"
#import "PreviewHorizontalView.h"
#import "PreviewVideoPlayView.h"
#import "ZLPlayer.h"

@interface PreviewVC ()<PreviewVideoPlayViewDelegate>

@property (nonatomic,strong) UIImageView *headerIamge;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,strong) PreviewHorizontalView *horizontalView;
@property (nonatomic,strong) PreviewVerticalView *verticalView;
@property (nonatomic,strong) PreviewVideoPlayView *videoView;
@property (nonatomic,strong) ZLPlayer *playVideo;

@end

@implementation PreviewVCModel
@end

@implementation PreviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"预览" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"确定" image:nil];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    self.height = NavTopHeight + 30 + 28;
    
    [self setUI];
}

- (void)rightNavBtuAction:(UIButton *)sender{
    NSArray *strArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:strArr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSData *imgData = [NSJSONSerialization dataWithJSONObject:_model.imageURLs options:NSJSONWritingPrettyPrinted error:nil];
    NSString *imgStr = [[NSString alloc]initWithData:imgData encoding:NSUTF8StringEncoding];
    
    NSData *idsData = [NSJSONSerialization dataWithJSONObject:_model.ids options:NSJSONWritingPrettyPrinted error:nil];
    NSString *idsStr = [[NSString alloc]initWithData:idsData encoding:NSUTF8StringEncoding];
    
    [KGRequestNetWorking postWothUrl:ReleaseFriendTimelineAddfriendMessage parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"content":jsonStr,@"location":_model.location,@"visitPermission":_model.visitPermission,@"composing":_model.composing,@"type":_model.typeStr,@"title":_model.title,@"imageURLs":imgStr,@"topicType":_model.topicType,@"ids":idsStr} succ:^(id result) {
        
    } fail:^(NSString *error) {
        
    }];
}

//MARK:--选择加载页面--
- (void)setUI{
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _height)];
    back.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:back];
    
    _headerIamge = [[UIImageView alloc]initWithFrame:CGRectMake(15, NavTopHeight + 15, 28, 28)];
    _headerIamge.image = Image(@"round");
    _headerIamge.layer.cornerRadius = 14;
    _headerIamge.layer.masksToBounds = YES;
    [self.view addSubview:_headerIamge];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(25 + 28, NavTopHeight + 15 + 4, kScreenWidth - 25 - 28, 20)];
    _nameLabel.text = @"遥不可及";
    _nameLabel.font = SYFont(15);
    [self.view addSubview:_nameLabel];
    
    switch (self.type) {
        case EditTypeVideo:
            [self setVideoView];
            break;
        case EditTypeTheme:
            [self setThemeView];
            break;
        default:
            [self setGraphicView];
            break;
    }
}
//MARK:--话题页面--
- (void)setThemeView{
    switch (_themeType) {
        case EditThemeTypeCircular:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeCircular];
            self.horizontalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.horizontalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = @"北京.望春园";
            self.horizontalView.themeStr = @"# 哈哈哈 #";
            self.horizontalView.type = TextAlignmentTypeCenter;
            break;
        case EditThemeTypeRightTop:
            [self setUpVerticalView:LabelTextLocationTypeTop];
            self.verticalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.verticalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.verticalView.timeStr = @"5分钟前";
            self.verticalView.locationStr = @"北京.望春园";
            self.verticalView.themeStr = @"# 哈哈哈 #";
            break;
        case EditThemeTypeRightCenter:
            [self setUpVerticalView:LabelTextLocationTypeCenter];
            self.verticalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.verticalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.verticalView.timeStr = @"5分钟前";
            self.verticalView.locationStr = @"北京.望春园";
            self.verticalView.themeStr = @"# 哈哈哈 #";
            break;
        case EditThemeTypeTopLeft:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeLabelTop];
            self.horizontalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.horizontalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = @"北京.望春园";
            self.horizontalView.themeStr = @"# 哈哈哈 #";
            self.horizontalView.type = TextAlignmentTypeLeft;
            break;
        case EditThemeTypeTopCenter:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeLabelTop];
            self.horizontalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.horizontalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = @"北京.望春园";
            self.horizontalView.themeStr = @"# 哈哈哈 #";
            self.horizontalView.type = TextAlignmentTypeCenter;
            break;
        case EditThemeTypeTopRight:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeLabelTop];
            self.horizontalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.horizontalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = @"北京.望春园";
            self.horizontalView.themeStr = @"# 哈哈哈 #";
            self.horizontalView.type = TextAlignmentTypeRight;
            break;
        case EditThemeTypeLeft:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeImageTop];
            self.horizontalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.horizontalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = @"北京.望春园";
            self.horizontalView.themeStr = @"# 哈哈哈 #";
            self.horizontalView.type = TextAlignmentTypeLeft;
            break;
        case EditThemeTypeCenter:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeImageTop];
            self.horizontalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.horizontalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = @"北京.望春园";
            self.horizontalView.themeStr = @"# 哈哈哈 #";
            self.horizontalView.type = TextAlignmentTypeCenter;
            break;
        default:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeImageTop];
            self.horizontalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.horizontalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = @"北京.望春园";
            self.horizontalView.themeStr = @"# 哈哈哈 #";
            self.horizontalView.type = TextAlignmentTypeRight;
            break;
    }
}
//MARK:--图文页面--
- (void)setVideoView{
    switch (_videoType) {
        case EditVideoTypeOnlyVideo:
            [self setUpVideoViewframe:CGRectMake(0, _height, kScreenWidth, photoViewHeight + 50) type:VideoViewTextTypeOnlyVideo];
            self.videoView.timeStr = @"5分钟前";
            self.videoView.locationStr = @"北京.望春园";
            self.videoView.themeStr = @"# 哈哈哈 #";
            break;
        case EditVideoTypeTopLeft:
            [self setUpVideoViewframe:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:VideoViewTextTypeTopLeftText];
            self.videoView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.videoView.timeStr = @"5分钟前";
            self.videoView.locationStr = @"北京.望春园";
            self.videoView.themeStr = @"# 哈哈哈 #";
            self.videoView.type = TextAlignmentLeft;
            break;
        case EditVideoTypeTopCenter:
            [self setUpVideoViewframe:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:VideoViewTextTypeTopCenterText];
            self.videoView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.videoView.timeStr = @"5分钟前";
            self.videoView.locationStr = @"北京.望春园";
            self.videoView.themeStr = @"# 哈哈哈 #";
            self.videoView.type = TextAlignmentCenter;
            break;
        case EditVideoTypeTopRight:
            [self setUpVideoViewframe:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:VideoViewTextTypeTopRightText];
            self.videoView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.videoView.timeStr = @"5分钟前";
            self.videoView.locationStr = @"北京.望春园";
            self.videoView.themeStr = @"# 哈哈哈 #";
            self.videoView.type = TextAlignmentRight;
            break;
        case EditVideoTypeLeft:
            [self setUpVideoViewframe:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:VideoViewTextTypeButtomLeftText];
            self.videoView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.videoView.timeStr = @"5分钟前";
            self.videoView.locationStr = @"北京.望春园";
            self.videoView.themeStr = @"# 哈哈哈 #";
            self.videoView.type = TextAlignmentLeft;
            break;
        case EditVideoTypeCenter:
            [self setUpVideoViewframe:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:VideoViewTextTypeButtomCenterText];
            self.videoView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.videoView.timeStr = @"5分钟前";
            self.videoView.locationStr = @"北京.望春园";
            self.videoView.themeStr = @"# 哈哈哈 #";
            self.videoView.type = TextAlignmentTypeCenter;
            break;
        default:
            [self setUpVideoViewframe:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:VideoViewTextTypeButtomRightText];
            self.videoView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.videoView.timeStr = @"5分钟前";
            self.videoView.locationStr = @"北京.望春园";
            self.videoView.themeStr = @"# 哈哈哈 #";
            self.videoView.type = TextAlignmentRight;
            break;
    }
}
//MARK:--视频页面--
- (void)setGraphicView{
    switch (_graphicType) {
        case EditGraphicTypeOnlyTitle:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 200) type:LabelAndImageTypeOnlyLabel];
            self.horizontalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = @"北京.望春园";
            self.horizontalView.themeStr = @"# 哈哈哈 #";
            self.horizontalView.type = TextAlignmentTypeCenter;
            break;
        case EditGraphicTypeOnlyPicture:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, photoViewHeight + 50) type:LabelAndImageTypeOnlyImage];
            self.horizontalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = @"北京.望春园";
            self.horizontalView.themeStr = @"# 哈哈哈 #";
            break;
        case EditGraphicTypeCircular:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeCircular];
            self.horizontalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.horizontalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = @"北京.望春园";
            self.horizontalView.themeStr = @"# 哈哈哈 #";
            self.horizontalView.type = TextAlignmentTypeCenter;
            break;
        case EditGraphicTypeRightTop:
            [self setUpVerticalView:LabelTextLocationTypeTop];
            self.verticalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.verticalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.verticalView.timeStr = @"5分钟前";
            self.verticalView.locationStr = @"北京.望春园";
            self.verticalView.themeStr = @"# 哈哈哈 #";
            break;
        case EditGraphicTypeRightCenter:
            [self setUpVerticalView:LabelTextLocationTypeCenter];
            self.verticalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.verticalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.verticalView.timeStr = @"5分钟前";
            self.verticalView.locationStr = @"北京.望春园";
            self.verticalView.themeStr = @"# 哈哈哈 #";
            break;
        case EditGraphicTypeTopLeft:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeLabelTop];
            self.horizontalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.horizontalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = @"北京.望春园";
            self.horizontalView.themeStr = @"# 哈哈哈 #";
            self.horizontalView.type = TextAlignmentTypeLeft;
            break;
        case EditGraphicTypeTopCenter:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeLabelTop];
            self.horizontalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.horizontalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = @"北京.望春园";
            self.horizontalView.themeStr = @"# 哈哈哈 #";
            self.horizontalView.type = TextAlignmentTypeCenter;
            break;
        case EditGraphicTypeTopRight:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeLabelTop];
            self.horizontalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.horizontalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = @"北京.望春园";
            self.horizontalView.themeStr = @"# 哈哈哈 #";
            self.horizontalView.type = TextAlignmentTypeRight;
            break;
        case EditGraphicTypeLeft:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeImageTop];
            self.horizontalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.horizontalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = @"北京.望春园";
            self.horizontalView.themeStr = @"# 哈哈哈 #";
            self.horizontalView.type = TextAlignmentTypeLeft;
            break;
        case EditGraphicTypeCenter:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeImageTop];
            self.horizontalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.horizontalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = @"北京.望春园";
            self.horizontalView.themeStr = @"# 哈哈哈 #";
            self.horizontalView.type = TextAlignmentTypeCenter;
            break;
        default:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeImageTop];
            self.horizontalView.titleArr = @[@"君不见，黄河之水天上来，奔流到海不复回",@"君不见，高堂明镜悲白发，朝成青丝暮成雪",@"人生得意须尽欢，莫使金樽空对月",@"天生我材必有用，千金散尽还复来",@"烹羊宰牛且为乐，会须一饮三百杯"];
            self.horizontalView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = @"北京.望春园";
            self.horizontalView.themeStr = @"# 哈哈哈 #";
            self.horizontalView.type = TextAlignmentTypeRight;
            break;
    }
}
- (void)setHViewfrmae:(CGRect)frmae type:(LabelAndImageType)type{
    _horizontalView = [[PreviewHorizontalView alloc]initWithFrame:frmae type:type];
    _horizontalView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_horizontalView];
}
- (void)setUpVerticalView:(LabelTextLocationType)type{
    _verticalView = [[PreviewVerticalView alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth, 281 + 100) type:type];
    _verticalView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_verticalView];
}
- (void)setUpVideoViewframe:(CGRect)frame type:(VideoViewTextType)type{
    _videoView = [[PreviewVideoPlayView alloc]initWithFrame:frame type:type];
    _videoView.backgroundColor = [UIColor whiteColor];
    _videoView.delegate = self;
    [self.view addSubview:_videoView];
}
- (void)playVideoOnController{
//    self.playVideo.videoUrl = [NSURL URLWithString:self.model.videoData];
    self.playVideo.hidden = NO;
    [self.playVideo play];
    self.navigationController.navigationBar.hidden = YES;
}
- (ZLPlayer *)playVideo{
    if (!_playVideo) {
        _playVideo = [[ZLPlayer alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.view insertSubview:_playVideo belowSubview:self.view];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchVideoPlay)];
        [_playVideo addGestureRecognizer:tap];
    }
    return _playVideo;
}
- (void)touchVideoPlay{
    [self.playVideo reset];
    self.playVideo.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
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
