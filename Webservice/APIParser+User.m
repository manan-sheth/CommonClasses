//
//  APIParser+User.m
//  OWNOWApp
//
//  Created by esharsh on 21/07/16.
//  Copyright © 2016 Esha. All rights reserved.
//

#import "APIParser+User.h"

@implementation APIParser (User)

- (void)loginRequestForType:(UserAPIRequest)service
                 forAPIType:(APIType)Type
          withRequestHeader:(NSString *)header
                 withParams:(NSString *)params
           withCustomObject:(id)obj
          withResponseBlock:(responseBlock)resBlock
{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
       
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSLog(@"Start Date :: %@", [[NSDate date] description]);
            
            NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
            
            NSString *strURL = @"";
            
            switch (service)
            {
                case APILogin:
                {
                    
                }
                    break;
                    
                case APIBirthdayAnni:
                {
                    strURL = [NSString stringWithFormat:@"%@GetBirthdayAndAnniversary",URLBase];
                }
                    break;
                    
                case APIHolidayList:
                {
                    strURL = [NSString stringWithFormat:@"%@GetEmployeeHolidayList",URLBase];
                }
                    break;
                default:
                    break;
            }
            
            //strURL = @"http://122.184.137.39:81/HWTService.asmx/GetBirthdayAndAnniversary";
            
            NSURL *url = [NSURL URLWithString:strURL];
            
            NSDictionary *dictReq = [NSDictionary dictionaryWithObjectsAndKeys:obj, header, nil];
            
           
            
//            NSString *st = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            
            NSMutableURLRequest *urlRequest = [NSMutableURLRequest new];
            
            switch (Type)
            {
                case GET:
                {
                    url =  [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",strURL,params ]];
                   urlRequest =  [self urlRequestForGETURL:url];
                    
                }
                    break;
                    
                case POST:
                {
                     NSData *jsonData = obj ? [self dictionaryToJSONData:dictReq] : [params dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:true];
                   urlRequest =  [self urlRequestForPOSTURL:url withObjects:jsonData isObject:dictReq];
                }
                    break;
                    
                default:
                    break;
            }
            
        
            NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:urlRequest completionHandler:
                                                  ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                      
                                                      id resObjects = nil;
                                                      NSString *responseString;
                                                      bool respStatus = false;
                                                      
                                                      if (data.length > 0)
                                                      {
                                                          resObjects = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                          
                                                          if([[resObjects objectForKey:@"JsonString"] count] > 0)
                                                          {
                                                              //resObjects = [resObjects objectForKey:@"JsonString"];
                                                              responseString = @"Success";
                                                              respStatus = true;
                                                          }
                                                          else if ([[resObjects objectForKey:@"JsonString"] count]  == 0)
                                                          {
                                                              responseString = @"No Data Available";
                                                              respStatus = true;
                                                          }
                                                          
                                                      }
                                                      else
                                                          responseString = @"No Data Available";
                                                      
                                                      
                                                      //Get Back to Main Queue
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          
                                                          NSLog(@"End Date :: %@", [[NSDate date] description]);
                                                          
                                                          resBlock(respStatus, error, resObjects, responseString);
                                                      });
                                                  }];
            
            [postDataTask resume];
        });
    }];
    
    [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
    [self.wsOperationQueue addOperation:operation];
}

@end
