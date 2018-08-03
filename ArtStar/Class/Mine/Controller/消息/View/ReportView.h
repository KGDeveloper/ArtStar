//
//  ReportView.h
//  ArtStar
//
//  Created by abc on 6/8/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReportViewDelegate <NSObject>

- (void)sendReportResonToServer:(NSString *)reson;

@end

@interface ReportView : UIView

@property (nonatomic,weak) id<ReportViewDelegate>delegate;

@end
