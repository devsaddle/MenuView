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

@interface ViewController ()<MenuViewDataSource,MenuViewDelegate>

@property (nonatomic,strong)ShowBtn *showBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.showBtn];
    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    lab.textColor = [UIColor redColor];
    lab.text = @"这是一段测试文字";
    [self.view addSubview:lab];

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
        _showBtn.layer.cornerRadius = 5;
        _showBtn.layer.shadowOffset = CGSizeMake(0, 3);
        _showBtn.layer.shadowRadius = 5.0;
        _showBtn.layer.shadowColor = [UIColor blackColor].CGColor;
        _showBtn.layer.shadowOpacity = 0.8;
        _showBtn.showsTouchWhenHighlighted = YES;
        [_showBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    

    }
    return _showBtn;
}

#pragma mark - Click

- (void)btnClick {
    CGFloat x = self.showBtn.frame.origin.x + self.showBtn.frame.size.width/2;
    CGFloat y = self.showBtn.frame.origin.y + self.showBtn.frame.size.height;

    NSLog(@"---x:%f--y:%f",x,y);
    MenuView *meunView = [[MenuView alloc] initWithFrame:CGRectMake(x, y, 137, 200)];
    meunView.arrowDirection = ArrowDirectionDefault;
    meunView.selectedIndex = [NSIndexPath indexPathForRow:2 inSection:0];
    meunView.dataSource = self;
    meunView.delegate = self;
    [meunView show];
}

- (NSInteger)numberOfRowsForMenuView:(MenuView *)menuView {
    return 8;
}
- (NSArray *)dataForMenuView:(MenuView *)menuView {
    
    NSArray *imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"fair"],
                           [UIImage imageNamed:@"fun"],
                           [UIImage imageNamed:@"monument"],
                           [UIImage imageNamed:@"snack"],
                           [UIImage imageNamed:@"transport_1432"],
                           [UIImage imageNamed:@"transport_1434"],
                           [UIImage imageNamed:@"transport_1435"],
                           [UIImage imageNamed:@"transport_965"], nil];
    
    return imageArray;
    return @[@"卡萨丁",@"是的",@"玩儿",@"官方",@"全文",@"卡拉胶",@"怕啥",@"去我"];
}
//- (UICollectionViewCell *)contentCellWithCollectionView:(UICollectionView *)collectionView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentifier forIndexPath:indexPath];
//    
//    
//    UILabel *lab = [[UILabel alloc] init];
//    lab.text = [NSString stringWithFormat:@"第  %ld",indexPath.row];
//    [lab sizeToFit];
//    [cell.contentView addSubview:lab];
//    
//    return cell;
//    
//}

- (CGSize)menuView:(MenuView *)menuView imageSizeForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return CGSizeMake(10, 20);
    } else if(indexPath.row == 1) {
        return CGSizeMake(15, 25);
    } else {
        return CGSizeMake(20, 30);

    }
}

- (void)menuView:(MenuView *)menuView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
}

- (id)menuView:(MenuView *)menuView selectStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIImage imageNamed:@"radio"];
    return [UIColor orangeColor];
}

@end
