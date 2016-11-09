//
//  YTDataBaseManager.h
//  YTDataBaseManagerDemo
//
//  Created by 余婷 on 16/11/9.
//  Copyright © 2016年 余婷. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface YTDataBaseManager : NSObject

+ (YTDataBaseManager*)defaultManager;


/**
 * @brief 将指定的对象插入数据库的表中.
 *
 * @param  objc 需要插入到表中的对象.
 *
 */
- (void)yt_insertObject:(id)objc;

/**
 * @brief 获取数据库中指定类型的所有的数据.
 *
 * @return 数据库中指定的类型的对象数组.
 */
- (NSArray*)yt_getAlldataWithClass:(Class)objcClass;

/**
 * @brief 删除指定表中指定数据.
 *
 * @param  key 字段名.
 * @param  value 需要删除的字段对应的条件值.
 * @param  tclass 表对应的类.
 *
 * @return 返回value.
 */
- (void)yt_deleteDataWithKey:(NSString*)key value:(id)value tClass:(Class)tclass;


@end
