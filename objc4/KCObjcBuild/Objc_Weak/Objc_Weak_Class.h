//
//  Objc_Weak_Class.h
//  KCObjcBuild
//
//  Created by 谭诚 on 2021/2/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Objc_Weak_Class : NSObject

@property (atomic, strong) id delegate;

- (void)weakMethod;

@end

NS_ASSUME_NONNULL_END
