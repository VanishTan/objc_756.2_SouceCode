//
//  Objc_Weak_Class.m
//  KCObjcBuild
//
//  Created by 谭诚 on 2021/2/23.
//

#import "Objc_Weak_Class.h"

@implementation Objc_Weak_Class

- (void)weakMethod
{
    
    Objc_Weak_Class *o = [[Objc_Weak_Class alloc] init];
    __weak Objc_Weak_Class *weakPtr = o;
    weakPtr.delegate = @"1";
    
    NSLog(@" %@",o);
}


@end
