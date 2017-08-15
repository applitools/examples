//
//  MatchLevel.h
//  ApplitoolsEyes
//
//  Created by Anton Chuev on 11/9/16.
//  Copyright © 2016 Applitools. All rights reserved.
//

#ifndef MatchLevel_h
#define MatchLevel_h

/*
 The extent in which two images match (or are expected to match).
 */
typedef NS_ENUM(NSInteger, MatchLevel) {
    MatchLevelNone = 1, // Images do not necessarily match.
    MatchLevelLayout, // Images have the same layout.
    MatchLevelContent, // Images have the same outline.
    MatchLevelStrict, // Images are nearly identical.
    MatchLevelExact // Images are identical.
};

#endif /* MatchLevel_h */
