//
//  WOPageControl.m
//  WOPageControl-OC
//
//  Created by wayone on 2020/2/10.
//  Copyright © 2020 aaa. All rights reserved.
//

#import "WOPageControl.h"

@interface WOPageControl ()

@property (nonatomic, strong) NSMutableArray *dotViewArrayM;
@property (nonatomic, assign) BOOL isInitialize;
@property (nonatomic, assign) BOOL inAnimating;

@end

@implementation WOPageControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.otherDotColor = [UIColor lightGrayColor];
        self.currentDotColor = [UIButton buttonWithType:UIButtonTypeSystem].tintColor;
        self.isInitialize = YES;
        self.inAnimating = NO;
        self.dotViewArrayM = [NSMutableArray array];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateUI];
}

- (void)updateUI {
    if (self.dotViewArrayM.count == 0) return;
    if (self.isInitialize) {
        self.isInitialize = NO;
        CGFloat totalWidth = self.currentDotWidth + (self.numberOfPages - 1) * (self.dotSpace + self.otherDotWidth);
        CGFloat currentX = (self.frame.size.width - totalWidth) / 2;
        for (int i = 0; i < self.dotViewArrayM.count; i++) {
            UIView *dotView = self.dotViewArrayM[i];
            
            // 更新位置
            CGFloat width = (i == self.currentPage ? self.currentDotWidth : self.otherDotWidth);
            CGFloat height = self.dotHeight;
            CGFloat x = currentX;
            CGFloat y = (self.frame.size.height - height) / 2;
            dotView.frame = CGRectMake(x, y, width, height);
            
            currentX = currentX + width + self.dotSpace; // 走到下一个点开的开头位置
            
            // 更新颜色
            dotView.backgroundColor = self.otherDotColor;
            if (i == self.currentPage) {
                dotView.backgroundColor = self.currentDotColor;
            }
        }
    }
}

#pragma mark - ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ Setter ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

- (void)setNumberOfPages:(int)numberOfPages {
    
    _numberOfPages = numberOfPages;
    
    if (self.dotViewArrayM.count > 0) {
        [self.dotViewArrayM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             [(UIView *)obj removeFromSuperview];
         }];
        [self.dotViewArrayM removeAllObjects];
    }
    
    for (int i = 0; i < numberOfPages; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectZero];
        dotView.layer.cornerRadius = self.cornerRadius;
        [self addSubview:dotView];
        [self.dotViewArrayM addObject:dotView];
    }
    
    self.isInitialize = YES;
    [self setNeedsLayout];
}

- (void)setCurrentPage:(int)currentPage {
    if (currentPage < 0 ||
        currentPage >= self.dotViewArrayM.count ||
        self.dotViewArrayM.count == 0 ||
        currentPage == _currentPage ||
        self.inAnimating)
    {
        return;
    }
    
    // 向右
    if (currentPage > self.currentPage) {
        UIView *currentView = self.dotViewArrayM[self.currentPage];
        [self bringSubviewToFront:currentView];
        self.inAnimating = YES;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect tempFrame = currentView.frame;
            // 当前选中的圆点，x 不变，宽度增加，增加几个圆点和间隙距离
            CGFloat width = self.currentDotWidth + (self.dotSpace + self.otherDotWidth) * (currentPage - self.currentPage);
            CGFloat height = tempFrame.size.height;
            tempFrame.size = CGSizeMake(width, height);
            currentView.frame = tempFrame;
        } completion:^(BOOL finished) {

            UIView *endView = self.dotViewArrayM[currentPage];
            endView.backgroundColor = currentView.backgroundColor;
            endView.frame = currentView.frame;
            [self bringSubviewToFront:endView];
            
            currentView.backgroundColor = self.otherDotColor;
            
            // 逐个左移 view
            CGFloat start_X = currentView.frame.origin.x;
            for (int i = 0; i < (currentPage - self.currentPage); i++) {
                UIView *dotView = self.dotViewArrayM[self.currentPage + i];
                CGRect tempFrame = dotView.frame;
                // 左移
                tempFrame.origin = CGPointMake(start_X + (self.otherDotWidth + self.dotSpace) * i, tempFrame.origin.y);
                tempFrame.size = CGSizeMake(self.otherDotWidth, self.dotHeight);
                dotView.frame = tempFrame;
            }
            
            [UIView animateWithDuration:0.3 animations:^{
                CGFloat w = self.currentDotWidth;
                CGFloat x = CGRectGetMaxX(endView.frame) - self.currentDotWidth;
                CGFloat y = endView.frame.origin.y;
                CGFloat h = endView.frame.size.height;
                endView.frame = CGRectMake(x, y, w, h);
            } completion:^(BOOL finished) {
                _currentPage = currentPage;
                self.inAnimating = NO;
            }];
        }];
    }
    // 向左
    else
    {
        UIView *currentView = self.dotViewArrayM[self.currentPage];
        [self bringSubviewToFront:currentView];
        self.inAnimating = YES;
        [UIView animateWithDuration:0.3 animations:^{
            // 当前选中的圆点，x 左移，宽度增加，增加几个圆点和间隙距离
            CGFloat x = currentView.frame.origin.x - (self.dotSpace + self.otherDotWidth) * (self.currentPage - currentPage);
            CGFloat y = currentView.frame.origin.y;
            CGFloat w = self.currentDotWidth + (self.dotSpace + self.otherDotWidth) * (self.currentPage - currentPage);
            CGFloat h = currentView.frame.size.height;
            currentView.frame = CGRectMake(x, y, w, h);
        } completion:^(BOOL finished) {
            
            UIView *endView = self.dotViewArrayM[currentPage];
            endView.backgroundColor = currentView.backgroundColor;
            endView.frame = currentView.frame;
            [self bringSubviewToFront:endView];
            
            currentView.backgroundColor = self.otherDotColor;
            
            // 逐个移动后面的 view
            CGFloat start_X = CGRectGetMaxX(currentView.frame);
            for (int i = 0; i < (self.currentPage - currentPage); i++) {
                UIView *dotView = self.dotViewArrayM[self.currentPage - i];
                CGRect tempFrame = dotView.frame;
                // 右移
                CGFloat x = start_X - self.otherDotWidth - (self.otherDotWidth + self.dotSpace) * i;
                CGFloat y = tempFrame.origin.y;
                CGFloat w = self.otherDotWidth;
                CGFloat h = tempFrame.size.height;
                dotView.frame = CGRectMake(x, y, w, h);
            }
                
            [UIView animateWithDuration:0.3 animations:^{
                CGFloat x = endView.frame.origin.x;
                CGFloat y = endView.frame.origin.y;
                CGFloat w = self.currentDotWidth;
                CGFloat h = endView.frame.size.height;
                endView.frame = CGRectMake(x, y, w, h);
            } completion:^(BOOL finished) {
                _currentPage = currentPage;
                self.inAnimating = NO;
            }];
        }];
    }
}

@end
