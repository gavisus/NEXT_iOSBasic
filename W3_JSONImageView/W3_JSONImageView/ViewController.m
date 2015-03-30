//
//  ViewController.m
//  W3_JSONImageView
//
//  Created by 김성희 on 2015. 3. 19..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)show:(id)sender {
    int id = arc4random() % [_students count];
    
    NSString *imageFile = [[NSString alloc] initWithFormat:@"%02d.jpg", id + 1];
    UIImage *image = [UIImage imageNamed:imageFile];

    NSLog(@"[%d] (%f, %f)", id, image.size.width, image.size.height);
    
    [_titleMsg setText:[[_students objectAtIndex:id] valueForKey:@"title"]];
    [_imageView setImage:image];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *jsonString = @"[{\"title\":\"\uc0c8\uae001\","
    "  \"image\":\"01.jpg\","
    "  \"content\":\"\uc601\ud654\ubcf4\ub7ec\uac00\uc790\","
    "  \"comments\":[{\"id\":1,\"user\":\"jobs\",\"comment\":\"apple\"},"
    "          {\"id\":4,\"user\":\"cook\",\"comment\":\"apple\"}]},"
    " {\"title\":\"\ud1a0\uc774\uc2a4\ud1a0\ub9ac?\","
    "  \"image\":\"02.jpg\","
    "  \"content\":\"Pixar\","
    "  \"comments\":[]},"
    " {\"title\":\"ToyStory\","
    "  \"image\":\"03.jpg\","
    "  \"content\":\"\uc6b0\ub514\uac00\ucd5c\uace0\","
    "  \"comments\":[{\"id\":2,\"user\":\"bill\",\"comment\":\"Microsoft\"}]},"
    " {\"title\":\"\uadf9\uc7a5\uc740\","
    "  \"image\":\"04.jpg\","
    "  \"content\":\"\uc5b4\ub514\ub85c\","
    "  \"comments\":[{\"id\":4,\"user\":\"cook\",\"comment\":\"apple\"}]}]";
    
    _students = [[StudentModel alloc] initFromJson:jsonString];
    
    [_titleMsg setText:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end