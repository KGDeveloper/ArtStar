//
//  SearchBarView.m
//  ArtStar
//
//  Created by abc on 5/14/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "SearchBarView.h"
#import "KGTextField.h"

@interface SearchBarView ()<UITextFieldDelegate,KGTextFieldDelegate>

@property (nonatomic,strong) KGTextField *searchTF;

@end

@implementation SearchBarView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_ededed;
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    //:--设置背景图--
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 7.5, ViewWidth(self) - 30, ViewHeight(self) - 15)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    [self addSubview:backView];
    //:--设置左侧放大镜--
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 15, 15)];
    image.image = Image(@"search");
    [backView addSubview:image];
    //:--设置搜索框--
    _searchTF = [[KGTextField alloc]initWithFrame:CGRectMake(30, 5, ViewWidth(backView) - 40, 15)];
    _searchTF.placeholder = @"你在哪里？";
    _searchTF.font = SYFont(12);
    _searchTF.delegate = self;
    _searchTF.kgDelegate = self;
    _searchTF.returnKeyType = UIReturnKeySearch;
    [backView addSubview:_searchTF];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.delegate respondsToSelector:@selector(sendSearhTextToCOntroller:)]) {
        [self.delegate sendSearhTextToCOntroller:textField.text];
    }
    return YES;
}
- (void)textFieldDeleteBackward:(KGTextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        if ([self.delegate respondsToSelector:@selector(sendSearhTextToCOntroller:)]) {
            [self.delegate sendSearhTextToCOntroller:textField.text];
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(sendSearhTextToCOntroller:)]) {
        [self.delegate sendSearhTextToCOntroller:textField.text];
    }
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
