//
//  Msg_Forward_Class.m
//  KCObjcBuild
//
//  Created by 谭诚 on 2021/2/23.
//

#import "Msg_Forward_Class.h"

@implementation Msg_Forward_Class

//+ (BOOL)resolveClassMethod:(SEL)sel
//{
//    NSLog(@"%s 他 %@ 来了",__FUNCTION__, NSStringFromSelector(sel));
////    if (sel == @selector(testClassClassMethod)) {
////        IMP sayHIMP = class_getMethodImplementation(objc_getMetaClass("TestClass"), @selector(sayHappay));
////        Method sayHMethod = class_getClassMethod(objc_getMetaClass("TestClass"), @selector(sayHappay));
////        const char *sayHType = method_getTypeEncoding(sayHMethod);
////        return class_addMethod(objc_getMetaClass("TestClass"), sel, sayHIMP, sayHType);
////    }
//    return [super resolveClassMethod:sel];
//}
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    NSLog(@"%s 他 %@ 来了",__FUNCTION__, NSStringFromSelector(sel));
//    return [super resolveInstanceMethod:sel];
//}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return [super forwardingTargetForSelector:aSelector];
}

- (void)abc
{
    Msg_Forward_Class *objc = [[Msg_Forward_Class alloc] init];
    NSLog(@"---------------");
    [objc classInstanceMethod];
}

@end
