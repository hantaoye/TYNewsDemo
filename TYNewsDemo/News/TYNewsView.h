//
//  WCHomeNewsView.h
//  WCHomeTset
//
//  Created by Mac on 15/9/11.
//  Copyright (c) 2015年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYNewsView : UIView

/**
 *  设置数据 nsstring 类型
 */
- (void)setNewArray:(NSArray *)array clickAction:(void (^)(NSInteger index))action;

- (void)setNewsTextColor:(UIColor *)color;

- (void)setNewsFont:(UIFont *)font;

- (void)setNewsImageName:(NSString *)imageName;

- (void)setAnimationTimerInterval:(NSTimeInterval)interval;

- (void)startAnimation;
- (void)stopAnimation;

@end
