//
//  ViewController.m
//  JHW_runtime
//
//  Created by JHW on 17/3/9.
//  Copyright © 2017年 JHW. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController (){

    NSString *_name;
    NSString *_age;
}
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    __weak typeof(self)weakSelf = self;
//    __strong typeof(weakSelf)self = weakSelf;
    [[_btn1 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        NSLog(@"当前类名：%@",[RuntimeKit fetchClassName:[Person class]]) ;
    }];
    [[_btn2 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
      
        NSLog(@"当前类的变量：%@",[RuntimeKit fetchIvarList:[Person class]]);
    }];
    [[_btn3 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
      
        NSLog(@"当前类的属性:%@",[RuntimeKit fetchPropertyList:[Person class]]);
    }];
    [[_btn4 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        NSLog(@"当前类的所有方法:%@",[RuntimeKit fetchMethodList:[Person class]]);
    }];
    Person *preple = [Person new];
    [[_btn5 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [preple performSelector:@selector(haveHowOld) withObject:@"28"];
    }];
    
    [RuntimeKit methodSwap:[Person class] firstMethod:@selector(haveChilds:) secondMethod:@selector(haveRich:)];
    [[_btn6 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//        [preple haveRich:100];
        [preple haveChilds:10];
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
