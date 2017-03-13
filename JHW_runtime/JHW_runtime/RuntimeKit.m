//
//  RuntimeKit.m
//  JHW_runtime
//
//  Created by JHW on 17/3/9.
//  Copyright © 2017年 JHW. All rights reserved.
//

#import "RuntimeKit.h"

@implementation RuntimeKit
/**
 *  获取类名
 *
 *  @param class 相应类
 *
 *  @return 类名
 */
+ (NSString *)fetchClassName:(Class)class{
    //class_getName()函数返回的是一个char类型的指针，也就是C语言的字符串类型，所以我们要将其转换成NSString类型
    const char *classname = class_getName(class);
    return [NSString stringWithUTF8String:classname];
}
/**
 *  获取成员变量
 *
 *  @param class 成员变量所在类
 *
 *  @return 返回成员变量字符串数组
 */
+ (NSArray *)fetchIvarList:(Class)class{

    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(class, &count);
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        //使用ivar_getName()来获取相应成员变量的名称
        const char *ivarName = ivar_getName(ivarList[i]);
        //ivar_getTypeEncoding()来获取相应成员变量的类型
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        dic[@"type"] = [NSString stringWithUTF8String:ivarType];
        dic[@"ivarName"] = [NSString stringWithUTF8String:ivarName];
        [mutableList addObject:dic];
    }
    free(ivarList);
    return [NSArray arrayWithArray:mutableList];
}
/**
 *  获取类的属性列表。包括私有、公有属性，即定义在延展中的属性
 *
 *  @param class 属性所在类
 *
 *  @return 属性列表数组
 */
+ (NSArray *)fetchPropertyList:(Class)class{

    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(class, &count);
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        [mutableList addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:mutableList];
}
/**
 *  获取对象方法列表：getter，setter，对象方法等。但不能获取类方法
 *
 *  @param class 方法所在类
 *
 *  @return 该类的方法列表
 */
+ (NSArray *)fetchMethodList:(Class)class{

    unsigned int count = 0;
    Method *methodList = class_copyMethodList(class, &count);
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count ;i++){
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableList];
}
/**
 *  获取协议列表
 *
 *  @param class 协议所在类
 *
 *  @return 该类的协议列表
 */
+ (NSArray *)fetchProtocolList:(Class)class{

    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(class, &count);
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        [mutableList addObject:[NSString stringWithUTF8String:protocolName]];
    }
    free(protocolList);
    return [NSArray arrayWithArray:mutableList];
}
/**
 *  添加新的方法
 *
 *  @param class         被添加方法的类
 *  @param methodSel     SEL
 *  @param methodSelImpl 提供IMP的SEL
 */
+ (void)addMethod:(Class)class method:(SEL)methodSel method:(SEL)methodSelImpl{

    Method method = class_getInstanceMethod(class, methodSelImpl);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(class, methodSel, methodIMP, types);
}
/**
 *  方法交换
 *
 *  @param class    交换方法所在的类
 *  @param metchod1 方法1
 *  @param method2  方法2
 */
+ (void)methodSwap:(Class)class firstMethod:(SEL)method1 secondMethod:(SEL)method2{

    Method firstMethod = class_getInstanceMethod(class, method1);
    Method secondMethod = class_getInstanceMethod(class, method2);
    method_exchangeImplementations(firstMethod, secondMethod);
}
@end


































