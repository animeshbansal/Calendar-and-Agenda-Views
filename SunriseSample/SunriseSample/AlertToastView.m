//
//  AlertToastView.m
//  Orlando
//
//  Created by animesh on 5/15/16.
//  Copyright © 2016 animesh. All rights reserved.
//

#import "AlertToastView.h"

const CGFloat AlertToastViewOrigin                       = 0.0f;
const CGFloat AlertToastViewFrameHeight                  = 70.0f;
const CGFloat AlertToastViewMessageLabelWidth            = 40.0f;
const CGFloat AlertToastViewMessageLabelHeight           = 50.0f;
const CGFloat AlertToastViewMessageLabelVerticalPadding  = 0.0f;
const CGFloat AlertToastViewHorizontalPadding            = 10.0f;
const CGFloat AlertToastViewMessageFontSize              = 20.0f;
const CGFloat AlertToastViewScaleFactor                  = 7.0f;
const CGFloat AlertToastViewScaleFactorNumberOfLines     = 0.0f;

@interface AlertToastView()
@property(strong,nonatomic)UILabel *messageLabel;

@end

@implementation AlertToastView

#pragma mark - showToastView

-(void)showToastView:(UIView *)view viewColor:(UIColor *)viewColor message:(NSString *)message{
    
    NSTimer* timer;
    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hideToastView) userInfo:nil repeats:NO];
    self.messageLabel = [[UILabel alloc]init];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.backgroundColor = viewColor;
    self.messageLabel.textColor = [UIColor whiteColor];

    NSDictionary *attributes = @{NSFontAttributeName: self.messageLabel.font};
    
    CGRect rect = [message boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attributes
                                        context:nil];
    self.messageLabel.text = message;
    self.frame = CGRectMake(AlertToastViewOrigin, AlertToastViewOrigin, CGRectGetWidth(view.frame),CGRectGetHeight(rect) + AlertToastViewFrameHeight);
    self.messageLabel.frame= CGRectMake(AlertToastViewHorizontalPadding, AlertToastViewMessageLabelVerticalPadding, CGRectGetWidth(view.frame) - AlertToastViewMessageLabelWidth, CGRectGetHeight(rect) + AlertToastViewMessageLabelHeight);
    self.messageLabel.minimumScaleFactor = AlertToastViewScaleFactor;
    self.messageLabel.numberOfLines = AlertToastViewScaleFactorNumberOfLines;
    [self addSubview:self.messageLabel];
}

#pragma mark - hideToastView

-(void)hideToastView {
    
    self.backgroundColor=[UIColor clearColor];
    self.messageLabel.hidden = true;
    [self removeFromSuperview];
}

@end
