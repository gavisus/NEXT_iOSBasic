//
//  PieGraphView.h
//  W9_CustomView
//
//  Created by 김성희 on 2015. 5. 1..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieGraphView : UIView {
    NSMutableArray *_pieLayers;
    NSMutableArray *_list;
    
    CGPoint _center;
    int _radius;
}

- (void)setList:(NSMutableArray *)list;

@end
