//
//  MsgTapNoteVC.h
//  ArtStar
//
//  Created by abc on 6/8/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "BaseVC.h"

@interface MsgTapNoteVC : BaseVC

@property (nonatomic,copy) NSString *userID;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) void(^sendNoteName)(NSString *noteName);

@end
