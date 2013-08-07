//
//  BusinessObject.m
//  XMLFetch
//
//  Created by Harry Herrys Camigla on 8/6/13.
//  Copyright (c) 2013 Harry Herrys Camigla. All rights reserved.
//

#import "BusinessObject.h"

static BusinessObject *instance;

@implementation BusinessObject

@synthesize url;

-(id)init{
    self = [super init];
    if (self) {
        self.url = [[GetUrl alloc] init];
    }
    return self;
}

+(BusinessObject*) getInstance{
    if (!instance) {
        instance = [[BusinessObject alloc] init];
    }
    
    return instance;
}

-(void) displayAlertWithMessage:(NSString*)string{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:string delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
}

-(XMLParser*) parseXMLUsingData:(NSData *)data{
    XMLParser *parser = [[XMLParser alloc] initWithData:data];
    [parser setShouldResolveExternalEntities:YES];
    [parser setShouldProcessNamespaces:YES];
    [parser setShouldReportNamespacePrefixes:YES];
    
    return parser;
}

-(NSString*) getHtmlString{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"home.html" ofType:nil];
    
    NSString *htmlString =[[NSString alloc ] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    return htmlString;
}

@end
