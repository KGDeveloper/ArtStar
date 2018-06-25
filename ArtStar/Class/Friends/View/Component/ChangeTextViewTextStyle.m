//
//  ChangeTextViewTextStyle.m
//  ArtStar
//
//  Created by abc on 5/21/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "ChangeTextViewTextStyle.h"


@implementation ChangeTextViewTextStyle

+ (UITextView *)changeTextView:(UITextView *)textView text:(NSString *)text alignment:(NSTextAlignment)alignment{
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 10;
    paragraphStyle.alignment = alignment;
    NSDictionary *attributes = @{NSFontAttributeName:FZFont(12),NSParagraphStyleAttributeName:paragraphStyle};
    textView.attributedText = [[NSAttributedString alloc]initWithString:text attributes:attributes];
    return textView;
    
}


@end
