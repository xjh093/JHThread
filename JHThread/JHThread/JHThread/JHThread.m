//
//  JHThread.m
//  JHThread
//
//  Created by HaoCold on 2021/5/6.
//

#import "JHThread.h"

#define kType 0

@interface JHThread()
@property (nonatomic,  strong) NSThread *thread;

#if kType
@property (nonatomic,  assign) BOOL  stopped;
#endif

@end

@implementation JHThread

#pragma mark - private

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
#if kType
    __weak typeof(self) wk = self;
    self.thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"=== begin ===");
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        
        while (wk && !wk.stopped) {
            NSLog(@"=== task begin ===");
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            NSLog(@"=== task end ===");
        }
        NSLog(@"=== end ===");
    }];
    
    [_thread start];
#else
    self.thread = [[NSThread alloc] initWithBlock:^{
        CFRunLoopSourceContext ctx = { 0 };
        CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &ctx);
        CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
        CFRelease(source);
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
    }];
    
    [_thread start];
#endif
}

- (void)dealloc
{
    [self stop];
    
    NSLog(@"%s", __func__);
}

- (void)executeTask:(dispatch_block_t)task
{
    task();
}

- (void)stopThread
{
#if kType
    _stopped = YES;
#endif
    
    CFRunLoopStop(CFRunLoopGetCurrent());
    _thread = nil;
    
    NSLog(@"%s", __func__);
}

#pragma mark - public

- (void)execute:(dispatch_block_t)task
{
    if (!_thread || !task) {
        return;
    }
    
    [self performSelector:@selector(executeTask:) onThread:_thread withObject:task waitUntilDone:NO];
}

- (void)stop
{
    if (!_thread) {
        return;
    }
    
    [self performSelector:@selector(stopThread) onThread:_thread withObject:nil waitUntilDone:YES];
}

@end
