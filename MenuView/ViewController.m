//
//  ViewController.m
//  MenuView
//
//  Created by Yuan on 16/7/3.
//  Copyright (c) 2016年 Yuan. All rights reserved.
//

#import "ViewController.h"
#import "ShowBtn.h"
#import "MenuView.h"

@interface ViewController ()

@property (nonatomic,strong)ShowBtn *showBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.showBtn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lazy Load
- (UIButton *)showBtn {
    if (_showBtn == nil) {
        
        _showBtn = [ShowBtn buttonWithType:UIButtonTypeCustom];
        _showBtn.frame = CGRectMake(50, 50, 70, 45);
        [_showBtn setTitle:@"点击" forState:UIControlStateNormal];
        [_showBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_showBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
        [_showBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _showBtn.layer.borderWidth = 2;
        _showBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _showBtn.layer.cornerRadius = 5;
        _showBtn.layer.masksToBounds = YES;
        _showBtn.showsTouchWhenHighlighted = YES;
        [_showBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showBtn;
}

#pragma mark - Click

- (void)btnClick {
    NSLog(@"-----%@",NSStringFromCGPoint(self.showBtn.frame.origin));
    CGFloat x = self.showBtn.frame.origin.x + self.showBtn.frame.size.width/2;
    CGFloat y = self.showBtn.frame.origin.y + self.showBtn.frame.size.height;

    
    MenuView *meunView = [[MenuView alloc] initWithFrame:CGRectMake(x, y, 170, 270)];
    meunView.arrowDirection = ArrowDirectionMiddle;
    meunView.fillColor = [UIColor colorWithWhite:0.286 alpha:0.8];
    [meunView show];
}

@end
