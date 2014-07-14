# 公司技术架构实践（lamp架构）

## 环境
    操作系统： Centos
    lamp
    如何在新人进入公司后，能够快速的搭建好一套完整的环境
    如果要升级，怎么给大家一次升级

## 建模相关
    [概念上应该一致](model)
    团队有通用的语言

## 编程框架的选择
    事务脚本，表模块，领域模型

## 代码实践
    ### 编码
        #### 风格及实践
        基于psr0-3的代码命名及编写方式
        [如何编码](code/HowToCoding.md)
        #### php
        包管理工具composer 
        基于composer的公司目录结构及开发技巧
        #### js
        #### css
	    如何编码：
        
        用自然语言的写出限制条件，归纳限制条件，将其转化为函数，置入合适的数据结构中。
        分析动作（交互），转化为函数，置入合适的数据结构。
		简化。
		编写测试。
		编码。
		Ajax建立统一的错误处理及数据返回标准。
		增删改查 一次处理的情况 多次处理情况 直接刷新情况  参数存在与否

## 模块化
    ### php
    	1）基于composer来管理项目依赖。
		2）Git submodule 来进行公司级别公共库管理。 
        3）用于不可改变的库，这些库包括第三方与公司。
	### javascript
    	1）bower管理
        2）基于CMD或AMD
    ### css
        
## 模块复用
	Zf2 module系统。
	自有的php库。
## 部署
	Nodejs 开发的脚本包
## 开发者工具
	Redmine，bugzilla。
	如果有二者的结合体更佳。
	用wiki编写文档
## 测试
	travis-ci.org 自动化跑脚本
    单元测试
    自动化测试
## use case
    新建Scheduling项目
        初始化
            利用composer 安装 zf2 2.*版本。
            建立文件夹public/css,js.img。
            使用git submodule 加入 _cjs > public/js/_cjs, _zfCommon > vendor/Common。
            .gitignore略过 vendor, public/_cjs
    加入.travis.yml用来触发自动化测试
        待试验的
            自己的common如何与别人的common共存。
            使用别人的zf2 module
