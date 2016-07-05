//
//  MenuView.m
//  SelectView
//
//  Created by Yuan on 16/7/3.
//  Copyright (c) 2016年 Yuan. All rights reserved.
//

#import "MenuView.h"
#define leftMargin   30     // 箭头左距离边缘距离
#define rightMargin  30     // 箭头右距离边缘距离
#define arrowHeight   10    // 箭头内部高度
#define arrowMargin   10    // 箭头内部中心间距(三角底边长度一半)
#define coverViewRadius  3  // 圆角
#define collectionCellIden   @"MenuViewCellIden"    // cell Identifier
#define cellHeight      40    // cell 高度
#define cellContentSize  CGSizeMake(100, 40)

@interface MenuCoverView : UIView
{
    @public
    ArrowDirection _arrowDirection;
    UIColor *_fillColor;
}
@end

@interface MenuView ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UITableView *_tableView;
    MenuCoverView *_coverView;
    UICollectionView *_collectionView;

}

@end


@interface MenuCell : UICollectionViewCell
{
    @private
    UILabel *_textLable;
}
+ (instancetype)initMenuCellWithCollectioView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;
- (void)setData:(NSString *)str;
@end

@implementation MenuView

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat y = arrowHeight;
    if (self.arrowDirection == ArrowDirectionDefault) {
        y = 0;
    }
   
    _collectionView.frame = (CGRect) {
        .origin.y = y + 3,
        .size = {_coverView.frame.size.width,_coverView.frame.size.height - y - 3}
    };

}
- (void)show {
  
   UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
}

- (void)creatSubView {
    MenuCoverView *view = [[MenuCoverView alloc] initWithFrame:self.frame];
    view.backgroundColor = [UIColor clearColor];
    view->_arrowDirection = self.arrowDirection;
    view->_fillColor = self.fillColor;
    [self addSubview:view];
    _coverView = view;
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[MenuCell class] forCellWithReuseIdentifier:collectionCellIden];
    [view addSubview:collectionView];
    _collectionView = collectionView;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsForMenuView:)]) {
       return  [self.dataSource numberOfRowsForMenuView:self];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    MenuCell *cell = (MenuCell*)[self contentCellWithCollectionView:collectionView forIndexPath:indexPath];
    
    UIView *seletView = [[UIView alloc] initWithFrame:cell.bounds];
    seletView.backgroundColor = [UIColor redColor];
    cell.selectedBackgroundView = seletView;
    if ([cell isKindOfClass:[MenuCell class]]) {
        [cell setData:[[self dataSorce] objectAtIndex:indexPath.row]];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

// cell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = cellHeight;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(menuView:heightForRowAtIndexPath:)]) {
        height = [self.dataSource menuView:self heightForRowAtIndexPath:indexPath];
    }
    return CGSizeMake(_collectionView.frame.size.width, height);
}

//设置cell与边缘的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
    
}

//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

////最小列间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 50;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
#pragma mark - DataSource 
- (void)setDataSource:(id<MenuViewDataSource>)dataSource {
    
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
    }
    [self creatSubView];
}

- (UICollectionViewCell *)contentCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *contenView = nil;
    CGFloat height = cellHeight;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(menuView:heightForRowAtIndexPath:)]) {
        height = [self.dataSource menuView:self heightForRowAtIndexPath:indexPath];
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(menuView:cellForRowAtIndexPath:)]) {
        contenView = [self.dataSource menuView:self cellForRowAtIndexPath:indexPath];
    } else {
        contenView = [MenuCell initMenuCellWithCollectioView:collectionView forIndexPath:indexPath];
//        contenView.backgroundColor = self.fillColor;
    }
    return contenView;
}

// cell内容尺寸
//- (CGSize)sizeOfContentCellForIndexPath:(NSIndexPath *)indexPath {
//    return [self contentCellForIndexPath:indexPath].frame.size;
//}

- (NSArray *)dataSorce {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(dataForMenuView:)]) {
       return [self.dataSource dataForMenuView:self];
    }
    return @[];
}
@end



@implementation MenuCoverView
//
//- (void)drawRect:(CGRect)rect {
//    CGFloat x = 0;
//    CGFloat y = 0;
//    
//    if (self.arrowDirection == ArrowDirectionDefault) {
//        
//    } else if (self.arrowDirection == ArrowDirectionLeft) {
//        x = leftMargin;
//        y = arrowHeight;
//    } else if (self.arrowDirection == ArrowDirectionRight) {
//        x = rect.size.width - (rightMargin + 2*arrowMargin);
//        y = arrowHeight;
//    } else if (self.arrowDirection == ArrowDirectionMiddle) {
//        x = rect.size.width/2 - arrowMargin;
//        y = arrowHeight;
//    }
//    
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    /*画三角形*/
//    //只要三个点就行跟画一条线方式一样，把三点连接起来
//    CGPoint sPoints[3];//坐标点
//    sPoints[0] =CGPointMake(x, y);//坐标1
//    sPoints[1] =CGPointMake(x + 2*arrowMargin, y);//坐标2
//    sPoints[2] =CGPointMake(x + arrowMargin, y - arrowHeight);//坐标3
//    CGContextAddLines(context, sPoints, 3);//添加线
//    CGContextClosePath(context);//封起来
//    CGContextSetFillColorWithColor(context, _fillColor.CGColor);//填充颜色
//    CGContextSetLineWidth(context, 0); // 线宽度
//    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
//}

- (void)drawRect:(CGRect)rect {
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;

    if (self.arrowDirection == ArrowDirectionDefault) {
        
    } else if (self.arrowDirection == ArrowDirectionLeft) {
        x = leftMargin;
        y = arrowHeight;
    } else if (self.arrowDirection == ArrowDirectionRight) {
        x = rect.size.width - (rightMargin + 2*arrowMargin);
        y = arrowHeight;
    } else if (self.arrowDirection == ArrowDirectionMiddle) {
        x = rect.size.width/2 - arrowMargin;
        y = arrowHeight;
    }
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /*画三角形*/
    //只要三个点就行跟画一条线方式一样，把三点连接起来
    CGPoint sPoints[3];//坐标点
    sPoints[0] =CGPointMake(x, y);//坐标1
    sPoints[1] =CGPointMake(x + 2*arrowMargin, y);//坐标2
    sPoints[2] =CGPointMake(x + arrowMargin, y - arrowHeight);//坐标3
    CGContextAddLines(context, sPoints, 3);//添加线
    CGContextClosePath(context);//封起来
    CGContextSetFillColorWithColor(context, _fillColor.CGColor);//填充颜色
    CGContextSetLineWidth(context, 0); // 线宽度
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
    /*画矩形*/
//    CGContextFillRect(context,CGRectMake(0, y, rect.size.width, rect.size.height-y));//填充框
//    //矩形，并填弃颜色
//    CGContextSetLineWidth(context, 0);//线的宽度
//    CGContextSetFillColorWithColor(context, _fillColor.CGColor);//填充颜色
//    CGContextAddRect(context,CGRectMake(0, y, rect.size.width, rect.size.height-y));//画方框
//    CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
    

    CGFloat radius = coverViewRadius;
    // 移动到初始点
    CGContextMoveToPoint(context, x + radius, y);
    
    // 绘制第1条线和第1个1/4圆弧
    CGContextAddLineToPoint(context, x + width - radius, y);
    CGContextAddArc(context, width - radius, y + radius, radius, -0.5 * M_PI, 0.0, 0);

    // 绘制第2条线和第2个1/4圆弧
    CGContextAddLineToPoint(context, x + width, y + height - radius);
    CGContextAddArc(context, width - radius, height - radius, radius, 0.0, 0.5 * M_PI, 0);

    // 绘制第3条线和第3个1/4圆弧
    CGContextAddLineToPoint(context, radius, y + height);
    CGContextAddArc(context, radius, height - radius, radius, 0.5 * M_PI, M_PI, 0);

    // 绘制第4条线和第4个1/4圆弧
    CGContextAddLineToPoint(context, 0, y + radius);
    CGContextAddArc(context, radius, y + radius, radius, M_PI, 1.5 * M_PI, 0);

    // 闭合路径
    CGContextClosePath(context);
    // 填充半透明黑色
    CGContextSetFillColorWithColor(context, _fillColor.CGColor);//填充颜色
    CGContextDrawPath(context, kCGPathFill);
}

- (void)setArrowDirection:(ArrowDirection)direction {
    _arrowDirection = direction;
    [self setNeedsDisplay];
}


- (ArrowDirection)arrowDirection {
    if (_arrowDirection) {
        return _arrowDirection;
    }
    return ArrowDirectionDefault;
}


@end

@implementation MenuCell

+ (instancetype)initMenuCellWithCollectioView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
        MenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIden forIndexPath:indexPath];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}


- (void)initViews {
    _textLable = [[UILabel alloc] initWithFrame:self.bounds];
    [_textLable setTextColor:[UIColor whiteColor]];
    [_textLable setTextAlignment:NSTextAlignmentCenter];
    [_textLable setLineBreakMode:NSLineBreakByTruncatingTail];
    [_textLable setBackgroundColor:[UIColor clearColor]];
    [_textLable setFont:[UIFont systemFontOfSize:14.0]];
    [self.contentView addSubview:_textLable];
}


- (void)setData:(NSString *)str {
    _textLable.text = str;
}
@end