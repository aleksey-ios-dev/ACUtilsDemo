//
// Created by Aleksey on 18.04.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

typedef NSString *(^ACRowTitleBlock)(id object);
typedef NSString *(^ACSectionTitleBlock)(id anyObject);
typedef NSComparisonResult(^ACComparisonBlock)(id obj1, id obj2);
typedef Class (^ACCellClassBlock)(NSIndexPath *indexPath, id object);

#define ac_safeBlockCall(block, ...) block ? block(__VA_ARGS__) : nil

