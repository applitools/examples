//
//  ATBatchInfo.h
//  ApplitoolsEyes
//
//  Created by Anton Chuev on 9/1/16.
//  Copyright © 2016 Applitools. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BatchInfo : NSObject

@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) NSString *startedAtString;
@property (strong, nonatomic) NSString *batchId;

- (instancetype)initWithName:(NSString *)name;
- (instancetype)initWithName:(NSString *)name startedAt:(NSDate *)startedAt;
- (NSDictionary *)dictionary;

@end
