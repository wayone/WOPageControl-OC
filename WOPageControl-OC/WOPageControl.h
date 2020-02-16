//
//  WOPageControl.h
//  WOPageControl-OC
//
//  Created by wayone on 2020/2/10.
//  Copyright © 2020 aaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOPageControl : UIView

@property (nonatomic, assign) int numberOfPages;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, strong) UIColor *otherDotColor;
@property (nonatomic, strong) UIColor *currentDotColor;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat currentDotWidth;
@property (nonatomic, assign) CGFloat otherDotWidth;
@property (nonatomic, assign) CGFloat dotHeight;
@property (nonatomic, assign) CGFloat dotSpace;

@end
