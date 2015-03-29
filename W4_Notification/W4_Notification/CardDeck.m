//
//  CardDeck.m
//  W4_Notification
//
//  Created by 김성희 on 2015. 3. 25..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import "CardDeck.h"

@implementation CardDeck

- (void)randomize {
    int shape, number;
    NSString *value;
    NSDictionary *noti;
    
    shape = arc4random() % 4;
    number = arc4random() % 13;
    
    value = [self getStringWithShape:shape number:number];
    
    NSLog(@"shape = %d number = %d value = %@", shape, number, value);
    
    noti = [[NSDictionary alloc] initWithObjectsAndKeys:value, @"card", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setCard" object:nil userInfo:noti];
}

- (NSString *)getStringWithShape:(int)shape number:(int)number {
    NSMutableString *value = [[NSMutableString alloc] init];
    
    switch (shape) {
        case 0: [value setString:@"s"]; // spades
            break;
        case 1: [value setString:@"h"]; // hearts
            break;
        case 2: [value setString:@"d"]; // diamonds
            break;
        default: [value setString:@"c"]; // clubs
            break;
    }

    switch (number) {
        case 0: [value appendString:@"A"];
            break;
        case 10: [value appendString:@"J"];
            break;
        case 11: [value appendString:@"Q"];
            break;
        case 12: [value appendString:@"K"];
            break;
        default: [value appendFormat:@"%d", number + 1];
            break;
    }
    
    return value;
}

@end
