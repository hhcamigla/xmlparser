//
//  BusinessObject.h
//  XMLFetch
//
//  Created by Harry Herrys Camigla on 8/6/13.
//  Copyright (c) 2013 Harry Herrys Camigla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetUrl.h"
#import "constants.h"
#import "XMLParser.h"

@interface BusinessObject : NSObject

@property (nonatomic, retain) GetUrl *url;


+(BusinessObject*) getInstance;
-(void) displayAlertWithMessage:(NSString*)string;
-(XMLParser*) parseXMLUsingData:(NSData*)data;
-(NSString*) getHtmlString;

@end
