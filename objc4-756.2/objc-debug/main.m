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
        TestClass *object = [[TestClass alloc] init];
        NSLog(@"Hello, World! %@",object);
        
        
        Class class1 = [TestClass class];
        Class class2 = [TestClass alloc].class;
        Class class3 = object_getClass([TestClass alloc]);
        Class class4 = [TestClass alloc].class;
        
        NSLog(@"\n%p \n%p \n%p \n%p \n",class1,class2,class3,class4);
        
        
    }
    return 0;
}
