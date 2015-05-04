//
//  CommonView.h
//  W9_CustomGraph
//
//  Created by 김성희 on 2015. 5. 2..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonUtilView : UIView

+ (CATextLayer *)createTextLayer:(UIView *)view text:(NSString *)text font:(UIFont *)font color:(UIColor *)color;
+ (UIColor *)colorAtIndex:(int)index;

@end
