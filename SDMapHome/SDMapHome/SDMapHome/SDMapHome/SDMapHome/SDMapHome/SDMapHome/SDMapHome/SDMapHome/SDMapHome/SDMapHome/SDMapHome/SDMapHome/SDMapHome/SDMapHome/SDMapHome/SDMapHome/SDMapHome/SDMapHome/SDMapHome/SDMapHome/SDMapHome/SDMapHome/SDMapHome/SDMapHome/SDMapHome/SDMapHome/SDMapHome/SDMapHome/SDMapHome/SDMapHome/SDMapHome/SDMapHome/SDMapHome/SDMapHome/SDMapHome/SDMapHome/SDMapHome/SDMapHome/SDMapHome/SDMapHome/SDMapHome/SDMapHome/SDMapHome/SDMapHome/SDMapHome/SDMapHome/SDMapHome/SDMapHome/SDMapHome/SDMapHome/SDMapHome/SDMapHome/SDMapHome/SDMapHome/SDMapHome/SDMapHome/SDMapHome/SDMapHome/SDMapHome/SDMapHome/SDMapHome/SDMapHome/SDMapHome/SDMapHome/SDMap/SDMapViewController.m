//
//  SDMapViewController.m
//  SDMapHome
//
//  Created by shendong on 16/4/5.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "SDMapViewController.h"
#import "SDMapChoiceView.h"
#import "SDMapSearchViewController.h"

static CGFloat const kMargin = 10;

#define KNumberOfChoice 3;

@interface SDMapViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MAMapView *mapView;

@property (nonatomic, strong) AMapLocationManager *locationManager; //定位

@property (nonatomic, strong) SDMapChoiceView *choiceView;

@property (nonatomic, strong) UIButton *searchButton; //搜索view

@end

@implementation SDMapViewController
#pragma mark - lazyloading
- (SDMapChoiceView *)choiceView{
    if(!_choiceView){
        _choiceView = [[SDMapChoiceView alloc] initWithFrame:CGRectMake(SCREENWIDTH - 60, 100, 50, 200)];
        _choiceView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _choiceView;
}
- (UIButton *)searchButton{
    if (!_searchButton) {
        _searchButton  = [[UIButton alloc] initWithFrame:CGRectMake(kMargin, 40, SCREENWIDTH - 2 * kMargin, 44)];
        _searchButton.backgroundColor = [UIColor greenColor];
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(searchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}
#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self startUpdateingLocaitonSingelTime];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self configureMapView];
    
    [self.view addSubview:self.searchButton];
    
    [self configureChoiceView];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
- (void)configureMapView{
    //1.map view
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    
    self.mapView.pausesLocationUpdatesAutomatically = NO;
//    self.mapView.allowsBackgroundLocationUpdates = YES;
    
    //2.location manager
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
//    [self.locationManager startUpdatingLocation];
}
- (void)configureChoiceView{
    [self.view addSubview:self.choiceView];
    WS(ws);
//    [self.choiceView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(ws.view.mas_right).offset(-50);
//        make.top.equalTo(ws.view.mas_top).offset(100);
//        make.size.mas_equalTo(CGSizeMake(50, 200));
//    }];
    NSLog(@"frame = %@",NSStringFromCGRect(_choiceView.frame));
    [self.choiceView addSubViews:4 handleBlock:^(NSInteger tag) {
        NSLog(@"tag = %ld",tag);
        switch (tag) {
            case 0:
                //标准
                ws.mapView.mapType = MAMapTypeStandard;
                break;
            case 1:
                //卫星
                ws.mapView.mapType = MAMapTypeSatellite;
                break;
            case 2:
                //夜间
                ws.mapView.mapType = MAMapTypeStandardNight;
                break;
            case 3:
                //交通
                ws.mapView.showTraffic = !ws.mapView.isShowTraffic;
                break;
            default:
                break;
        }
    }];
}
/**
 *  关闭或开启持续定位
 *
 *  @param stop <#stop description#>
 */
- (void)startUpdateingLocationAlways:(BOOL)start {
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    self.locationManager.locationTimeout  = 3;
    self.locationManager.reGeocodeTimeout = 3;
    if (start) {
        [self.locationManager startUpdatingLocation];
    }else{
        [self.locationManager stopUpdatingLocation];
    }
}
/**
 *  开启或关闭单次定位
 *
 *  @param start <#start description#>
 */
- (void)startUpdateingLocaitonSingelTime{
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    self.locationManager.locationTimeout = 3;
    self.locationManager.reGeocodeTimeout = 3;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        NSLog(@"location = %@,code = %@",location,regeocode);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Private
- (void)searchButtonClicked:(UIButton *)sender {
    SDMapSearchViewController *search = [[SDMapSearchViewController alloc] initWithNibName:@"SDMapSearchViewController" bundle:nil];
    search.userLocation = self.mapView.userLocation;
    [self presentViewController:search animated:YES completion:NULL];
}
#pragma mark - MAMapViewDelegae
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    if (updatingLocation) {
//        NSLog(@"latitude:%lf, longitude:%lf",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}
#pragma mark - AMapLocationDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    NSLog(@"location:{lat:%lf,long:%lf,acc:%lf}",location.coordinate.latitude,location.coordinate.longitude,location.horizontalAccuracy);
}

@end
