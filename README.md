# -runTime-
特点:外部使用当前数据库管理类进行数据的增删改查操作的时候，不需要写sql语句，也不需要为每个数据模型都封装一套数据库操作方法。当前管理类可以通过runTime相关方法，在运行时自动的根据操作的数据类型创建表和对表进行查询

使用说明:
1.将YTDataBaseManager文件夹的内容全部拖到工程中，使用的时候只需要导入YTDataBaseManager.h文件即可。
2.因为当前工具类是使用runTime的相关方法对FMDB进行的再次封装,FMDB实质是对iOS中的sqlite3进行的封装，所以在使用的时候工程中必须导入库文件:libsqlite3.tbd

方法:
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

