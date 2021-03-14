//
//  TestSuperClass.m
//  objc-debug
//
//  Created by 谭诚 on 2020/1/5.
//

#import "TestSuperClass.h"

@implementation TestSuperClass

+ (void)load
{

}

- (void)superClassInstanceMethod {
//    NSLog(@"%s",__func__);
}
+ (void)superClassClassMethod {
    NSLog(@"%s",__func__);
}

@end
