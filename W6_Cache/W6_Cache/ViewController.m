//
//  ViewController.m
//  W6_Cache
//
//  Created by 김성희 on 2015. 4. 8..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import "ViewController.h"

static int NUM_OF_IMAGES = 22;

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    [_scrollView setDelegate:self];
     
    // load 1st image
    NSString *path = [[NSBundle mainBundle] pathForResource:@"01.jpg" ofType:nil];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
     
    // get image width, height and number of images in a screen
    float ratio = self.view.frame.size.width / imageView.frame.size.width;
    imageWidth = self.view.frame.size.width;
    imageHeight = imageView.frame.size.height * ratio;
    imagesInScreen = ceil(self.view.frame.size.height / imageHeight) + 1;
    scrollViewHeight = imageHeight * NUM_OF_IMAGES;
     
    [imageView setContentMode:UIViewContentModeScaleToFill];
    [imageView setFrame:CGRectMake(0, 0, imageWidth, imageHeight)];
    
    [_scrollView setContentSize:CGSizeMake(imageWidth, scrollViewHeight)];
    [_scrollView addSubview:imageView];
   
    // init _imageViews with 1st image and nil
    _imageViews = [[NSMutableArray alloc] init];
    [_imageViews insertObject:imageView atIndex:0];
    for (int i = 1; i < NUM_OF_IMAGES; i++) {
        [_imageViews insertObject:[NSNull null] atIndex:i];
    }

    // load first a few images
    [self loadShowImagesAtOffset:0.0];
}

- (void)loadShowImagesAtOffset:(float) offset {
    int start, end;
    
    // correct the scroll position
    if (offset < 0)
        offset = 0;
    if (offset > (scrollViewHeight - self.view.frame.size.height))
        offset = scrollViewHeight - self.view.frame.size.height;

    start = offset / imageHeight;
    end = start + imagesInScreen - 1;
    
    for (int i = 0; i < NUM_OF_IMAGES; i++) {
        id view = [_imageViews objectAtIndex:i];
        
        if (i < start || i > end) {
            if (view == [NSNull null])
                continue;

            // unload a hidden UIImageView
            [_imageViews replaceObjectAtIndex:i withObject:[NSNull null]];
            [view removeFromSuperview];

            NSLog(@"%dth UIImageView unloaded", i);
        }
        else {
            if (view != [NSNull null])
                continue;

            // load images
            NSString *file = [NSString stringWithFormat:@"%02d.jpg", i + 1];
            NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:nil];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
            
            [imageView setContentMode:UIViewContentModeScaleToFill];
            [imageView setFrame:CGRectMake(0, imageHeight * i, imageWidth, imageHeight)];

            [_scrollView addSubview:imageView];
            [_imageViews replaceObjectAtIndex:i withObject:imageView];
            
            NSLog(@"%dth UIImageView loaded", i);
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = [scrollView contentOffset];
    
    [self loadShowImagesAtOffset:offset.y];
}

/* TODO
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _scrollView;
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

@end
