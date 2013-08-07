//
//  GetUrl.h
//  XMLFetch
//
//  Created by Harry Herrys Camigla on 8/6/13.
//  Copyright (c) 2013 Harry Herrys Camigla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHTTPRequest.h"

@interface GetUrl : BaseHTTPRequest

-(void) getUrContentFromUrl:(NSString*)url withCompletionBlock:(CompletionBlock) block;

@end
