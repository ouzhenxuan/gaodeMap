//
//  mapViewController.h
//  gaodeDemo
//
//  Created by ozx on 15/7/29.
//  Copyright (c) 2015年 ozx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface mapViewController : UIViewController
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@end
