//
//  ViewController.m
//  JHThread
//
//  Created by HaoCold on 2021/5/6.
//

#import "ViewController.h"
#import "SubViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"持久线程";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 62);
    button.backgroundColor = [UIColor lightGrayColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:@"下一个" forState:0];
    [button setTitleColor:[UIColor blackColor] forState:0];
    [button addTarget:self action:@selector(nextVC) forControlEvents:1<<6];
    [self.view addSubview:button];
    button.center = self.view.center;
}

- (void)nextVC
{
    [self.navigationController pushViewController:[[SubViewController alloc] init] animated:YES];
}

@end
