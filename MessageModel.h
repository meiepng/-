//
//  MessageModel.h
//  精确定位
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic,strong)NSString *City;
@property (nonatomic,strong)NSString *Country;
@property (nonatomic,strong)NSString *Name;
@property (nonatomic,strong)NSString *State;
@property (nonatomic,strong)NSString *Street;
@property (nonatomic,strong)NSString *SubLocality;
@property (nonatomic,strong)NSString *SubThoroughfare;
@property (nonatomic,strong)NSString *Thoroughfare;

@end
