系统用途及目的
监控业务系统，发现问题报警。
已经上线的是商品和优惠卷的监控。
系统功能及用法
模式是定时验证配置的监控是否符合预期，目前支持每个配置项自定义每天一次或者每多久一次。
目前支持三种方式监控
定时执行脚本，获取输出，不符合预期，报警。（目前都是这种）
定时执行sql，获取数据，不符合预期，报警。
定时执行rest api,获取数据，不符合预期，报警。

目前支持两种方式监控
邮件
短信

 系统关键配置实例(yaml语法)
以脚本的配置为例
id : 3     #标识
cmd : '/home/work/web/market-console/yg monitor/item/checkitemonsale'  #脚本
time_mode: 2   #运行方式 1 每天 2每秒
cycle: 900        #每多少秒一次
alarm_times: 10 同一个错误返回，最多报警次数,0表示无限报警，默认0。
alarm_mode :   #报警方式，支持2种 邮件,短信
- 'mail'
- 'sms'
mail_receivers :  #邮件收件人
- yangshuai@lsh123.com
- wulin@lsh123.com
- fuluxing@lsh123.com
sms_receivers :  #短信收件人
- 13007128937
- 18701496016
- 18500557561

day_sms_limt: 10 每日短信限额（最多发10组报警短信,防止半夜出问题发到天亮）