//
//  CommonView.m
//  W9_CustomGraph
//
//  Created by 김성희 on 2015. 5. 2..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import "CommonUtilView.h"

@implementation CommonUtilView

static NSArray *colorList = nil;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (CATextLayer *)createTextLayer:(UIView *)view text:(NSString *)text font:(UIFont *)font color:(UIColor *)color {
    CATextLayer *textLayer = [CATextLayer layer];
    
    NSDictionary *textAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               font, NSFontAttributeName,
                               color, NSForegroundColorAttributeName,
                               nil];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text
                                                                  attributes:textAttrs];
    CGRect textSize = [text boundingRectWithSize:CGSizeMake(view.frame.size.width, view.frame.size.height)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:textAttrs
                                         context:nil];
    [textLayer setString:attrStr];
    
    [textLayer setAnchorPoint:CGPointMake(0.5, 0.5)];
    [textLayer setAlignmentMode:kCAAlignmentCenter];
    [textLayer setBackgroundColor:[UIColor clearColor].CGColor];
    
    [CATransaction setDisableActions:YES];
    [textLayer setFrame:CGRectMake(0, 0, textSize.size.width, textSize.size.height)];
    [CATransaction setDisableActions:NO];
    
    return textLayer;
}

+ (UIColor *)colorAtIndex:(int)index {
    if (colorList == nil) {
        colorList = [NSArray arrayWithObjects:
                     [UIColor colorWithRed:0/255.0 green:234/255.0 blue:210/255.0 alpha:1],
                     [UIColor colorWithRed:62/255.0 green:174/255.0 blue:229/255.0 alpha:1],
                     [UIColor colorWithRed:154/255.0 green:45/255.0 blue:228/255.0 alpha:1],
                     [UIColor colorWithRed:226/255.0 green:0/255.0 blue:227/255.0 alpha:1],
                     [UIColor colorWithRed:243/255.0 green:53/255.0 blue:96/255.0 alpha:1],
                     [UIColor colorWithRed:238/255.0 green:130/255.0 blue:75/255.0 alpha:1],
                     [UIColor colorWithRed:154/255.0 green:241/255.0 blue:81/255.0 alpha:1],
                     [UIColor colorWithRed:0/255.0 green:244/255.0 blue:85/255.0 alpha:1], nil];
    }

    int realIndex = index;
    
    if (realIndex >= colorList.count)
        realIndex = index % colorList.count;
    
    return (UIColor *)colorList[realIndex];
}

@end
