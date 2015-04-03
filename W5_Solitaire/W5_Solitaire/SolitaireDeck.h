//
//  SolitaireDeck.h
//  W5_Solitaire
//
//  Created by 김성희 on 2015. 4. 1..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NUM_OF_CARDS 52

@interface SolitaireDeck : NSObject

@property (nonatomic, retain) NSMutableArray *stacks;
@property (nonatomic, retain) NSMutableArray *deck;

+ (void)convertNum:(int)num toString:(NSMutableString *)string;
- (void)shuffleCards;
- (void)displayCards;

@end
