# 关于API层与DDD层的协作问题.md

API层相当于DDD层的消费方

Command本身可能需要各种Value Object

那么这些ValueObject初始化过程 放到哪里处理会比较好

有一些ValueObject对其他的Model有依赖 如 Order>Items 对SKU有依赖 那么这些依赖关系
放到哪里？

## ValueOject的初始化位置问题

放到API层 比较灵活 由API来决定外界字段的含义 可以自由的更改