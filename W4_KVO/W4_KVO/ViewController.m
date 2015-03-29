//
//  ViewController.m
//  W4_KVO
//
//  Created by 김성희 on 2015. 3. 26..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import "ViewController.h"
#import "CardDeck.h"

@implementation ViewController

- (IBAction)change:(id)sender {
    [_cardDeck randomize];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {

    if ([keyPath isEqualToString:@"card"]) {
        NSString *imageFile = [[NSString alloc] initWithFormat:@"%@.png", [change valueForKey:@"new"]];
        UIImage *image = [UIImage imageNamed:imageFile];

        [_imageView setImage:image];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _cardDeck = [[CardDeck alloc] init];
    
    [_cardDeck addObserver:self
                forKeyPath:@"card"
                   options:NSKeyValueObservingOptionNew
                   context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
