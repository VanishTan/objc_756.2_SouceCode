//
//  Msg_Forward_Class.h
//  KCObjcBuild
//
//  Created by 谭诚 on 2021/2/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Msg_Forward_Class : NSObject

- (void)classInstanceMethod;
+ (void)classClassMethod;

- (void)abc;

@end

NS_ASSUME_NONNULL_END
