# -runTime-
特点:外部使用当前数据库管理类进行数据的增删改查操作的时候，不需要写sql语句。当前管理类可以通过runTime相关方法，自动的创建表和对表进行查询 

使用说明:
1.因为当前工具类是使用runTime的相关方法对FMDB进行的再次封装,FMDB实质是对iOS中的sqlite3进行的封装，所以在使用的时候工程中必须导入库文件:libsqlite3.tbd
