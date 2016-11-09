//
//  YTDataBaseManager.m
//  YTDataBaseManagerDemo
//
//  Created by 余婷 on 16/11/9.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "YTDataBaseManager.h"
#import "FMDatabase.h"
#import <objc/runtime.h>

@interface YTDataBaseManager()

//数据库对象
@property(nonatomic,strong) FMDatabase * db;

@end

@implementation YTDataBaseManager

//当前类的单例对象
+ (YTDataBaseManager*)defaultManager{

    static YTDataBaseManager * manager = nil;
    if (manager == nil) {
        
        manager = [[YTDataBaseManager alloc] init];
    }
    
    return manager;
}

//重新构造方法，在创建当前类的对象的时候创建并打开数据库
- (instancetype)init{

    if (self = [super init]) {
        
        //获取沙盒目录
        NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        //拼接数据库地址
        NSString* dbPath = [NSString stringWithFormat:@"%@/yt_User.db",path];
        self.db = [[FMDatabase alloc] initWithPath:dbPath];
        BOOL ret = self.db.open;
        if (ret) {
            
            NSLog(@"yt_数据库打开成功");
        }else{
        
            NSLog(@"yt_数据库打开失败");
        }
    }
    
    return self;
}

///创建表,不同类型的对象，对应不同的表
- (void)creatTableWithClass:(Class)objcClass{

    const char * className = class_getName(objcClass);
    NSArray * allPropertyName = [self yt_getAllPropertyNameWithClass:objcClass];
    
    NSString * tableName = [NSString stringWithUTF8String:className];
    NSMutableString * propertyStr = [NSMutableString new];
    for (NSString * name in allPropertyName) {
        
        [propertyStr appendFormat:@",%@ text",name];
    }
    
    NSString * sqlStr = [[NSString alloc] initWithFormat:@"CREATE TABLE IF NOT EXISTS t_%@(id integer PRIMARY KEY AUTOINCREMENT%@);",tableName,propertyStr];
    
    if ([self.db executeUpdate:sqlStr]) {
        
        NSLog(@"%@表创建成功",tableName);
    }else{
    
        NSLog(@"%@表创建失败",tableName);
    }
}

//获取指定类型中的所有属性
- (NSArray*)yt_getAllPropertyNameWithClass:(Class)objcClass{

    unsigned int outCount;
    objc_property_t * propertyLists = class_copyPropertyList(objcClass, &outCount);
    NSMutableArray * propertyNames = [[NSMutableArray alloc] init];
    for (int i = 0; i < outCount; i++) {
        
        objc_property_t property = propertyLists[i];
        const char * name = property_getName(property);
        [propertyNames addObject:[NSString stringWithUTF8String:name]];
    }
    
    return propertyNames;
}

#pragma mark - 外部函数
- (NSArray *)yt_getAlldataWithClass:(Class)objcClass{

    const char * tableName = class_getName(objcClass);
    NSString * sqlStr = [[NSString alloc] initWithFormat:@"SELECT * FROM t_%s;",tableName];
    
    FMResultSet * set = [[self db] executeQuery:sqlStr];
    if (set) {
        NSLog(@"查询成功");
        NSMutableArray * resultArray = [NSMutableArray new];
        while ([set next]) {
            
            id objc = [objcClass new];
            for (NSString * name in [self yt_getAllPropertyNameWithClass:objcClass]) {
                
                id value = [set objectForColumnName:name];
                [objc setValue:value forKey:name];
            }
            
            [resultArray addObject:objc];
        }//while循环结束
        
        return resultArray;
        
    }else{
    
        NSLog(@"查询失败");
    }
    
    return nil;
    
}

/**
 * @brief 将指定的对象插入数据库的表中.
 *
 * @param  objc 需要插入到表中的对象.
 *
 */
- (void)yt_insertObject:(id)objc{

    [self creatTableWithClass:[objc class]];
    
    const char * tableName = class_getName([objc class]);
    NSArray * propertyNames = [self yt_getAllPropertyNameWithClass:[objc class]];
    
    NSMutableString * mKeyStr = [NSMutableString new];
    NSMutableString * mValueStr = [NSMutableString new];
    
    int i = 0;
    NSLog(@"%@",propertyNames);
    for (NSString * name in propertyNames) {
        
        id value = [objc valueForKey:name];
        NSString * valueStr = [NSString stringWithFormat:@"'%@'",value];
        
        if (i == propertyNames.count-1) {
            
            [mKeyStr appendString:name];
            [mValueStr appendString:valueStr];
        }else{
        
            [mKeyStr appendFormat:@"%@,",name];
            [mValueStr appendFormat:@"%@,",valueStr];
        }
        
        
        i += 1;
    }//for循环结束
    
    NSString * sqlStr = [NSString stringWithFormat:@"INSERT INTO t_%s(%@) VALUES (%@);",tableName,mKeyStr,mValueStr];
    
    if ([self.db executeUpdate:sqlStr]) {
        
        NSLog(@"数据插入成功");
    }else{
    
        NSLog(@"数据插入失败");
    }
    
}

/**
 * @brief 删除指定表中指定数据.
 *
 * @param  key 字段名.
 * @param  value 需要删除的字段对应的条件值.
 * @param  tclass 表对应的类.
 *
 * @return 返回value.
 */
- (void)yt_deleteDataWithKey:(NSString*)key value:(id)value tClass:(Class)tclass{

    const char * className = class_getName(tclass);
    
    NSString * sqlStr = [[NSString alloc] initWithFormat:@"DELETE FROM t_%s WHERE %@ = '%@';",className,key,value];
    
    if ([self.db executeUpdate:sqlStr]) {
        
        NSLog(@"删除成功");
    }else{
    
        NSLog(@"删除失败");
    }
    
}

@end
