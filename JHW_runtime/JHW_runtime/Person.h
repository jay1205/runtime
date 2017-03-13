//
//  Person.h
//  JHW_runtime
//
//  Created by JHW on 17/3/9.
//  Copyright © 2017年 JHW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *age;


- (void)haveChilds:(float)value;
- (void)haveRich:(float)value;

@end
