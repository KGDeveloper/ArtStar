//
//  KGLowCommentView.h
//  ArtStar
//
//  Created by abc on 5/25/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGLowCommentView : UIView

@property (nonatomic,strong) void(^actionWithTitle)(NSString *title,NSString *text);

@end
