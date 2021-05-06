//
//  JHThread.h
//  JHThread
//
//  Created by HaoCold on 2021/5/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHThread : NSObject

- (void)execute:(dispatch_block_t)task;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
