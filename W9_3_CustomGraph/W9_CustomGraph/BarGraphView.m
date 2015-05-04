//
//  BarGraphView.m
//  W9_CustomView
//
//  Created by 김성희 on 2015. 4. 29..
//  Copyright (c) 2015년 skim. All rights reserved.
//
#import <CoreText/CTLine.h>
#import "BarGraphView.h"
#import "CommonUtilView.h"

@implementation BarGraphView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // get max grid
    int maxGrid = [self getMaxValueWithList:_list] / 10 + 1;
   
    [self draw:context grid:maxGrid interval:10];
}

- (void)draw:(CGContextRef)context grid:(int)grid interval:(int)interval {
    int titleHeight = 70;
    int itemTotalHeight = 40;
    int itemHeight = 30;
    int itemPadding = 5;
    int yLabelWidth = 100;
    int shadowSize = 2;
    int gridSpace;
   
    gridSpace = (self.frame.size.width - yLabelWidth - itemPadding*2) / 4;

    UIFont *labelFont = [UIFont boldSystemFontOfSize:15];
    UIColor *labelColor = [UIColor blackColor];
    
    for (int i = 0; i < grid + 1; i++) {
        // guide line
        [[UIColor grayColor] set];
        CGContextSetLineWidth(context, 2.0);
       
        CGContextMoveToPoint(context, yLabelWidth + i * gridSpace, titleHeight);
        CGContextAddLineToPoint(context, yLabelWidth + i * gridSpace, titleHeight + itemTotalHeight * _list.count);
        CGContextStrokePath(context);

        // axis label
        NSString *label = [[NSString alloc] initWithFormat:@"%d", i * 10];
        CATextLayer *labelLayer = [CommonUtilView createTextLayer:self text:label font:labelFont color:labelColor];
        
        // position top center point
        [labelLayer setPosition:CGPointMake(yLabelWidth + i*gridSpace,
                                            titleHeight + itemTotalHeight*_list.count + itemHeight/2)];
        [self.layer addSublayer:labelLayer];
    }

    for (int i = 0; i < _list.count; i++) {
        NSDictionary *dic = [_list objectAtIndex:i];
        int value = [[dic objectForKey:@"value"] intValue];

        // shadow
        [[UIColor grayColor] setFill];
        UIRectFill(CGRectMake(yLabelWidth + shadowSize,
                              titleHeight + itemPadding + itemTotalHeight * i + shadowSize,
                              gridSpace / 10.0 * value,
                              itemHeight));

        // bar graph
        [[CommonUtilView colorAtIndex:i] setFill];
        UIRectFill(CGRectMake(yLabelWidth,
                              titleHeight + itemPadding + itemTotalHeight * i,
                              gridSpace / 10.0 * value,
                              itemHeight));

        // label
        NSString *label = [[_list objectAtIndex:i] objectForKey:@"title"];
        CATextLayer *labelLayer = [CommonUtilView createTextLayer:self text:label font:labelFont color:labelColor];
        
        // position top center point
        [labelLayer setPosition:CGPointMake(yLabelWidth / 2, titleHeight + itemTotalHeight * i + itemHeight / 2)];
        [self.layer addSublayer:labelLayer];
    }
}

#pragma mark - set local variables

- (void)setList:(NSMutableArray *)list {
    _list = list;
}

- (int)getMaxValueWithList:(NSMutableArray *)list {
    int maxValue = 0;
   
    for (NSDictionary *dic in list) {
        int value = [[dic objectForKey:@"value"] intValue];
        if (maxValue < value)
            maxValue = value;
    }
    
    return maxValue;
}

@end
