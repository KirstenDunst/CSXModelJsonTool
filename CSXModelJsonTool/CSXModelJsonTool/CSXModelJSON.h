/*      __.--'\     \.__./     /'--.__
    _.-'       '.__.'    '.__.'       '-._
  .'                曹世鑫                 '.
/                                           \
|    CSDN:https://me.csdn.net/BUG_delete     |
|   GitHub:https://github.com/KirstenDunst   |
\         .---.              .---.          /
  '._    .'     '.''.    .''.'     '.    _.'
     '-./            \  /            \.-'
                      ''*/
//
//  FBMineJsonModel.h
//  FSFuBei
//
//  Created by 曹世鑫 on 2019/5/27.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSXModelJSON : NSObject

@property (nonatomic, copy)NSString *nameStr;
@property (nonatomic, assign)float cellHeight;
@property (nonatomic, assign)NSInteger age;
@property (nonatomic, assign)double one;
@property (nonatomic, assign)NSUInteger two;
@property (nonatomic, strong)NSNumber *three;
@property (nonatomic, strong)DetailModel *detailModel;

@end

NS_ASSUME_NONNULL_END
