//
//  DWHistogramView.h
//  BigBigBigKing
//
//  Created by mac on 2019/7/25.
//  Copyright © 2019 QIaobuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DWHistogramView : UIView
- (instancetype)initWithModelArray:(NSArray *)modelArray;

@property (nonatomic,assign) NSInteger intervalHeight; //间隔高度
//@property (nonatomic,assign) 

@end

NS_ASSUME_NONNULL_END
