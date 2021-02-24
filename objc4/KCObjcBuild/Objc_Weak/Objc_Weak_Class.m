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
    __weak id weakPtr;
    
    Objc_Weak_Class *o = [[Objc_Weak_Class alloc] init];
    weakPtr = o;
    
    NSLog(@"%d",o);
}


@end
