//
//  ViewController.h
//  W9_CustomGraph
//
//  Created by 김성희 on 2015. 5. 2..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarGraphView.h"
#import "PieGraphView.h"

@interface ViewController : UIViewController <UIScrollViewDelegate> {
    BarGraphView *_barGraphView;
    PieGraphView *_pieGraphView;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

