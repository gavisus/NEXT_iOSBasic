//
//  CardDeck.h
//  W4_Notification
//
//  Created by 김성희 on 2015. 3. 25..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardDeck : NSObject

@property NSString *card;

- (void)randomize;
//- (NSString *)getStringWithShape:(int)shape number:(int)number;
    
@end
