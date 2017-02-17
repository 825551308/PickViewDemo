//
//  MPPickView.h
//  PickViewDemo
//
//  Created by 金汕汕 on 16/12/3.
//  Copyright © 2016年 ccs. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, Evetype) {
    EvetypeOfNSString = 0,          //
    EvetypeOfNSArray = 1,       //
    EvetypeOfError = 2, //
};
@interface MPPickView : UIView


typedef void (^ReturnTextBlock)(NSString *showText);
@property (nonatomic, copy) ReturnTextBlock returnTextBlock;

typedef void (^ReturnTextArrayBlock)(NSArray *showArray);
@property (nonatomic, copy) ReturnTextArrayBlock returnArrayBlock;

/**
 *  初始化方法
 *
 *  @return <#return value description#>
 */
+ (MPPickView *)instanceMPPickView;


/**
 *  创建对象
 *
 *  @param datas 数据源
 */
- (void)createView:(NSMutableArray *)datas;



/***************************************************使用案例****************************************************/

/**

    MPPickView *mp = [MPPickView  instanceMPPickView];
    mp.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 150);
    [mp createView:[@[@"11",@"22",@"33",@"44",@"55"] mutableCopy] ];
    mp.returnTextBlock = ^(NSString *showText){
        NSLog(@"选中了:%@",showText);
    };;
    [self.view addSubview:mp];

 */

@end
