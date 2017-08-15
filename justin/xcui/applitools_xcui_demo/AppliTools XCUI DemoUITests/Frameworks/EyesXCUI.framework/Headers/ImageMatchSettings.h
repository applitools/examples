//
//  ImageMatchSettings.h
//  ApplitoolsEyes
//
//  Created by Anton Chuev on 11/9/16.
//  Copyright © 2016 Applitools. All rights reserved.
//

#import "MatchLevel.h"

/*
 Encapsulates match settings for a session.
 */
@interface ImageMatchSettings : NSObject

@property (assign, nonatomic) MatchLevel matchLevel;

+ (instancetype)defaultImageMatchSettings;
- (instancetype)initWithMatchLevel:(MatchLevel)matchLevel;
- (NSDictionary *)dictionary;

@end
