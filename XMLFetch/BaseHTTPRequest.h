//
//  BaseHTTPRequest.h
//  XMLFetch
//
//  Created by Harry Herrys Camigla on 8/6/13.
//  Copyright (c) 2013 Harry Herrys Camigla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constants.h"

@interface BaseHTTPRequest : NSObject<NSURLConnectionDelegate>{
    NSMutableData *_nsData;
    NSMutableURLRequest *_request;
    CompletionBlock _blockEval;
}

@end
