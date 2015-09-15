//
//  WCHomeNewsView.m
//  WCHomeTset
//
//  Created by Mac on 15/9/11.
//  Copyright (c) 2015年 TY. All rights reserved.
//

#define WCHomeNewsImageViewWH 20

#import "TYNewsView.h"

@interface TYNewsView ()

@property (copy, nonatomic) NSMutableArray *newsArray;

@property (copy, nonatomic) void (^clickAction)(NSInteger index);

@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) NSTimeInterval interval;

@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UILabel *showLabel;
@property (strong, nonatomic) UILabel *bottomLabel;

@property (assign, nonatomic) NSInteger showIndex;
@property (assign, nonatomic) NSInteger willShowIndex;


@end

@implementation TYNewsView

- (void)dealloc {
    [self stopAnimation];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self _setup];
    }
    return self;
}


#pragma mark - action

- (void)setNewArray:(NSArray *)array clickAction:(void (^)(NSInteger))action {
    if (!array.count) {
        return;
    }
    _newsArray = [array mutableCopy];
    // 根据数据源显示起始内容
    _showIndex = 0;
    _willShowIndex = (_showIndex + 1) % array.count;
    
    [self _updateLabels];
    
    if (action) {
        _clickAction = [action copy];
    }
}

- (void)setNewsTextColor:(UIColor *)color {
    if (color) {
        _showLabel.textColor = color;
        _bottomLabel.textColor = color;
    }
}

- (void)setNewsFont:(UIFont *)font {
    if (font) {
         _bottomLabel.font = font;
        _showLabel.font = font;
    }
}

- (void)setNewsImageName:(NSString *)imageName {
    if (imageName.length) {
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            _imageView.image = image;
        }
    }
}

- (void)setAnimationTimerInterval:(NSTimeInterval)interval {
    if (interval > 0) {
        _interval = interval;
    }
}

- (void)_timerFireMethod {
    _showIndex ++ ;
    _willShowIndex ++ ;
    _showIndex = _showIndex % _newsArray.count;
    _willShowIndex = _willShowIndex % _newsArray.count;
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat height = -_contentView.bounds.size.height;
        _showLabel.transform = CGAffineTransformMakeTranslation(0, height);
        _bottomLabel.transform = CGAffineTransformMakeTranslation(0, height);
    } completion:^(BOOL finished) {
        _showLabel.text = _newsArray[_showIndex];
        _showLabel.transform = CGAffineTransformIdentity;
        _bottomLabel.text = _newsArray[_willShowIndex];
        _bottomLabel.transform = CGAffineTransformIdentity;
    }];
}

- (void)startAnimation {
    [_timer invalidate];
    if (_newsArray.count) {
        if (!self.timer) {
            _timer = [NSTimer timerWithTimeInterval:_interval target:self selector:@selector(_timerFireMethod) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        }
    }
}

- (void)stopAnimation {
    [_timer invalidate];
    _timer = nil;
}

- (void)_labelClicked {
    if (_clickAction) {
        _clickAction (_showIndex);
    }
}

#pragma mark - setup

- (void)_updateLabels {
    _showLabel.text = _newsArray[_showIndex];
    _bottomLabel.text = _newsArray[_willShowIndex];
}

- (UILabel *)_createLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16.0];
    label.textColor = [UIColor blackColor];
    label.userInteractionEnabled = YES;
    label.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_labelClicked)];
    [label addGestureRecognizer:gesture];
    return label;
}

- (void)_setup {
    _interval = 4.0;
    self.clipsToBounds = YES;
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor clearColor];
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_contentView];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.image = [UIImage imageNamed:@"loudspeaker"];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_imageView];
    
    //设置layout
    NSDictionary *metrics = @{@"HW" : @(WCHomeNewsImageViewWH)};
    NSDictionary *views = NSDictionaryOfVariableBindings(_imageView, _contentView);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_imageView(==HW)]-10-[_contentView]-0-|" options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_contentView]-0-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imageView(==HW)]" options:0 metrics:metrics views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    _showLabel = [self _createLabel];
    _bottomLabel = [self _createLabel];
    [_contentView addSubview:_showLabel];
    [_contentView addSubview:_bottomLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = _contentView.frame;
    _showLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _bottomLabel.frame = CGRectMake(0, frame.size.height, frame.size.width, frame.size.height);
}

@end
