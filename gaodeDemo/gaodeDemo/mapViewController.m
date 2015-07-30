//
//  mapViewController.m
//  gaodeDemo
//
//  Created by ozx on 15/7/29.
//  Copyright (c) 2015年 ozx. All rights reserved.
//

#import "mapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

#import "ReGeocodeAnnotation.h"
#import "MANaviAnnotationView.h"

@interface mapViewController ()<MAMapViewDelegate,AMapSearchDelegate,AMapSearchDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation mapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"location";
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithTitle:@"标注"
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                               action:@selector(hehe)],
                                                [[UIBarButtonItem alloc] initWithTitle:@"跟随"
                                                                                 style:UIBarButtonItemStyleDone
                                                                                target:self
                                                                                action:@selector(xixi)]];
    [self initMapView];
    [self initSearch];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.mapView.showsUserLocation = YES;//开启定位
    self.mapView.userTrackingMode = MAUserTrackingModeFollow; // 追踪用户位置.
   
}

/* 初始化search. */
- (void)initSearch
{
    self.search = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:self];
}

- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
//    {
//        self.locationManager = [[CLLocationManager alloc] init];
//        [self.locationManager requestAlwaysAuthorization];
//    }
//    self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
    self.mapView.frame = self.view.bounds;
    
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"%s",__func__);
}
-(void)xixi{
    self.mapView.userTrackingMode = MAUserTrackingModeFollow; // 追踪用户位置.
}

-(void) hehe {

//    CGFloat lat =  self.mapView.userLocation.coordinate.latitude;
//    NSLog(@"lat : %f",lat);
    
    //开始逆地理编码
//    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
//    regeoRequest.searchType = AMapSearchType_ReGeocode;
//    regeoRequest.location = [AMapGeoPoint locationWithLatitude:39.990459  longtitude:116.481476];
//    regeoRequest.radius = 10000;
//    regeoRequest.requireExtension = YES;
    
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
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
        //添加一根针
        ReGeocodeAnnotation *reGeocodeAnnotation = [[ReGeocodeAnnotation alloc] initWithCoordinate:coordinate
                                                                                         reGeocode:response.regeocode];
        
        [self.mapView addAnnotation:reGeocodeAnnotation];//要添加标注
        [self.mapView selectAnnotation:reGeocodeAnnotation animated:YES];//标注是否有动画效果
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[ReGeocodeAnnotation class]])
    {
        static NSString *invertGeoIdentifier = @"invertGeoIdentifier";
        
        MANaviAnnotationView *poiAnnotationView = (MANaviAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:invertGeoIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MANaviAnnotationView alloc] initWithAnnotation:annotation
                                                                 reuseIdentifier:invertGeoIdentifier];
        }
        
        poiAnnotationView.animatesDrop              = YES;
        poiAnnotationView.canShowCallout            = YES;
        
        //show detail by right callout accessory view.
        poiAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        poiAnnotationView.rightCalloutAccessoryView.tag = 1;
        
        //call online navi by left accessory.
        poiAnnotationView.leftCalloutAccessoryView.tag = 2;
        
        return poiAnnotationView;
    }
    
    return nil;
}

#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    NSLog(@"模式change");
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if (updatingLocation) {
        NSLog(@"latitude : %f , longitude : %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
    
}

@end
