//
//  BarGraphView.h
//  W9_CustomView
//
//  Created by 김성희 on 2015. 4. 29..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarGraphView : UIView {
    NSMutableArray *_list;
}

- (void)setList:(NSMutableArray *)list;

@end
