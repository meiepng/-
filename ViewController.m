//
//  ViewController.m
//  精确定位
//
/*
   必须在info.plist中增加相应的键值
   NSLocationAlwaysUsageDescription       Boolean   YES
   NSLocationWhenInUseUsageDescription    Boolean   YES
 */
//  Created by mac on 16/5/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "MessageModel.h"

@interface ViewController ()<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *jingdu;
@property (weak, nonatomic) IBOutlet UILabel *weidu;
@property (weak, nonatomic) IBOutlet UILabel *dizhi;
@property (weak, nonatomic) IBOutlet UILabel *guojia;
@property (weak, nonatomic) IBOutlet UILabel *chengshi;
@property (weak, nonatomic) IBOutlet UILabel *qu;
@property (weak, nonatomic) IBOutlet UILabel *jiedao;
@property (weak, nonatomic) IBOutlet UILabel *lu;
@property (weak, nonatomic) IBOutlet UILabel *hao;

- (IBAction)refresh;
@property(nonatomic,strong)CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self startLocation];
}

-(void)startLocation
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]  >= 8.0) {
        //使用期间
        [self.locationManager requestWhenInUseAuthorization];
        //始终
        //or [self.locationManage requestAlwaysAuthorization]
    }
    //设置定位精度
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置距离筛选
    self.locationManager.distanceFilter = 10.0f;
    [self.locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        NSLog(@"无法获取位置信息");
    }
}

//定位代理经纬度回调
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [_locationManager stopUpdatingLocation];
    _jingdu.text=[NSString stringWithFormat:@"%3.5f",newLocation.coordinate.latitude];
    _weidu.text=[NSString stringWithFormat:@"%3.5f",newLocation.coordinate.longitude];
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *placemark in placemarks) {
            NSDictionary *test=[placemark addressDictionary];
            MessageModel *model=[[MessageModel alloc]init];
            [model setValuesForKeysWithDictionary:test];
//            _dizhi.text=[NSString stringWithFormat:@"%@",[test objectForKey:@"Name"]];
            _dizhi.text=model.Name;
            _guojia.text=model.Country;
            _chengshi.text=model.City;
            _qu.text=model.SubLocality;
            _jiedao.text=model.Street;
            _lu.text=model.Thoroughfare;
            _hao.text=model.SubThoroughfare;
        }
    }];
    
}

//在viewWillDisappear关闭定位
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_locationManager stopUpdatingLocation];
}

- (IBAction)refresh {
    [self startLocation];
}
@end
