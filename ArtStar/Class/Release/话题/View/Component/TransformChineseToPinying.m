//
//  TransformChineseToPinying.m
//  ArtStar
//
//  Created by abc on 5/15/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "TransformChineseToPinying.h"

@implementation TransformChineseToPinying

+ (NSString *)transform:(NSString *)chinese{
    //:--将NSString转换成NSMtableString--
    NSMutableString *pinyin = [chinese mutableCopy];
    //:--将汉字转换成拼音（带音标）--
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //:--去掉拼音的音标--
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //:--返回拼音结果--
    return pinyin;
}

+ (BOOL)containsString:(NSString *)str text:(NSString *)text{
    if ([str containsString:text]) {
        return YES;
    }else{
        return NO;
    }
}

+ (CGFloat)stringWidthFromString:(NSString *)str font:(UIFont *)font width:(CGFloat)width{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.width;
}

+ (CGFloat)stringWidthFromString:(NSString *)str font:(UIFont *)font height:(CGFloat)height{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGSize size = [str boundingRectWithSize:CGSizeMake(22, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

+ (NSAttributedString *)string:(NSString *)text font:(UIFont *)font space:(NSInteger)space{
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc]init];
    paragrapStyle.lineSpacing = space;
    paragrapStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragrapStyle};
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:text attributes:attributes];
    return string;
}

+ (CGFloat)heightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}



@end
