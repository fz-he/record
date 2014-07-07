# 公司技术架构
### 最快速开发项目方法论
## 服务器相关
    基础环境搭建
    Centos
## 组织结构
	Php Zf2结构
	Js  _cjs结构，后续可能迁移到seajs
## 建模相关
    [概念上应该一致](modle/)
    团队有通用的语言

## 代码相关
	基于psr0-3的代码命名及编写方式。
	如何编码：
    分析，抽象出数据结构。
    用自然语言的写出限制条件，归纳限制条件，将其转化为函数，置入合适的数据结构中。
    分析动作（交互），转化为函数，置入合适的数据结构。
		简化。
		编写测试。
		编码。
		Ajax建立统一的错误处理及数据返回标准。
		增删改查 一次处理的情况 多次处理情况 直接刷新情况  参数存在与否
## 模块化
	借用composer来管理项目依赖。
		用于不可改变的库，这些库包括第三方与公司。
	Git submodule 来进行公司级别公共库管理。 
		用于还在开发，并不是完全稳定的库。
	Js项目拆分成不同的区域块，用对象形式调用init方法（通用的方法如何处理）。
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
