//
//  main.m
//  objc-debug
//
//  Created by Cooci on 2019/10/9.
//
#import <Foundation/Foundation.h>
#import "TestClass.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "TestSuperClass.h"
typedef unsigned long           uintptr_t;
typedef uint32_t mask_t;
struct custom_bucket_t {
#if __arm64__
    uintptr_t _imp;
    SEL _sel;
#else
    SEL _sel;
    uintptr_t _imp;
#endif
};
struct cache_t {
    struct custom_bucket_t *_buckets;
    mask_t _mask;
    mask_t _occupied;
};
struct custom_class_data_bits_t {
    
    // Values are the FAST_ flags above.
    uintptr_t bits;
};
struct custom_objc_class  {
    Class ISA;
    Class superclass;
    struct cache_t cache;             // formerly cache pointer and vtable
    struct custom_class_data_bits_t bits;    // class_rw_t * plus custom rr/alloc flags
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        TestClass *object = [TestClass alloc];
        [object weakMethod];
        
        
        
        
        
//        [TestClass testClassClassMethod];
//        NSLog(@"%@",object);
        
        
    }
    return 0;
}
void custom_Cache_t() {
    
    TestClass *object = [TestClass alloc];
    Class pClass = object_getClass(object);
    
    
    NSLog(@"结束打印：%@ - %p",object,pClass);
    
    [object testClassInstanceMethod];
    [object testClassInstanceMethod_1];
    [object testClassInstanceMethod_2];
    [object testClassInstanceMethod_3];
    
    [object isKindOfClass:[NSObject class]];
    
    struct custom_objc_class *custom_pClass = (__bridge struct custom_objc_class *)(pClass);
    
    
    
    for (mask_t i = 0; i < custom_pClass->cache._mask; i++) {
        struct custom_bucket_t bucket = custom_pClass->cache._buckets[i];
        NSLog(@"%s ---- %lu",bucket._sel,bucket._imp);
    }
}

void testSendMessage () {
    
    TestClass *object = [TestClass alloc];
    
    //给对象发消息
    ((void(*)(id,SEL))objc_msgSend)(object,sel_registerName("testClassInstanceMethod"));
    
    //给类发消息
    ((void(*)(id,SEL))objc_msgSend)(object_getClass(object),sel_registerName("testClassClassMethod"));
    
    
    //给父类发消息（对象方法）1
    struct objc_super testSuper;
    testSuper.receiver = object;
    testSuper.super_class = object.superclass;
    ((void(*)(struct objc_super *,SEL))objc_msgSendSuper)(&testSuper,@selector(superClassInstanceMethod));
    
    
    //给父类发消息（对象方法）2
    struct objc_super testSuper_2;
    testSuper_2.receiver = object;
    testSuper_2.super_class = object.class;
    ((void(*)(struct objc_super *,SEL))objc_msgSendSuper)(&testSuper_2,@selector(superClassInstanceMethod));
    
    
    //给父类发消息（类方法）1
    struct objc_super testClassSuper_1;
    testClassSuper_1.receiver = [object class];
    testClassSuper_1.super_class = class_getSuperclass(object_getClass([object class]));
    ((void(*)(struct objc_super *,SEL))objc_msgSendSuper)(&testClassSuper_1,@selector(superClassClassMethod));
    
    
    //给父类发消息（类方法）2
    struct objc_super testClassSuper_2;
    testClassSuper_2.receiver = object;
    testClassSuper_2.super_class = objc_getMetaClass("TestClass");
    // object_getClass([object class]);
    ((void(*)(struct objc_super *,SEL))objc_msgSendSuper)(&testClassSuper_2,@selector(superClassClassMethod));
}
