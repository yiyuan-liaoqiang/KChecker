//
//  TeacherZoneVideoScroll.h
//  IGuXuan
//
//  Created by 廖强 on 15/9/28.
//  Copyright © 2015年 上海股轩文化创意有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TitleIndexViewCallback)(NSInteger tag);

@interface TitleIndexView : UIView

- (id)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray;

- (id)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray andNormalAttri:(NSDictionary *)normalAtt andHighlightAttri:(NSDictionary *)highlightAtt;

/**
 @param isAverage 是否是平均分割
 */
- (id)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray andNormalAttri:(NSDictionary *)normalAtt andHighlightAttri:(NSDictionary *)highlightAtt andIsAverageDivision:(BOOL)isAverage;

@property (nonatomic, strong)NSArray *scrollTitleArray;

@property (nonatomic, strong)UIScrollView *scroll;

@property (nonatomic, strong)UIView *line;                      //下划线
@property (nonatomic, strong)UIView *sepLine;                   //分割线

@property (nonatomic, assign)NSInteger selectedTag;

@property (nonatomic, strong)TitleIndexViewCallback callback;

@property (nonatomic, strong)NSDictionary *normalAttri;
@property (nonatomic, strong)NSDictionary *highlightAttri;
//把label添加到一个数组方便以后用好获取
@property (nonatomic ,strong) NSMutableArray *lblArray;


- (void)updateTitlesWithArray:(NSArray *)titleArray;

- (void)handleActionWithTag:(NSInteger)tag;

- (void)setCurrentIndex:(NSInteger)index;
@end
