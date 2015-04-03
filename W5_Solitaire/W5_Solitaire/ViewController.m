//
//  ViewController.m
//  W5_Solitaire
//
//  Created by 김성희 on 2015. 4. 1..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)refresh:(id)sender {
    [self viewWillAppear:false];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    cardDeck = [SolitaireDeck alloc];
    imageViews = [[NSMutableDictionary alloc] init];
   
    NSMutableString *value;
    for (int i = 0; i < NUM_OF_CARDS; i++) {
        value = [[NSMutableString alloc] init];

        [SolitaireDeck convertNum:i toString:value];
        
        NSString *file = [[NSString alloc] initWithFormat:@"%@.png", value];
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:file]];
        [imageViews setObject:view forKey:value];
       
        [value release];
        [file release];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addSubUIImageViewName:(NSString *)name
                            x:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height {
    UIImageView *imageView = [imageViews valueForKey:name];
    [imageView setFrame:CGRectMake(x, y, width, height)];
    
    [self.view addSubview:imageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (cardDeck) {
        [cardDeck release];
    }
    
    [cardDeck init];
    [cardDeck shuffleCards];
   
    for (int i = 0; i < 7; i++) {
        for (int j = 0; j <= i; j++) {
            NSString *card = [[cardDeck.stacks objectAtIndex:i] objectAtIndex:j];
            [self addSubUIImageViewName:card x:(26 + 140*i) y:(100 + 40*j) width:130 height:150];
        }
    }
    
    for (int i = 0; i < [cardDeck.deck count]; i++) {
        NSString *card = [cardDeck.deck objectAtIndex:i];
        [self addSubUIImageViewName:card x:(26 + 24*i) y:500 width:130 height:150];
    }
}

@end
