//
//  Person.m
//  JHW_runtime
//
//  Created by JHW on 17/3/9.
//  Copyright © 2017年 JHW. All rights reserved.
//

#import "Person.h"

@interface Person (){

    NSInteger _childs;
}
@property (nonatomic, strong)NSString *rich;
@end

@implementation Person

- (void)haveChilds:(float)value{
    NSLog(@"person有%lf个孩子",value);
}
- (void)haveRich:(float)value{
    NSLog(@"person有%lf储蓄",value);
}
/**
 没有找到SEL的IML实现时会执行下方的方法
 
 @param sel 当前对象调用并且找不到IML的SEL
 @return 找到其他的执行方法，并返回yes
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    //    return NO;    //当返回NO时，会接着执行forwordingTargetForSelector:方法，
    [RuntimeKit addMethod:[self class] method:sel method:@selector(haveHowOld:)];
    return YES;
}
- (void)haveHowOld:(NSString *)value{
    NSLog(@"person的age=%@",value);
}

@end
