//
//  main.m
//  objc-debug
//
//  Created by Cooci on 2019/10/9.
//

#import <Foundation/Foundation.h>
#import "TestClass.h"
#import <objc/runtime.h>

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
        Class pClass = object_getClass(object);
        
        [object testClassInstanceMethod];
        [object testClassInstanceMethod_1];
        [object testClassInstanceMethod_2];
        [object testClassInstanceMethod_3];
        
        struct custom_objc_class *custom_pClass = (__bridge struct custom_objc_class *)(pClass);
        
        
        
        for (mask_t i = 0; i < custom_pClass->cache._mask; i++) {
            struct custom_bucket_t bucket = custom_pClass->cache._buckets[i];
            NSLog(@"%s ---- %lu",bucket._sel,bucket._imp);
        }
        
        NSLog(@"结束打印：%@ - %p",object,pClass);
    }
    return 0;
}


