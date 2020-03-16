//
//  NSObject+FixMethodCrash.m
//  objc-debug
//
//  Created by 谭诚 on 2020/3/16.
//

#import "NSObject+FixMethodCrash.h"

#import <objc/runtime.h>
#import <objc/message.h>



@implementation NSObject (FixMethodCrash)

+ (void)load {
    
#if DEBUG
#else
    Method old_forwardingTargetForSelector = class_getInstanceMethod([NSObject class], @selector(forwardingTargetForSelector:));
    Method my_forwardingTargetForSelector = class_getInstanceMethod([NSObject class], @selector(my_forwardingTargetForSelector:));
    
    method_exchangeImplementations(old_forwardingTargetForSelector, my_forwardingTargetForSelector);
#endif
    
}


- (id)my_forwardingTargetForSelector:(SEL)aSelector {
    
    BOOL transmit = NO;
    
    {
        // 获取NSObject的消息转发方法
        SEL forwardingTargetSel = @selector(forwardingTargetForSelector:);
        
        Method objectMethod = class_getInstanceMethod([NSObject class], forwardingTargetSel);
        Method selfMethod = class_getInstanceMethod([self class], forwardingTargetSel);
        
        // 类本身有没有实现消息转发流程
        transmit = method_getImplementation(selfMethod) == method_getImplementation(objectMethod);
    }
    
    //没有实现
    if (transmit) {
        //判断是否进行了下一步转发流程
        
        SEL methodSignatureForSelector = @selector(methodSignatureForSelector:);
        
        Method objectMethod = class_getInstanceMethod([NSObject class], methodSignatureForSelector);
        Method selfMethod = class_getInstanceMethod([self class], methodSignatureForSelector);
        
        transmit = method_getImplementation(selfMethod) == method_getImplementation(objectMethod);
        
        
        if (transmit) {
            NSString *errorClassName = NSStringFromClass([self class]);
            NSString *errorSel   = NSStringFromSelector(aSelector);
#warning ---- 上报服务器或者你自己的处理提示等等
            //上报服务器-等你自己的处理
            NSLog(@"出问题的类，出问题的方法 == %@ %@", errorClassName, errorSel);
            
            NSString *className = @"CrashClass";
            Class cls = NSClassFromString(className);
            
            //如果类不存在创建一个
            if (!cls) {
                //创建类
                Class superClass = [NSObject class];
                cls = objc_allocateClassPair(superClass, className.UTF8String, 0);
                
                //给类添加方法
                class_addMethod(cls, aSelector, (IMP)Crash, "v@:");
                
                //注册类
                objc_registerClassPair(cls);
            }
            
            if (!class_getInstanceMethod(cls, aSelector)) {
                class_addMethod(cls, aSelector, (IMP)Crash, "@@:@");
            }
            
            /// 把消息转发到当前动态生成类的实例上
            return [[cls alloc] init];
        }
    }
    
    return [self my_forwardingTargetForSelector:aSelector];
}


static int Crash(id self, SEL _cmd) {
    return 0;
}

@end
