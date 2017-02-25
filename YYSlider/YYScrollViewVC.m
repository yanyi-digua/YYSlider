//
//  YYScrollViewVC.m
//  YYSlider
//
//  Created by 如步 on 2017/2/22.
//  Copyright © 2017年 如步. All rights reserved.
//

#import "YYScrollViewVC.h"
#import "Masonry.h"
@interface YYScrollViewVC ()<UIScrollViewDelegate>
{
    //记住当前点击的button
    NSInteger _currentSelectButton;
    UILabel *_lineLabel;
}
//高度
#define IPHONE_HEIGHT [[UIScreen mainScreen] bounds].size.height
//宽度
#define IPHONE_WIDTH [[UIScreen mainScreen] bounds].size.width
@end

@implementation YYScrollViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (instancetype)initWithAdvertArr:(NSMutableArray *)titleArr passType:(NSInteger)type
{
    //self.view.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT);
    self.buttonArray = [[NSMutableArray alloc]initWithCapacity:0];
    self = [super init];
    if (self) {
        
        self.imgArray = [[NSMutableArray alloc]initWithObjects:@"1.jpg",@"11.jpg",@"111.jpg",@"1111.jpg",@"11111.jpg", nil];
        
        self.titleArray = titleArr;
        NSLog(@"123---%f",self.view.frame.size.width);
        for (int i = 0; i < titleArr.count; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.frame = CGRectMake(IPHONE_WIDTH/titleArr.count*i, 70, IPHONE_WIDTH/titleArr.count, 40);
            if (i == 0) {
                [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];

            }
            else
            {
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

            }
            [button setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            button.tag = i;
            button.titleLabel.lineBreakMode=UILineBreakModeWordWrap;
            button.titleLabel.font=[UIFont systemFontOfSize:17];
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside ];
            [self.buttonArray addObject:button];
            [self.view addSubview:button];
            

            
      
        }
      _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:_lineLabel];
        UIButton *firstButton = [self.buttonArray objectAtIndex:0];
      CGFloat lineWidth = [self lineLabel:0];
        [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(110);
            make.centerX.equalTo(firstButton.mas_centerX).with.priorityHigh();
            make.width.offset(lineWidth);
            make.height.offset(1);
        }];
        _sv = [[UIScrollView alloc]init];
        _sv.delegate = self;
        _sv.pagingEnabled = YES;
       // _sv.backgroundColor = [UIColor blueColor];
        _sv.contentSize = CGSizeMake(IPHONE_WIDTH*_titleArray.count,IPHONE_HEIGHT-111);

        [self.view addSubview:_sv];
        [_sv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(firstButton.mas_bottom).with.offset(1);
            make.left.equalTo(self.view.mas_left).with.offset(0);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        for (int i = 0; i < titleArr.count; i++)
        {
        //图片
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(IPHONE_WIDTH*i, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
        img.image = [UIImage imageNamed:[self.imgArray objectAtIndex:i]];
        [_sv addSubview:img];
        }
    }
    return self;

}

- (void)btnClick:(UIButton *)sender
{
    UIButton *lastButton = [_buttonArray objectAtIndex:_currentSelectButton];
    [lastButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIButton *nowButton = [self.buttonArray objectAtIndex:sender.tag];
    CGFloat lineWidth = [self lineLabel:sender.tag];

    [nowButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    //重新设置约束可以，但是更新约束不行，不知道为什么
    [_lineLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(110);
        make.centerX.equalTo(nowButton.mas_centerX).with.priorityHigh();
        make.width.offset(lineWidth);
        make.height.offset(1);
    }];
    
    [ _sv setContentOffset:CGPointMake(_sv.frame.size.width*sender.tag, 0) animated:YES];

    //[_lineLabel updateConstraintsIfNeeded];
    _currentSelectButton = sender.tag;

    
}
- (CGFloat)lineLabel:(NSInteger)buttonTag
{
    NSString *title = [_titleArray objectAtIndex:buttonTag];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    return size.width;
}
#pragma mark- scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UIButton *lastButton = [_buttonArray objectAtIndex:_currentSelectButton];
    [lastButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSInteger nowButtonTag = scrollView.contentOffset.x/scrollView.frame.size.width;
    CGFloat lineWidth = [self lineLabel:nowButtonTag];
    UIButton *nowButton = [self.buttonArray objectAtIndex:nowButtonTag];

    [nowButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    //重新设置约束可以，但是更新约束不行，不知道为什么
    [_lineLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(110);
        make.centerX.equalTo(nowButton.mas_centerX).with.priorityHigh();
        make.width.offset(lineWidth);
        make.height.offset(1);
    }];

_currentSelectButton = scrollView.contentOffset.x/scrollView.frame.size.width;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
