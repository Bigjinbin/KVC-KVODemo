//
//  ViewController.m
//  KVC-KVODemo
//
//  Created by quiet on 15/7/23.
//  Copyright (c) 2015年 quiet. All rights reserved.
//

#import "ViewController.h"

#import "Car.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //kvc的使用
    [self useKVC];
    
    //kvo的使用
    [self useKVO];
    
    //归档的使用
    [self dataArchiver];
    
    //设计模式
    [self designPattern];
}
-(void)designPattern
{
    //1. 介绍设计模式
    //说明: 是一套被反复使用, 多数人知晓的, 经过分类编目的, 代码设计经验的总结
    //目的:  (1)让代码具备更高的重用性
    //      (2)让代码更容易被人理解
    //      (3)让代码可靠性更高
    
    //特点: 具备学习门槛
    //推荐:
    //  Objective-C编程之道:iOS设计模式解析(架构师必备)
    //  大化设计模式
    //  设计模式之禅
    
    //4个大牛: Gof软件设计模式4人帮,  可复用软件的设计模式
    //  23种设计模式
    
    
    //2. iOS中常见的设计模式
    
    //(1)MVC设计模式
    //  View 视图             只负责数据的显示和用户交互
    //  Controller 控制器      <1>从model中拿出数据显示到view
    //                        <2>根据view事件修改数据
    //  Model 模型            负责数据的表示和存储
    
    //(2)target-action 目标-命令
    //[button addTarget:action:state];
    
    //(3)代理/委托
    //需求:   一个对象不方便或不能处理一个事件, 交给另外一个对象处理
    //一个控件上可能都多个事件会发生, 多个事件发生了通知当前控制器处理, 实现实现目的, 需要把视图控制器指针存入到控件中
    
    //(4)单例
    //系统有一个类任何时候只需要创建一个对象, 使用单例设计模式
    //  实例:
    //      NSFileManager
    //      NSUserDefaults
    //      NSNotificationCenter
    //      UIApplication
    //
    
    //(5)监察者
    //  OC中实现了语言级别的监察者模式,KVO
    //  一旦检测的某个状态的的变化, 立即通知进行处理
    
    //(6)工厂模式/抽象工厂模式
    //工厂模式
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    NSLog(@"class = %@",[button class]);
    
    //抽象工厂
    NSString *str = [[NSString alloc] initWithUTF8String:"test"];
    // str class = __NSCFString
    NSLog(@"str class = %@",[str class]);
    
    
}
-(void)dataArchiver
{
    //数据持久化存储
    //注意: 内存中的程序运行存在, 程序关闭之后没有了
    //  需求: 有些数据需要保存到磁盘上, 下次程序启动使用这些数据
    
    //数据持久化方式
    //1.NSFileManager,  文件  缓存
    // 例如: 缓存数据, 歌曲, 视频
    
    //2.NSUserDefaults      用户默认选项
    //  用户数据:   登陆界面用户名和密码
    
    //3.NSKeyedArchiver     归档
    //  保存对象 --- 保存少量对量(100个以下)
    
    //4.sqlite数据库         数据库
    //  保存各种数据 --- 保存对象, 创建数据库和表, 转化为记录
    //  保存大量数据, 100M, 200M
  
    //5.plist文件
    //  保存程序配置, 用户配置
    
    //6.CodeData
    //  封装了sqlite
    
    
    
    //归档
    //作用: 把一个对象或多个对象保存到文件中
    Car *newCar = [[Car alloc] init];
    newCar.type = @"DongFeng";
    newCar.speed = 200;
    Engine *engine = [[Engine alloc] init];
    engine.power = 350;
    newCar.engine = engine;
    
    //需求1: 保存到文件中
    NSString *path = [NSString stringWithFormat:@"%@/Documents/car.data",NSHomeDirectory()];
    [NSKeyedArchiver archiveRootObject:newCar toFile:path];
    
    //需求2: 下次程序启动了再从文件中读取进来
    Car *readCar = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"type = %@,speed = %f power=%f",readCar.type,readCar.speed,newCar.engine.power);
    
    
    
}

-(void)useKVO
{
    //KVO的使用
    
    //1.什么是KVO, KVO的作用
    //  Key Value Observing 的简写
    //  键值监听
    //  作用: 监听某个对象中某个属性是否改变了
    
    //2.KVO的基本语法
    Car *car = [[Car alloc] init];
    
    //使用KVO监控car中speed
    //作用: 当car中的属性speed变化的时候执行self指定的方法
    [car addObserver:self forKeyPath:@"speed" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    
    //模拟启动过程
    car.speed = 0;
    
    car.speed = 10;
    
    car.speed = 100;
    
    car.speed = 200;
    car.speed = 200;
    
    //对象释放了, 移除监听
    [car removeObserver:self forKeyPath:@"speed"];
}
//注意: 当KVO监控的属性改变的时候执行
//参数1: 那个属性改变了
//参数2: 哪个对象的属性改变了
//参数3: 发生了什么样的变化
//参数4: 上下文
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    double speed = [[object valueForKeyPath:keyPath] doubleValue];
    NSLog(@"速度变了 speed = %f",speed);
}

-(void)useKVC
{
    //KVC的使用
    //1. 什么是KVC, 项目中用在哪儿?
    //  Key Value Coding 键值编码
    //  (1)利用kvc通过字符串作为key访问属性
    //  (2)很方便的把字典转化为model
    
    //2. KVC基本用法
    Car *car = [[Car alloc] init];
    car.type = @"BMW";
    car.speed = 200;
    NSLog(@"type = %@,speed=%f",car
          .type,car
          .speed);
    
    //设置 setValue:forKey:
    [car setValue:@"Mini" forKey:@"type"];
    NSLog(@"type = %@",[car valueForKey:@"type"]);
    
    //注意事项
    //问题: 假设key不存在呢?
    [car setValue:@"Mini" forKey:@"unknown"];
    
    
    //3. KeyPath的用法
    Engine *engine = [[Engine alloc] init];
    engine.power = 10000;
    car.engine = engine;
    
    //需求: 通过kvc访问car的属性engine的属性power
    [car setValue:@(9999) forKeyPath:@"engine.power"];
    double power = [[car valueForKeyPath:@"engine.power"] doubleValue];
    NSLog(@"power = %f",power);
    
    
    
    //4. 字典转model常用方法 99%
    //  XML1, JSON49
    NSDictionary *carDict = @{@"type":@"QQ",@"speed":@(250)};
    Car *carModel = [[Car alloc] init];
    [carModel setValuesForKeysWithDictionary:carDict];
    NSLog(@"type = %@, speed=%f",carModel.type,carModel.speed);
    //carModel.type = carDict[@"type"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
