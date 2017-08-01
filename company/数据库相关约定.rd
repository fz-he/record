1 表
表名、列名必须有注释。
命名应使用富有意义的英文词汇或者缩写，多个单词组成的，以"_"分隔开来，只能使用英文字母，数字和下划线，不留空格
命名长度不超过15个字符为宜（避免超过20），应该反映数据集所在的业务范围，或者业务功能
在设计时候一般包含日期字段：created_at(创建日期)，updated_at(更新日期)等,目前统一用时间戳。
主键字段一般必须包含，id用bigint，如果create语句中有AUTO_INCREMENT=6653864标示，去掉。
字段一般不允许为null,尽可能的把字段定义为 not null,设默认值。
默认字符编码为utf8，无特殊情况存储引擎为INNODB.
数据评估一般不允许物理删除，可设置软删除字段。
外键一般不允许设置物理，均使用逻辑外键。
非空约束尽量加。
基本表及其字段之间的关系, 应尽量满足第三范式，但是往往不是最好的设计。为了提高数据库的运行效率，允许需要降低范式标准：适当增加冗余，达到以空间换时间的目的。
目前并不提倡自己建立物理/逻辑视图，不允许使用触发器,存储过程，统一用业务代码实现。
三少原则： 1 一个数据库中表的个数越少越好。 2 一个表中组合主键的字段个数越少越好。3 一个表中的字段个数越少越好。
2 sql
尽量使用单表查询，避免多表JOIN。
如果必须要连表,对多表之间的连接必须用索引来作为连接列，否则这样的查询就是一个全表扫描，两边的关联字段一定要类型一致（不一致在一边加上类型转换的函数），避免强制转换。
写到应用程序的SQL语句，禁止一切DDL操作，例如：create,drop,alter,grant,remove
尽量不写select *类似的代码，需要制定的字段名。
不要在Where 字句中对列使用函数，那样会导致索引失效.
使用like 语句时，对 “C%”是能利用索引的，但对 “%C”是无效的。而且在前面这个固定字符串越多时效率越好，也就尽量多匹配。
少用 or ，它很可能会使一个查询索引失效，必要时可以用 union all 或者 union 来替代。
尽量保证事务不要过大，小事务发生锁冲突的几率较小。
update语句的条件一定要加上索引，最好是主键或者唯一键，

3 索引
复合索引最左匹配原则，mysql会一直向右匹配直到遇到范围查询(>、<、between、like)就停止匹配.比如a = 1 and b = 2 and c > 3 and d = 4 如果建立(a,b,c,d)顺序的索引，d是用不到索引的，如果建立(a,b,d,c)的索引则都可以用到，a,b,d的顺序可以任意调整。
=和in可以乱序，比如a = 1 and b = 2 and c = 3 建立(a,b,c)索引可以任意顺序，mysql的查询优化器会帮你优化成索引可以识别的形式.
尽量选择区分度高的列作为索引,区分度的公式是count(distinct col)/count(*)，表示字段不重复的比例，比例越大我们扫描的记录数越少.
索引列不能参与计算，保持列“干净”，比如from_unixtime(create_time) = ’2014-05-29’就不能使用到索引
尽量的扩展索引，不要新建索引。比如表中已经有a的索引，现在要加(a,b)的索引，那么只需要修改原来的索引即可
ORDER BY子句，尽量使用Index方式排序,避免使用FileSort方式排序
ORDER BY满足以下情况，会使用Index方式排序:
a)ORDER BY 语句使用索引最左前列。
b)使用Where子句与Order BY子句条件列组合满足索引最左前列。
explain神器 http://dev.mysql.com/doc/refman/5.5/en/explain-output.html


4 ORM（AR）
@orm使用说明


ORM使用说明
1、开始使用
在dao创建一个继承Dao_ActiveRecordModel的类，即可使用ORM功能。
<?php

/**
 * @project MARKET-H5
 * @author Huaxu Chen <czwls@qq.com>
 * @datetime 2016-05-17 23:54
 */
class Dao_User extends Dao_ActiveRecordModel
{
    /**
     * 表名
     * @var string
     */
    public $tablename = 'users';

    /**
     * 主键, 默认为id
     * @var string
     */
    public $pk = 'id';

    /**
     * 字段重定义, 默认为[]
     * @var array
     */
    public $fields = [];
}
2、创建记录
使用insert()或者save()创建记录
php $model = Model::find(); $model->username = '阿旭'; $model->cellphone = '18611006880'; $model->insert(); //or save()
- 使用create()创建记录
php $attribute = [ 'username' => '阿旭', 'cellphone' => '18611006880' ]; Model::create($attributes);
3、查询记录
使用findOne()查询一条记录
php $id = 1; $model = Model::findOne($id);
使用findAll()查询多条记录
 $ids = [1, 2, 3];
 $model = Model::findAll($ids);

 ```

 - 使用`find()`和`one()`查询一条记录

 ```php
 $id = 1;
 $model = Model::find() ->where('id', $id)->one();
使用find()和all()查询多条记录
 $ids = [1, 2, 3];
 $model = Model::find()->where('id', $ids)->all();

 ```

 - 更多`where()`、`orWhere()`、`whereBySql()`的用法

 ```php
  //以数组组合查询条件
  $conds = [
  	'id' => 1,
  	'username' => '阿旭'
  ];
  $model = Model::find()->where($conds)->all();

  //指定操作符
  $model = Model::find()->where('id', 1, '>')->all();

  //链式条件追加
  $model = Model::find()
  			->where('id', 1)
  			->where('username', '阿旭')
  			->where('cellphone', '18611006880')
  			->orWhere('utype', 1)
  			->all();


  //直接使用sql查询
  $sql = 'id = :id and username = :username';
  $binds = [
  	':id' => 1,
  	':username' => '阿旭'
  ];
  $model = Model::find()->whereBySql($sql,  $binds)->all();
分页查询
php $page = 1; //页码 $pageSize = 20; //每页数量 $model = Model::find()->page($page, $pageSize)->all();
查询范围
//等同于 limit 0,20
$model = Model::find()->offset(0)->limit(20)->all();

 ```

- 聚合查询

$model = Model::find()->where(‘id’, 1);
$count = $model->count(‘id’);
$max = $model->max();
$min = $model->min();
$avg = $model->avg();

- 使用`orderBy()`排序

$model = Model::find()
->where(’utype, 1)
->orderBy(‘create_at’, ‘DSC’)
->orderBy(‘id ASC’)
->all();
```
使用groupBy()分组
$model = Model::find()->groupBy('utype')->all();
使用field()返回指定字段
$model = Model::find()
			->field('id')
			->field(['username', 'cellphone'])
			->all();
4、更新记录
更新一条记录
php $model = Model::findOne(1); $model->username = '阿旭test'; $model->cellphone = '15001023577'; $model->update(); //或者使用save()
批量设置属性
$model = Model::findOne(1);
$attributes = ['username' => '阿旭test', 'cellphone' => '15001023588'];
$model->setAttributes($attributes);
$model->save();
更新多条记录
php Model::updateAll(['id' => 1]);
5、删除记录
删除一条记录
 $model = Model::findOne(1);
 $model->delete();
删除多条记录
Model::deleteAll(['id' => 1]);
6、其他操作
使用asArray()直接返回数组
 $id = 1;
 $model = Model::find()->where('id', 1)->asArray()->one();
使用toArray()将查询结果转化为数组
php $id = 1; $model = Model::findOne($id)->toArray();
使用toJson()将查询结果转化为json
php $id = 1; $model = Model::findOne($id)->toJson();