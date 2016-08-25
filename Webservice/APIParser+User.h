//
//  APIParser+User.h
//  OWNOWApp
//
//  Created by esharsh on 21/07/16.
//  Copyright © 2016 Esha. All rights reserved.
//

#import "APIParser.h"

typedef enum {
    
    APILogin,
    APIBirthdayAnni,
    APIEmpDetailbyID,
    APIHolidayList,
    APILeaveRequest,
    APIAddAttendence
    
} UserAPIRequest;

@interface APIParser (User) <NSURLSessionDelegate>

- (void)loginRequestForType:(UserAPIRequest)service forAPIType:(APIType)Type withRequestHeader:(NSString *)header withParams:(NSString *)params withCustomObject:(id)obj withResponseBlock:(responseBlock)resBlock;

@end
