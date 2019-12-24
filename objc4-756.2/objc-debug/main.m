//
//  main.m
//  objc-debug
//
//  Created by Cooci on 2019/10/9.
//

#import <Foundation/Foundation.h>
#import "TestClass.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        TestClass *object = [TestClass alloc];

        Class pClass = object_getClass(object);
        
        NSLog(@"%p - %p",object,pClass);
    }
    return 0;
}
