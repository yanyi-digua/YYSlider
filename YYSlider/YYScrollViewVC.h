//
//  YYScrollViewVC.h
//  YYSlider
//
//  Created by 如步 on 2017/2/22.
//  Copyright © 2017年 如步. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYScrollViewVC : UIViewController
//标题
@property (nonatomic,strong)NSMutableArray *titleArray;
//存储button
@property (nonatomic,strong)NSMutableArray *buttonArray;
@property(nonatomic,retain)UIScrollView  *sv;
//图片数组
@property (nonatomic,strong)NSMutableArray *imgArray;

- (instancetype)initWithAdvertArr:(NSMutableArray *)titleArr passType:(NSInteger)type;
@end
