//
//  PieGraphView.m
//  W9_CustomView
//
//  Created by 김성희 on 2015. 5. 1..
//  Copyright (c) 2015년 skim. All rights reserved.
//
#import <CoreText/CoreText.h>
#import "PieGraphView.h"
#import "CommonUtilView.h"

#define ARC4RANDOM_MAX 0x100000000

static inline float radians(double degrees) { return degrees * M_PI / 180; }

@implementation PieGraphView

- (void)drawRect:(CGRect)rect {
    _pieLayers = [[NSMutableArray alloc] init];
    
    _center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _radius = self.frame.size.width/2;

    int total = 0;
    for (NSDictionary *item in _list) {
        NSNumber *percent = [item objectForKey:@"percentage"];
        total += [percent intValue];
    }

    float start = radians(270);
    float end;
    
    for (int i = 0; i < _list.count; i++) {
        NSNumber *percent = [_list[i] objectForKey:@"percentage"];
        
        end = start + radians([percent floatValue] / total*360);
        
        [self drawPie:self startAngle:start endAngle:end color:[CommonUtilView colorAtIndex:i]];
        [self drawLabel:self label:[_list[i] objectForKey:@"title"] startAngle:start endAngle:end];
        
        start = end;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];

    NSLog(@"touch point = (%f, %f", point.x, point.y);
    
    int index = [self getCurrentSelectedOnTouch:point];
    NSLog(@"touch index = %d", index);
   
    [self touchesCancelled:touches withEvent:event];
}

- (void)drawPie:(UIView *)view startAngle:(float)startAngle endAngle:(float)endAngle color:(UIColor *)color {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    CGMutablePathRef path = CGPathCreateMutable();

    CGPathMoveToPoint(path, NULL, _center.x, _center.y);
    CGPathAddArc(path, NULL, _center.x, _center.y, _radius, startAngle, endAngle, 0);
    [shapeLayer setPath:path];
   
    CGPathRelease(path);
    
    [shapeLayer setMasksToBounds:NO];
    [shapeLayer setFillColor:[color CGColor]];
    
    [view.layer addSublayer:shapeLayer];
    
    [_pieLayers addObject:shapeLayer];
}

- (void)drawLabel:(UIView *)view label:(NSString *)label startAngle:(float)startAngle endAngle:(float)endAngle {
    UIFont *labelFont = [UIFont boldSystemFontOfSize:12];
    UIColor *labelColor = [UIColor blackColor];

    CATextLayer *textLayer = [CommonUtilView createTextLayer:view text:label font:labelFont color:labelColor];
   
    CGFloat midAngle = (startAngle + endAngle) / 2;
    [textLayer setPosition:CGPointMake(_center.x + (_radius * 0.7 * cos(midAngle)), _center.y + (_radius * 0.7 * sin(midAngle)))];
    [view.layer addSublayer:textLayer];
}

- (int)getCurrentSelectedOnTouch:(CGPoint)point {
    __block int selectedIndex = -1;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    [_pieLayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CAShapeLayer *pieLayer = (CAShapeLayer *)obj;
        CGPathRef path = [pieLayer path];
        
        if (CGPathContainsPoint(path, &transform, point, 0))
            selectedIndex = (int)idx;
    }];
    return selectedIndex;
}

#pragma mark - set local variables

- (void)setList:(NSMutableArray *)list {
    _list = list;
}

@end
