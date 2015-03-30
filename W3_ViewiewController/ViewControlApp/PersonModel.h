//
//  PersonModel.h
//  ViewControlApp
//
//  Created by 김성희 on 2015. 3. 18..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject {

}

- (id)initWithFilePath:(NSString *)filePath;
- (NSString *)personNameAtIndex:(int)index;
- (NSNumber *)personNumberAtIndex:(int)index;
- (NSNumber *)personTeamAtIndex:(int)index;
- (NSDictionary *)getPersonObjectAtIndex:(int)index;

- (NSString *)findPersonNameByNumber:(NSNumber *)number;
- (NSNumber *)findPersonNumberByName:(NSString *)name;

@end
