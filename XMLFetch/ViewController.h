//
//  ViewController.h
//  XMLFetch
//
//  Created by Harry Herrys Camigla on 8/6/13.
//  Copyright (c) 2013 Harry Herrys Camigla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessObject.h"
#import "constants.h"
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController<MKMapViewDelegate>{
    IBOutlet MKMapView *mapView;
    IBOutlet UIWebView *web;
    UIActivityIndicatorView *activityIndicator;
}

-(void)getInfo;

@end
