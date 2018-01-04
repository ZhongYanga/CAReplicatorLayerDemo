//
//  ViewController.m
//  CAReplicatorLayer
//
//  Created by zhongyang on 2017/11/30.
//  Copyright © 2017年 zhongyang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/** testView */
@property (nonatomic, strong) UIView *testView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self musicAnimation];
    [self activityIndicatorAnimation];
    NSLog(@"git test");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Method
- (void)musicAnimation
{
    //创建CAReplicatorLayer
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = self.testView.bounds;
    replicatorLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    replicatorLayer.anchorPoint = CGPointMake(0, 0);
    [self.testView.layer addSublayer:replicatorLayer];
    
    //创建一个普通的CALayer
    CALayer *rectangleLayer = [CALayer layer];
    rectangleLayer.bounds = CGRectMake(0, 0, 8, 90);
    rectangleLayer.anchorPoint = CGPointMake(0, 0);
    rectangleLayer.position = CGPointMake (10, 110);
    rectangleLayer.cornerRadius = 2;
    rectangleLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicatorLayer addSublayer:rectangleLayer];
    
    //将replicatorLayer的子Layer复制3份，复制Layer与原Layer的大小、位置、颜色、Layer上的动画等等所有属性都一模一样
    replicatorLayer.instanceCount = 15;
    //CATransform3DMakeTranslation这个类的含义是使Layer根据X、Y、Z轴进行平移
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(20, 0, 0);
    //instanceDelay这个属性使CAReplicatorLayer中的每个子Layer的动画起始时间逐个递增
    replicatorLayer.instanceDelay = 0.3;
    //超出它边界的内容进行裁剪
    replicatorLayer.masksToBounds = YES;

    //让rectangleLayer按Y轴移动
    CABasicAnimation *moveRectangleAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    moveRectangleAnimation.toValue = @(rectangleLayer.position.y - 70);
    moveRectangleAnimation.duration = 0.7;
    moveRectangleAnimation.autoreverses = YES;
    moveRectangleAnimation.repeatCount = HUGE;
    [rectangleLayer addAnimation:moveRectangleAnimation forKey:nil];
}
- (void)activityIndicatorAnimation
{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer new];
    replicatorLayer.bounds = CGRectMake(0, 0, 200, 200);
    replicatorLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    replicatorLayer.position = CGPointMake(self.view.center.x, self.view.center.y);
    [self.view.layer addSublayer:replicatorLayer];
    
    CALayer *subLayer = [CALayer new];
    subLayer.bounds = CGRectMake(0, 0, 14, 14);
    subLayer.position = CGPointMake(100, 40);
    subLayer.backgroundColor = [UIColor whiteColor].CGColor;
    subLayer.cornerRadius = 7;
    [replicatorLayer addSublayer:subLayer];
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = @1.0;
    scale.toValue = @0.1;
    scale.duration = 1.5;
    scale.repeatCount = INFINITY;
    [subLayer addAnimation:scale forKey:nil];
    
    replicatorLayer.instanceCount = 15;
    CGFloat angle = (2 * M_PI)/15;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1.0);
    replicatorLayer.instanceDelay = 1.5/15;
    subLayer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
}
#pragma mark - lazyload
- (UIView *)testView
{
    if (!_testView) {
        _testView = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100, 100, 200, 130)];
//        _testView.center = self.view.center;
        _testView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_testView];
    }
    return _testView;
}
@end
