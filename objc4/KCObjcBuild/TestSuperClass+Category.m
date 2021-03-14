//
//  TestSuperClass+Category.m
//  KCObjcBuild
//
//  Created by 谭诚 on 2021/3/14.
//

#import "TestSuperClass+Category.h"

@implementation TestSuperClass (Category)

+ (void)load
{
    NSLog(@"11");
}

- (void)category_TestSuperClass
{
    NSLog(@"%s",__func__);
}


@end
