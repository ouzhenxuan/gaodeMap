//
//  mapViewController.m
//  gaodeDemo
//
//  Created by ozx on 15/7/29.
//  Copyright (c) 2015年 ozx. All rights reserved.
//

#import "testViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

#import "ReGeocodeAnnotation.h"
#import "MANaviAnnotationView.h"

@interface testViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation testViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.mapView removeFromSuperview];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"test";
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithTitle:@"标注"
                                                                                 style:UIBarButtonItemStyleDone
                                                                                target:self
                                                                               action:@selector(hehe)]];
    
}



-(void) hehe {
    MAUserLocation * userLocat = self.mapView.userLocation;
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location = [AMapGeoPoint locationWithLatitude:userLocat.coordinate.latitude longitude:userLocat.coordinate.longitude];
    regeo.requireExtension = YES;
    
    //发起逆地理编码
    [self.search AMapReGoecodeSearch:regeo];
}

#pragma mark - AMapSearchDelegate

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:response.regeocode.formattedAddress
                                                         message:[NSString stringWithFormat:@"lat:%f,lon:%f",request.location.latitude,request.location.longitude]
                                                        delegate:nil
                                               cancelButtonTitle:@"好"
                                               otherButtonTitles:nil, nil];
        [alert show];
    }
}


@end
