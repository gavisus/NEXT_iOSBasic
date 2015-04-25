//
//  ViewController.h
//  W6_Cache
//
//  Created by 김성희 on 2015. 4. 8..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate> {
    int imageWidth, imageHeight;
    int scrollViewHeight;
    int imagesInScreen;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *imageViews;

@end
