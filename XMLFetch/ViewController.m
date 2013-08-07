//
//  ViewController.m
//  XMLFetch
//
//  Created by Harry Herrys Camigla on 8/6/13.
//  Copyright (c) 2013 Harry Herrys Camigla. All rights reserved.
//

#import "ViewController.h"
#import "XMLParser.h"
#import "MapAnnotation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Fetch XML";
    [self getInfo];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getInfo{
    
    if (!activityIndicator) {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [self.view addSubview:activityIndicator];
        activityIndicator.center = self.view.center;
    }else{
        activityIndicator.hidden = NO;
    }
    
    [activityIndicator startAnimating];
    
    self.view.userInteractionEnabled = NO;
    
    [[BusinessObject getInstance].url getUrContentFromUrl:kDropBoxUserUrl withCompletionBlock:^(NSDictionary *dict){
    
    
        if ([[dict objectForKey:kRequestStatus] isEqualToString:kRequestStatusOK]) {
            NSError *e = nil;
            
            NSData *responseData = [dict objectForKey:kRequestData];
            
            
            NSString *stringData = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            
            
            
            XMLParser *parser = [[BusinessObject getInstance] parseXMLUsingData:responseData];
            
            
            
            if ([parser parse]) {
                NSDictionary *dict = [[[parser getDictionay] objectForKey:@"JSONData"] objectForKey:@"business"];
                NSLog(@"%@", [dict description]);
                
                NSString *category = [dict objectForKey:@"category"];
                NSString *rating = [dict objectForKey:@"rating"];
                NSString *businessName = [dict objectForKey:@"name"];
                NSString *phone = [dict objectForKey:@"phone"];
                
                NSDictionary *location = [dict objectForKey:@"location"];
                
                NSString *address = [NSString stringWithFormat:@"%@",[location objectForKey:@"address"]] ;

                NSString *cityStateZip = [NSString stringWithFormat:@"%@, %@, %@", [location objectForKey:@"city"], [location objectForKey:@"state"], [location objectForKey:@"zip"]] ;

                
                NSString *formattedHTMLString = [NSString stringWithFormat:[[BusinessObject getInstance] getHtmlString], businessName, address, cityStateZip, phone,category, rating];
                
                [web loadHTMLString:formattedHTMLString baseURL:nil];
                
                MapAnnotation *annotaion = [[MapAnnotation alloc] init];
                annotaion.nameInfo = businessName;
                
                annotaion.longitude = [location objectForKey:@"longitude"];
                annotaion.latitude = [location objectForKey:@"latitude"];
                annotaion.identifier = @"dropPin";
                [mapView addAnnotation:annotaion];
                
                MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([annotaion coordinate] ,250,250);
                [mapView setRegion:region animated:YES];

                
            }else{
                [[BusinessObject getInstance] displayAlertWithMessage:@"Failed to parse XML data"];
            }
            
            [parser release];
            

            
            [responseData release];
            
        }
        
        [dict release];

        self.view.userInteractionEnabled = YES;
        activityIndicator.hidden = YES;
    
    }];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapViw viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MapAnnotation *point = (MapAnnotation*)annotation;
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:point.identifier];
    
    if (!annotationView) {
        
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:point.identifier];
        
        annotationView.animatesDrop = YES;
        annotationView.canShowCallout = YES;
    }
    
    
    return annotationView;
}

@end
