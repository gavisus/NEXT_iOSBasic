//
//  ViewController.h
//  W5_Solitaire
//
//  Created by 김성희 on 2015. 4. 1..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SolitaireDeck.h"

@interface ViewController : UIViewController {
    SolitaireDeck *cardDeck;
    NSMutableDictionary *imageViews;
}

- (IBAction)refresh:(id)sender;

@end

