//
//  TeacherZoneVideoScroll.m
//  IGuXuan
//
//  Created by 廖强 on 15/9/28.
//  Copyright © 2015年 上海股轩文化创意有限公司. All rights reserved.
//

#import "TitleIndexView.h"
#import "NSString+CalculateSize.h"

@implementation TitleIndexView

- (id)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray
{
<<<<<<< HEAD
    
    
=======
>>>>>>> d2bb362d62ce1e5a9388709e86c5ce6118d52b5c
    NSMutableDictionary *normalDic = [[NSMutableDictionary alloc] init];
    UIFont *normalFont = [UIFont systemFontOfSize:16*SystemRatio];
    UIColor *normalColor = kUIColorFromRGB(0x333333);
    [normalDic setObject:normalFont forKey:@"font"];
    [normalDic setObject:normalColor forKey:@"color"];
    
    NSMutableDictionary *highlightDic = [[NSMutableDictionary alloc] init];
    UIFont *highlightFont = [UIFont systemFontOfSize:16*SystemRatio];
    UIColor *highlightColor = MAIN_THEME_COLOR;
    [highlightDic setObject:highlightFont forKey:@"font"];
    [highlightDic setObject:highlightColor forKey:@"color"];
    self = [self initWithFrame:frame andTitleArray:titleArray andNormalAttri:normalDic andHighlightAttri:highlightDic];
    if(self)
    {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray andNormalAttri:(NSDictionary *)normalAtt andHighlightAttri:(NSDictionary *)highlightAtt 
{
    self = [self initWithFrame:frame andTitleArray:titleArray andNormalAttri:normalAtt andHighlightAttri:highlightAtt andIsAverageDivision:YES];

    return self;
}

- (id)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray andNormalAttri:(NSDictionary *)normalAtt andHighlightAttri:(NSDictionary *)highlightAtt andIsAverageDivision:(BOOL)isAverage
{
    self = [super initWithFrame:frame];
    if (self) {
        self.normalAttri = normalAtt;
        self.highlightAttri = highlightAtt;
        
        self.scrollTitleArray = titleArray;
        CGFloat per_width = MAIN_SCREEN_WIDTH/titleArray.count;
        
        self.scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scroll.backgroundColor = [UIColor whiteColor];
        self.scroll.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scroll];
        
<<<<<<< HEAD
        self.lblArray = [NSMutableArray arrayWithCapacity:10];
=======
>>>>>>> d2bb362d62ce1e5a9388709e86c5ce6118d52b5c
        CGFloat totalWidth = 0;
        for (int i = 0; i<self.scrollTitleArray.count; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.tag = 10+i;
            label.text = [self.scrollTitleArray objectAtIndex:i];
            label.textAlignment = NSTextAlignmentCenter;
            label.userInteractionEnabled = YES;
            [self setState:YES WithLabel:label];
            [self.scroll addSubview:label];
<<<<<<< HEAD
            [self.lblArray addObject:label];
=======
            
>>>>>>> d2bb362d62ce1e5a9388709e86c5ce6118d52b5c
            if (isAverage) {
                //如果是平均分割长度
                label.frame = CGRectMake(totalWidth, 0, per_width, frame.size.height);
                totalWidth = totalWidth+per_width;
            }
            else
            {
                //
                CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(200, 30)];
                label.frame = CGRectMake(totalWidth, 0, size.width+20*SystemRatio, frame.size.height);
                totalWidth = totalWidth+size.width+30*SystemRatio;
            }
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [label addGestureRecognizer:tap];
        }
        self.scroll.contentSize = CGSizeMake(totalWidth, 0);
        
<<<<<<< HEAD
//        UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(-10, frame.size.height-1, MAIN_SCREEN_WIDTH+20, 1)];
//        sepLine.backgroundColor = kUIColorFromRGB(0xe5e5e5);
//        [self addSubview:sepLine];
//        self.sepLine = sepLine;
=======
        UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(-10, frame.size.height-1, MAIN_SCREEN_WIDTH+20, 1)];
        sepLine.backgroundColor = kUIColorFromRGB(0xe5e5e5);
        [self addSubview:sepLine];
        self.sepLine = sepLine;
>>>>>>> d2bb362d62ce1e5a9388709e86c5ce6118d52b5c
        
        self.line = [[UIView alloc] init];
        self.line.frame = CGRectMake(10, frame.size.height-2, 40, 3);
        self.line.backgroundColor = MAIN_THEME_COLOR;
        [self.scroll addSubview:self.line];
        
        [self handleActionWithTag:10];
    }
    return self;
}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    [self handleActionWithTag:tap.view.tag];
}

- (void)handleActionWithTag:(NSInteger)tag
{
    [self setCurrentIndex:tag];
    
    if(self.callback)
        self.callback(tag-10);
}

- (void)setCurrentIndex:(NSInteger)tag
{
    if(self.selectedTag)
    {
        UILabel *oldLabel = (UILabel *)[self.scroll viewWithTag:self.selectedTag];
        [self setState:YES WithLabel:oldLabel];
    }
    
    UILabel *lab = (UILabel *)[self.scroll viewWithTag:tag];
    [self setState:NO WithLabel:lab];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.line.frame;
        rect.origin.x = lab.frame.origin.x;
        rect.size.width = lab.frame.size.width;
        
        self.line.frame = rect;
    }];
    
    self.selectedTag = tag;
}

- (void)updateTitlesWithArray:(NSArray *)titleArray
{
    for (int i = 0; i<self.scrollTitleArray.count; i++) {
        UILabel *label = [self.scroll viewWithTag:10+i];
        label.text = [titleArray objectAtIndex:i];
    }
}

- (void)setState:(BOOL)isNormal WithLabel:(UILabel *)label
{
    if (isNormal) {
        label.textColor = [self.normalAttri objectForKey:@"color"];
        label.font = [self.normalAttri objectForKey:@"font"];
    }
    else
    {
        label.textColor = [self.highlightAttri objectForKey:@"color"];
        label.font = [self.highlightAttri objectForKey:@"font"];
    }
}

<<<<<<< HEAD
=======
//- (void)setSelectedTag:(NSInteger)selectedTag
//{
//    NSLog(@"点击了 pageindex %ld",selectedTag);
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

>>>>>>> d2bb362d62ce1e5a9388709e86c5ce6118d52b5c
@end
