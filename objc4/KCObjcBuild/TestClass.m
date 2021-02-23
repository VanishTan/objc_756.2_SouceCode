//
//  TestClass.m
//  objc-debug
//
//  Created by 谭诚 on 2019/12/22.
//

#import "TestClass.h"
#import <objc/runtime.h>


@implementation TestClass

- (void)weakMethod
{
    __weak id weakPtr;
    
    TestClass *o = [[TestClass alloc] init];
    weakPtr = o;
    
    NSLog(@"%d",o);
}


- (void)testClassInstanceMethod {
    NSLog(@"TestClass - testClassInstanceMethod");
}

- (void)testClassInstanceMethod_1 {
//    NSLog(@"testClassInstanceMethod_1");
}
- (void)testClassInstanceMethod_2 {
//    NSLog(@"testClassInstanceMethod_2");
}
- (void)testClassInstanceMethod_3 {
    
}

- (void)sayHello {
    NSLog(@"%s",__func__);
}

+ (void)sayHappay {
    NSLog(@"%s",__func__);
}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    if (sel == @selector(testClassClassMethod)) {
        IMP sayHIMP = class_getMethodImplementation(objc_getMetaClass("TestClass"), @selector(sayHappay));
        Method sayHMethod = class_getClassMethod(objc_getMetaClass("TestClass"), @selector(sayHappay));
        const char *sayHType = method_getTypeEncoding(sayHMethod);
        return class_addMethod(objc_getMetaClass("TestClass"), sel, sayHIMP, sayHType);
    }
    return [super resolveClassMethod:sel];
}

//
//+ (void)testClassClassMethod {
//    NSLog(@"testClassClassMethod");
//}

@end
