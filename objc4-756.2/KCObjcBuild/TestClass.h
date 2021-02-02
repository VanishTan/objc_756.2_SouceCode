//
//  TestClass.h
//  objc-debug
//
//  Created by 谭诚 on 2019/12/22.
//

#import "TestSuperClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestClass : TestSuperClass {
    NSString *flyIvar;
}

@property (nonatomic, strong) NSString *flyProperty;

- (void)testClassInstanceMethod;
- (void)testClassInstanceMethod_1;
- (void)testClassInstanceMethod_2;
- (void)testClassInstanceMethod_3;

+ (void)testClassClassMethod;

@end

NS_ASSUME_NONNULL_END
