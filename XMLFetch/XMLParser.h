//
//  XMLParser.h
//  XMLFetch
//
//  Created by Harry Herrys Camigla on 8/6/13.
//  Copyright (c) 2013 Harry Herrys Camigla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomMutableDictionary.h"


@interface XMLParser : NSXMLParser<NSXMLParserDelegate>{

    CustomMutableDictionary *currentNode;
}

-(NSDictionary*) getDictionay;

@end
