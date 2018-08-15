//
//  APIConstants.h
//  OWNOWApp
//
//  Created by EshaPancholi on 21/07/16.
//  Copyright © 2016 Esha. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_TIMEOUT 90.0

#define WS_STATUS       @"status"
#define WS_DATA         @"data"

#define WS_SUCCESS      @"Success"
#define WS_FAIL         @"Fail"
#define WS_MESSAGE      @"message"

#pragma mark - URL Base



///FOR UAT
#define Server_URL  "http://xxx.xx.xx:xx"


//FOR INTRANET
//#define Server_URL "http://xxx.xx.xx:xxxx"




#define URLBase     [NSString stringWithFormat:@"%s/HWTService.asmx/", Server_URL]

#pragma mark - User Services

//#define URLLogin     [NSString stringWithFormat:@"%@Login", URLBase]
//#define ParamLogin(phoneNum, password, deviceMake, deviceToken)  [NSString stringWithFormat:@"phone_no=%@&password=%@&device_make=%d&device_token=%@", phoneNum, password, deviceMake, deviceToken]

