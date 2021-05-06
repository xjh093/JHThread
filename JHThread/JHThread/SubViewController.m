//
//  SubViewController.m
//  JHThread
//
//  Created by HaoCold on 2021/5/6.
//

#import "SubViewController.h"
#import "JHThread.h"

@interface SubViewController ()
@property (nonatomic,  strong) JHThread *thread;
@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 62);
    button.backgroundColor = [UIColor lightGrayColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:@"停止" forState:0];
    [button setTitleColor:[UIColor blackColor] forState:0];
    [button addTarget:self action:@selector(stopThread) forControlEvents:1<<6];
    [self.view addSubview:button];
    button.center = self.view.center;
    
    self.thread = [[JHThread alloc] init];
}

- (void)stopThread
{
    [_thread stop];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.thread execute:^{
        NSLog(@"执行任务 - %@", [NSThread currentThread]);
    }];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
