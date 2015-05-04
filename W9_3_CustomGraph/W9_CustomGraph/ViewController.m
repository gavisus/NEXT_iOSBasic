//
//  ViewController.m
//  W9_CustomGraph
//
//  Created by 김성희 on 2015. 5. 2..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width * 2, _scrollView.frame.size.height)];
    [_pageControl addTarget:self action:@selector(pageChangeValue:) forControlEvents:UIControlEventValueChanged];
        
    NSError *error;
    
    NSString *dataString = @"[{\"title\":\"April\", \"value\":5},"
                            "{\"title\":\"May\", \"value\":12},"
                            "{\"title\":\"June\", \"value\":18},"
                            "{\"title\":\"July\", \"value\":11},"
                            "{\"title\":\"August\", \"value\":15},"
                            "{\"title\":\"September\", \"value\":9},"
                            "{\"title\":\"October\", \"value\":17},"
                            "{\"title\":\"November\", \"value\":25},"
                            "{\"title\":\"December\", \"value\":31}]";
    
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:0
                                                                   error:&error];
    
    if (error != nil)
        return;
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in parsedObject) {
        [list addObject:dict];
    }
    
    _barGraphView = [[BarGraphView alloc] init];
    [_barGraphView setList:list];


    [_barGraphView setFrame:CGRectMake(_scrollView.frame.size.width * 0,
                                       0,
                                       _scrollView.frame.size.width,
                                       _scrollView.frame.size.height)];
    [_barGraphView setBackgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:_barGraphView];

    dataString = @"[{\"title\":\"April\", \"percentage\":18},"
                    "{\"title\":\"May\", \"percentage\":12},"
                    "{\"title\":\"June\", \"percentage\":18},"
                    "{\"title\":\"July\", \"percentage\":13},"
                    "{\"title\":\"August\", \"percentage\":18},"
                    "{\"title\":\"September\", \"percentage\":9},"
                    "{\"title\":\"October\", \"percentage\":18}]";
    
    data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    parsedObject = [NSJSONSerialization JSONObjectWithData:data
                                                   options:0
                                                     error:&error];
    
    list = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in parsedObject) {
        [list addObject:dict];
    }
    
    _pieGraphView = [[PieGraphView alloc] init];
    [_pieGraphView setList:list];
    [_pieGraphView setFrame:CGRectMake(_scrollView.frame.size.width,
                                       0,
                                       _scrollView.frame.size.width,
                                       _scrollView.frame.size.height)];
    [_pieGraphView setBackgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:_pieGraphView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
}
- (void)pageChangeValue:(id)sender {
    UIPageControl *pControl = (UIPageControl *) sender;
    
    [_scrollView setContentOffset:CGPointMake(pControl.currentPage * _scrollView.frame.size.width, 0) animated:YES];
}

@end
