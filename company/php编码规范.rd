
转至元数据结尾
创建： 杨帅，最新修改于： 十一月 09, 2016 转至元数据起始
1 目的
本篇规范制定了代码基本元素的相关标准， 以确保PHP代码间具有较高程度的技术互通性。
2 通则
PHP代码文件必须以 <?php 标签开始
PHP代码文件必须以 不带BOM的 UTF-8 编码
所有PHP文件必须使用Unix LF (linefeed)作为行的结束符
所有PHP文件必须以一个空白行作为结束。
纯PHP代码文件必须省略最后的 ?> 结束标签。
软性的长度约束一定要限制在120个字符以内，若超过此长度，带代码规范检查的编辑器一定要发出警告，不过一定不可发出错误提示。
每行不应该多于80个字符，大于80字符的行应该折成多行。
非空行后一定不能有多余的空格符。
每行一定不能存在多于一条语句。
代码必须使用4个空格符的缩进，一定不能用 tab键 。(注意vim配置)
（备注: 使用空格而不是tab键缩进的好处在于， 避免在比较代码差异、打补丁、重阅代码以及注释时产生混淆。 并且，使用空格缩进，让对齐变得更方便。）
PHP所有 关键字必须全部小写。常量 true 、false 和 null 也必须全部小写。
PHP代码中应该只定义类、函数、常量等声明，或其他会产生 从属效应 的操作（如：生成文件输出以及修改.ini配置文件等），二者只能选其一
“从属效应”(side effects)一词的意思是，仅仅通过包含文件，不直接声明类、 函数和常量等，而执行的逻辑操作。
“从属效应”包含却不仅限于：生成输出、直接的 require 或 include、连接外部服务、修改 ini 配置、抛出错误或异常、修改全局或静态变量、读或写文件等。
以下是一个错误的例子，一份包含声明以及产生从属效应的代码
<?php
// 从属效应：修改 ini 配置
ini_set('error_reporting', E_ALL);

// 从属效应：引入文件
include "file.php";

// 从属效应：生成输出
echo "<html>\n";

// 声明函数
function foo()
{
    // 函数主体部分
}
下面是一个范例，一份只包含声明不产生从属效应的代码
<?php
// 声明函数
function foo()
{
    // 函数主体部分
}

// 条件声明**不**属于从属效应
if (! function_exists('bar')) {
    function bar()
    {
        // 函数主体部分
    }
}
3 类，属性和方法
类的命名必须 遵循 StudlyCaps 大写开头的驼峰命名规范。（Yaf自动载入有类的命名约定，这个除外）
类中的常量所有字母都必须大写，单词间用下划线分隔
方法名称必须符合 camelCase 式的小写开头驼峰命名规范
    3.1 扩展与继承
关键词 extends 和 implements必须写在类名称的同一行。
类的开始花括号必须独占一行，结束花括号也必须在类主体后独占一行。
<?php

class ClassName extends ClassName implements \ArrayAccess, \Countable
{
    // constants, properties, methods
}
implements 的继承列表也可以分成多行，这样的话，每个继承接口名称都必须分开独立成行，包括第一个。
<?php

class ClassName extends ParentClass implements
    \ArrayAccess,
    \Countable,
    \Serializable
{
    // constants, properties, methods
}
    3.2 属性
每个属性都必须添加访问修饰符。
每条语句一定不可定义超过一个属性。
     3.3方法
所有方法都必须添加访问修饰符。
方法名称后一定不能有空格符，其开始花括号必须独占一行，结束花括号也必须在方法主体后单独成一行。参数左括号后和右括号前一定不能有空格。
一个标准的方法声明可参照以下范例，留意其括号、逗号、空格以及花括号的位置。

<?php
class ClassName
{
    public function fooBarBaz($arg1, &$arg2, $arg3 = [])
    {
        // method body
    }
}
    3.4方法的参数
参数列表中，每个逗号后面必须要有一个空格，而逗号前面一定不能有空格。
有默认值的参数，必须放到参数列表的末尾。
<?php
class ClassName
{
    public function foo($arg1, &$arg2, $arg3 = [])
    {
        // method body
    }
}


参数列表可以分列成多行，这样，包括第一个参数在内的每个参数都必须单独成行。
拆分成多行的参数列表后，结束括号以及方法开始花括号 必须 写在同一行，中间用一个空格分隔。

<?php
class ClassName
{
    public function aVeryLongMethodName(
        ClassTypeHint $arg1,
        &$arg2,
        array $arg3 = []
    ) {
        // method body
    }
}
   3.5 abstract 、 final 、 以及 static
需要添加 abstract 或 final 声明时， 必须写在访问修饰符前，而 static 则必须写在其后。
<?php
abstract class ClassName
{
    protected static $foo;

    abstract protected function zim();

    final public static function bar()
    {
        // method body
    }
}
    3.6 方法及函数调用
方法及函数调用时，方法名或函数名与参数左括号之间一定不能有空格，参数右括号前也 一定不能有空格。每个逗号前一定不能有空格，但其后必须有一个空格。
<?php
bar();
$foo->bar($arg1);
Foo::bar($arg2, $arg3);
参数可以分列成多行，此时包括第一个参数在内的每个参数都必须单独成行。
<?php
$foo->bar(
    $longArgument,
    $longerArgument,
    $muchLongerArgument
);
    3.7 控制结构
控制结构的基本规范如下：
控制结构关键词后必须有一个空格。
左括号 ( 后一定不能有空格。
右括号 ) 前也一定不能有空格。
右括号 ) 与开始花括号 { 间一定有一个空格。
结构体主体一定要有一次缩进。
结束花括号 }一定在结构体主体后单独成行。
if 、 elseif 和 else
标准的 if 结构如下代码所示，留意 括号、空格以及花括号的位置， 注意 else 和 elseif 都与前面的结束花括号在同一行

<?php
if ($expr1) {
    // if body
} elseif ($expr2) {
    // elseif body
} else {
    // else body;
}
应该使用关键词 elseif 代替所有 else if ，以使得所有的控制关键字都像是单独的一个词。
switch 和 case
标准的 switch 结构如下代码所示，留意括号、空格以及花括号的位置。 case 语句必须相对 switch 进行一次缩进，而break 语句以及 case 内的其它语句都 必须 相对 case 进行一次缩进。 如果存在非空的 case 直穿语句，主体里必须有类似 // no break 的注释。

<?php
switch ($expr) {
    case 0:
        echo 'First case, with a break';
        break;
    case 1:
        echo 'Second case, which falls through';
        // no break
    case 2:
    case 3:
    case 4:
        echo 'Third case, return instead of break';
        return;
    default:
        echo 'Default case';
        break;
}

while 和 do while
一个规范的 while 语句应该如下所示，注意其 括号、空格以及花括号的位置。

<?php
while ($expr) {
    // structure body
}
标准的 do while 语句如下所示，同样的，注意其 括号、空格以及花括号的位置。
<?php
do {
    // structure body;
} while ($expr);
for
标准的 for 语句如下所示，注意其 括号、空格以及花括号的位置。

<?php
for ($i = 0; $i < 10; $i++) {
    // for body
}
        foreach
标准的 foreach 语句如下所示，注意其 括号、空格以及花括号的位置。

<?php
foreach ($iterable as $key => $value) {
    // foreach body
}
        try, catch
 标准的 try catch 语句如下所示，注意其 括号、空格以及花括号的位置。
<?php
try {
    // try body
} catch (FirstExceptionType $e) {
    // catch body
} catch (OtherExceptionType $e) {
    // catch body
}
    3.8 闭包
闭包声明时，关键词 function 后以及关键词 use 的前后都必须要有一个空格。
开始花括号必须写在声明的同一行，结束花括号必须紧跟主体结束的下一行。
参数列表和变量列表的左括号后以及右括号前，必须不能有空格。
参数和变量列表中，逗号前必须不能有空格，而逗号后必须要有空格。
闭包中有默认值的参数必须放到列表的后面。
标准的闭包声明语句如下所示，注意其 括号、逗号、空格以及花括号的位置。
<?php
$closureWithArgs = function ($arg1, $arg2) {
    // body
};

$closureWithArgsAndVars = function ($arg1, $arg2) use ($var1, $var2) {
    // body
};
参数列表以及变量列表可以分成多行，这样，包括第一个在内的每个参数或变量都必须单独成行，而列表的右括号与闭包的开始花括号必须放在同一行。
以下几个例子，包含了参数和变量列表被分成多行的多情况。
<?php
$longArgs_noVars = function (
    $longArgument,
    $longerArgument,
    $muchLongerArgument
) {
   // body
};

$noArgs_longVars = function () use (
    $longVar1,
    $longerVar2,
    $muchLongerVar3
) {
   // body
};

$longArgs_longVars = function (
    $longArgument,
    $longerArgument,
    $muchLongerArgument
) use (
    $longVar1,
    $longerVar2,
    $muchLongerVar3
) {
   // body
};

$longArgs_shortVars = function (
    $longArgument,
    $longerArgument,
    $muchLongerArgument
) use ($var1) {
   // body
};

$shortArgs_longVars = function ($arg) use (
    $longVar1,
    $longerVar2,
    $muchLongerVar3
) {
   // body
};
注意，闭包被直接用作函数或方法调用的参数时，以上规则仍然适用。
<?php
$foo->bar(
    $arg1,
    function ($arg2) use ($var1) {
        // body
    },
    $arg3
);
4 注释规范
    4.1 文件头部模板
/**
 * 这是一个什么文件
 *
 * 此文件程序用来做什么的（详细说明，可选。）。
 * @author      ystop<ystop.top@gmail.com>
 * @datetime    2016-07-28 20:00:00
 * @version     0.0.1
 */
    4.2 方法头部注释
/**
 * some_func
 * 函数的含义说明
 *
 * @access public
 * @param mixed $arg1 参数一的说明
 * @param mixed $arg2 参数二的说明
 * @param mixed $mixed 这是一个混合类型
 * @return array
 */
public function thisIsFunction($string, $integer, $mixed)
{
    return [];
}
4.3 程序代码注释
注释的原则是将问题解释清楚，并不是越多越好。
若干语句作为一个逻辑代码块，这个块的注释可以使用/* */方式。
具体到某一个语句的注释，可以使用行尾注释：//
/* 生成配置文件、数据文件。*/

$this->setConfig();
$this->createConfigFile();  //创建配置文件
$this->clearCache();         // 清除缓存文件
$this->createDataFiles();   // 生成数据文件
$this->prepareProxys();
$this->restart();
5 示例代码（贴出来会影响格式，所以看网站吧）
https://github.com/laravel/framework/tree/5.3/src/Illuminate/Queue
6  参考规范
https://github.com/PizzaLiu/PHP-FIG
http://www.php-fig.org/