//
//  XMLParser.m
//  XMLFetch
//
//  Created by Harry Herrys Camigla on 8/6/13.
//  Copyright (c) 2013 Harry Herrys Camigla. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser

-(id)init{
    self= [super init];
    if (self) {
        currentNode = [[CustomMutableDictionary alloc] init];
        currentNode.nodeName = @"JSONData";
        currentNode.nodeValue = @"";
        self.delegate = self;
    }
    return self;
}

-(id)initWithData:(NSData *)data{
    self= [super initWithData:data];
    if (self) {
        currentNode = [[CustomMutableDictionary alloc] init];
        currentNode.nodeName = @"JSONData";
        currentNode.nodeValue = @"";
        self.delegate = self;
    }
    return self;
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{

    currentNode = [currentNode getParentId];

    if ([currentNode getParentId]) {
        
        if ([currentNode.nodeName isEqualToString:@"business"]) {
            NSLog(@"");
        }
        
    }
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{

    
    CustomMutableDictionary *newNode = [[CustomMutableDictionary alloc] init];
    newNode.nodeName = elementName;
    [currentNode addObject:newNode];
    [newNode setParentId:currentNode];
    currentNode = newNode;
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{

    currentNode.nodeValue = string;

}



-(NSDictionary*) getDictionay{
    [currentNode processDictionary];
    return currentNode.dictionary;
}

-(void)dealloc{
    self.delegate = nil;
    [currentNode release];
    NSLog(@"Deallocate %@", [[self class] description]);
    [super dealloc];
}
@end
