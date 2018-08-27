//
//  ChangeModelView.m
//  ArtStar
//
//  Created by abc on 5/7/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "ChangeModelView.h"
#import "CustomBtu.h"
#import "ChooseModelVC.h"

@interface ChangeModelView ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *ideaTF;//中间输入框
@property (nonatomic,strong) UIButton *leftBtu;//左侧按钮
@property (nonatomic,strong) UIButton *rightBtu;//:--右侧发送按钮--
@property (nonatomic,strong) CustomBtu *atOneBtu;//:--@所有人按钮--
@property (nonatomic,strong) CustomBtu *changeModel;//:--更换模板按钮--
@property (nonatomic,strong) CustomBtu *joinTheme;//:--参与话题按钮--
@property (nonatomic,assign) NSInteger index;

@end

@implementation ChangeModelView

- (instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _index = 0;
        [self setUI:type];
    }
    return self;
}

- (void)setUI:(NSInteger)type{
    __weak typeof(self) mySelf = self;
    //:--初始化--
    _ideaTF = [UITextField new];
    _leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    //:--加载到视图--
    [self sd_addSubviews:@[_ideaTF,_rightBtu,_leftBtu]];
    //:--左侧按钮--
    [_leftBtu setImage:Image(@"打开底部弹窗") forState:UIControlStateNormal];
    [_leftBtu addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    _leftBtu.sd_layout.leftSpaceToView(self, 15).topSpaceToView(self, 10).widthIs(30).heightIs(30);
    //:--右侧按钮--
    [_rightBtu setImage:Image(@"confirm") forState:UIControlStateNormal];
    [_rightBtu addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    _rightBtu.sd_layout.rightSpaceToView(self, 15).topEqualToView(_leftBtu).widthIs(30).heightIs(30);
    //:--中间输入框--
    _ideaTF.placeholder = @"写下你此刻的想法（100字以内）";
    _ideaTF.layer.borderColor = Color_cccccc.CGColor;
    _ideaTF.layer.borderWidth = 1;
    _ideaTF.delegate = self;
    _ideaTF.font = FZFont(12);
    _ideaTF.sd_layout.leftSpaceToView(_leftBtu, 15).rightSpaceToView(_rightBtu, 15).topEqualToView(_leftBtu).heightIs(30);
    if (type == 0) {
        //:--@所有人按钮--
        _atOneBtu = [[CustomBtu alloc]initWithFrame:CGRectMake(40,50 + 17.5, 55, 85) title:@"TO" image:Image(@"@")];
        _atOneBtu.font = 12;
        _atOneBtu.action = ^(NSString *str) {
            
        };
        [self addSubview:_atOneBtu];
        //:--参与话题按钮--
        _joinTheme = [[CustomBtu alloc]initWithFrame:CGRectMake(ViewWidth(self)/2 - 55/2,50 + 17.5, 55, 85) title:@"参与话题" image:Image(@"参与话题")];
        _joinTheme.font = 12;
        _joinTheme.action = ^(NSString *str) {
            
        };
        [self addSubview:_joinTheme];
        //:--更换模板按钮--
        _changeModel = [[CustomBtu alloc]initWithFrame:CGRectMake(ViewWidth(self) - 40 - 55, 50 + 17.5, 55, 85) title:@"更换模板" image:Image(@"replace")];
        _changeModel.font = 12;
        _changeModel.action = ^(NSString *str) {
            if ([mySelf.delegate respondsToSelector:@selector(changeModelViewClick)]) {
                [mySelf.delegate changeModelViewClick];
            }
        };
        [self addSubview:_changeModel];
    }else{
        //:--@所有人按钮--
        _atOneBtu = [[CustomBtu alloc]initWithFrame:CGRectMake((ViewWidth(self) - 55 * 2)/3,50 + 17.5, 55, 85) title:@"TO" image:Image(@"@")];
        _atOneBtu.font = 12;
        _atOneBtu.action = ^(NSString *str) {
            
        };
        [self addSubview:_atOneBtu];

        //:--更换模板按钮--
        _changeModel = [[CustomBtu alloc]initWithFrame:CGRectMake((ViewWidth(self) - 55 * 2)/3*2 + 55, 50 + 17.5, 55, 85) title:@"更换模板" image:Image(@"replace")];
        _changeModel.font = 12;
        _changeModel.action = ^(NSString *str) {
            if ([mySelf.delegate respondsToSelector:@selector(changeModelViewClick)]) {
                [mySelf.delegate changeModelViewClick];
            }
        };
        [self addSubview:_changeModel];
    }
    
}
//MARK:--TextFieldDelegate--
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length >= 20) {
        if (string.length > 0) {
            if ([self.delegate respondsToSelector:@selector(textFieldLenght)]) {
                [self.delegate textFieldLenght];
            }
            return NO;
        }else{
            return YES;
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(sendStringToView:index:)]) {
            [self.delegate sendStringToView:textField.text index:self.index];
        }
        return YES;
    }
}
//MARK:--左侧按钮点击事件--
- (void)leftClick:(UIButton *)sender{
    if ([sender.currentImage isEqual:Image(@"打开底部弹窗")]) {
        [sender setImage:Image(@"putaway") forState:UIControlStateNormal];
    }else{
        [sender setImage:Image(@"打开底部弹窗") forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(changeViewFrame:)]) {
        [self.delegate changeViewFrame:self.frame];
    }
}
//MARK:--右侧按钮点击事件--
- (void)rightClick{
    if ([self.delegate respondsToSelector:@selector(sendStringToView:index:)]) {
        [self.delegate sendStringToView:_ideaTF.text index:self.index];
    }
    if (self.ideaTF.text.length > 1) {
        self.index += 1;
    }
    if (self.index == 5) {
        self.index = 0;
    }
    self.ideaTF.text = @"";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
