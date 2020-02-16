//
//  ViewController.m
//  WOPageControl-OC
//
//  Created by wayone on 2020/2/16.
//  Copyright © 2020 aaa. All rights reserved.
//

#import "ViewController.h"
#import "WOPageControl.h"

@interface ViewController ()

@property (nonatomic, strong) WOPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.pageControl = [[WOPageControl alloc] initWithFrame:CGRectMake(110, 200, 200, 4)];
    [self.view addSubview:self.pageControl];
    self.pageControl.center = CGPointMake(self.pageControl.superview.center.x, self.pageControl.center.y);
    
    self.pageControl.cornerRadius = 5;
    self.pageControl.dotHeight = 10;
    self.pageControl.dotSpace = 24;
    self.pageControl.currentDotWidth = 20;
    self.pageControl.otherDotWidth = 10;
    self.pageControl.otherDotColor = [UIColor colorWithRed:232/255.0 green:234/255.0 blue:236/255.0 alpha:1];
    self.pageControl.currentDotColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
    self.pageControl.numberOfPages = 5;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.pageControl.currentPage = (self.pageControl.currentPage + 1 + self.pageControl.numberOfPages) % self.pageControl.numberOfPages;
}

@end
