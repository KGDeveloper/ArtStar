//
//  SearchBarView.h
//  ArtStar
//
//  Created by abc on 5/14/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchBarViewDelegate <NSObject>

- (void)sendSearhTextToCOntroller:(NSString *)text;

@end

@interface SearchBarView : UIView

@property (nonatomic,weak) id<SearchBarViewDelegate>delegate;

@end
