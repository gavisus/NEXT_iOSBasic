//
//  SolitaireDeck.m
//  W5_Solitaire
//
//  Created by 김성희 on 2015. 4. 1..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import "SolitaireDeck.h"

@implementation SolitaireDeck

+ (void)convertNum:(int)num toString:(NSMutableString *)value {
    if (num < 13)
        [value setString:@"s"]; // spades
    else if (num < 26)
        [value setString:@"h"]; // hearts
    else if (num < 39)
        [value setString:@"d"]; // diamonds
    else
        [value setString:@"c"]; // clubs
    
    int remainder = num % 13;
    
    switch (remainder) {
        case 0: [value appendString:@"A"];
            break;
        case 10: [value appendString:@"J"];
            break;
        case 11: [value appendString:@"Q"];
            break;
        case 12: [value appendString:@"K"];
            break;
        default: [value appendFormat:@"%d", remainder + 1];
            break;
    }
}

- (id)init {
    [super init];

    _deck = [[NSMutableArray alloc] init];
    _stacks = [[NSMutableArray alloc] init];
    
    NSMutableString *value;
    for (int i = 0; i < NUM_OF_CARDS; i++) {
        value = [[NSMutableString alloc] init];
        
        [[self class] convertNum:i toString:value];
        
        [_deck addObject:value];
    }
    
    return self;
}

- (void)shuffleCards {
    for (int i = 0; i < 52; i++) {
        int random = arc4random() % (52 - i);
        [_deck exchangeObjectAtIndex:i withObjectAtIndex:(i + random)];
    }

    NSMutableArray *stack;
    for (int i = 0; i < 7; i++) {
        stack = [[NSMutableArray alloc] init];
       
        for (int j = 0; j <= i; j++) {
            [stack addObject:[_deck objectAtIndex:0]];
            [_deck removeObjectAtIndex:0];
            
            if (j == i)
                [_stacks addObject:stack];
        }
    }
}

- (void)displayCards {
    NSLog(@"%@", _stacks);
    NSLog(@"%@", _deck);
}

- (oneway void)release {
    NSMutableString *value;
    
    for (int i = 0; i < _deck.count; i++) {
        value = [_deck objectAtIndex:0];

        [_deck removeObjectAtIndex:0];
        [value release];
    }
    [_deck release];
    
    for (int i = (int)_stacks.count; i > 0; i--) {
        NSMutableArray *stack = [_stacks objectAtIndex:0];
        
        for (int j = (int)stack.count; j > 0; j--) {
            value = [stack objectAtIndex:0];
            
            [stack removeObjectAtIndex:0];
            [value release];
        }
        
        [_stacks removeObjectAtIndex:0];
        [stack release];
    }
    [_stacks release];
}

@end
