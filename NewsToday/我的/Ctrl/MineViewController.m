
//
//  MineViewController.m
//  NewsToday
//
//  Created by Mr_Jia on 2017/4/14.
//  Copyright © 2017年 Mr_Jia. All rights reserved.
//

#import "MineViewController.h"
#import <IQKeyboardManager.h>
#import <CoreText/CoreText.h>
#import <PYSearch.h>
#import <YYKit.h>
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)NSMutableArray *sectionArray;
@property (nonatomic,strong)NSMutableArray *flagArray;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrayTitle;
@end

@implementation MineViewController

- (NSArray *)arrayTitle {
    if (!_arrayTitle) {
        
        _arrayTitle = @[@"归档",@"解档",@"1",@"1",@"yycache同步",@"yycache异步",@"1",@"1",@"1",@"1"];
    }
    return _arrayTitle;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];

    
    // 3. present the searchViewController
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
//    [self presentViewController:nav  animated:NO completion:nil];
    
//    [self creatUI];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    self.view.backgroundColor = [UIColor flatGrayColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[YYFPSLabel new]];
    
    [self makeData];
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    

}

/**
 *  处理数据  _sectionArray里面存储数组
 */
- (void)makeData{
    _sectionArray = [NSMutableArray array];
    _flagArray  = [NSMutableArray array];
    NSInteger num = 6;
    for (int i = 0; i < num; i ++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int j = 0; j < arc4random()%20 + 1; j ++) {
            [rowArray addObject:[NSString stringWithFormat:@"%d",j]];
        }
        [_sectionArray addObject:rowArray];
        [_flagArray addObject:@"0"];
    }
}
//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionArray.count;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = _sectionArray[section];
    return arr.count;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_flagArray[indexPath.section] isEqualToString:@"0"])
        return 0;
    else
        return 44;
}
//组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *sectionLabel = [[UILabel alloc] init];
    sectionLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 444);
    sectionLabel.textColor = [UIColor orangeColor];
    sectionLabel.text = [NSString stringWithFormat:@"组%ld",section];
    sectionLabel.textAlignment = NSTextAlignmentCenter;
    sectionLabel.tag = 100 + section;
    sectionLabel.userInteractionEnabled = YES;
    sectionLabel.backgroundColor = [UIColor yellowColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionClick:)];
    [sectionLabel addGestureRecognizer:tap];
    
    return sectionLabel;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    cell.textLabel.text= [NSString stringWithFormat:@"第%ld组的第%ld个cell",indexPath.section,indexPath.row];
    cell.clipsToBounds = YES;//这句话很重要 不信你就试试
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    SectionViewController *sVC = [[SectionViewController alloc] init];
//    sVC.rowLabelText = [NSString stringWithFormat:@"第%d组的第%d个cell",indexPath.section,indexPath.row];
//    [self presentViewController:sVC animated:YES completion:nil];
    NSLog(@"%@",[NSString stringWithFormat:@"第%ld组的第%ld个cell",indexPath.section,indexPath.row]);
}
- (void)sectionClick:(UITapGestureRecognizer *)tap{
    int index = tap.view.tag % 100;
    
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    NSArray *arr = _sectionArray[index];
    for (int i = 0; i < arr.count; i ++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:index];
        [indexArray addObject:path];
    }
    //展开
    if ([_flagArray[index] isEqualToString:@"0"]) {
        _flagArray[index] = @"1";
        [_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationBottom];  //使用下面注释的方法就 注释掉这一句
    } else { //收起
        _flagArray[index] = @"0";
        [_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop]; //使用下面注释的方法就 注释掉这一句
    }
    //    NSRange range = NSMakeRange(index, 1);
    //    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
    //    [_tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (NSAttributedString *)changeAlignmentRightandLeft:(NSString *)text and:(CGRect )frame and:(UIFont *)font{
    
    CGRect textSize = [text boundingRectWithSize:CGSizeMake(frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil];
    
    CGFloat margin = (frame.size.width - textSize.size.width) / (text.length - 1);
    
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeString addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0, text.length - 1)];
     return  attributeString;
    
}

- (void)creatUI {
   
    [self.view addSubview:self.tableView];
    
    
}
#pragma mark lazy loading...
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma tableView--delegate
#pragma tableView


//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.arrayTitle.count;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *identify = @"cellIdentify";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
//    }
//    cell.textLabel.text = self.arrayTitle[indexPath.row];
//    return cell;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (indexPath.row == 0) {
//        //归档
//        NSArray *array = [NSArray arrayWithObjects:@"zhang",@"wangwu",@"lisi",nil];
//        NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/array.src"];
//        
//        BOOL success = [NSKeyedArchiver archiveRootObject:array toFile:filePath];
//        
//        if (success) {
//            JLog(@"归档成功");
//        }else{
//         
//            
//        }
//    }else if (indexPath.row == 1) {
//        //解档
//        
//        NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/array.src"];
//        
//        id array = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//        
//        JLog(@"%@", array);
//        
//        /*
//         content:(
//         zhang,
//         wangwu,
//         lisi
//         )
//         */
//        
//    }else if (indexPath.row == 2){
//        //第二种方式
//        //第一种方式的缺陷是一个对象归档成一个文件
//        //但是第二种方式，多个对象可以归档成一个文件
//        
//        NSArray *array = [NSArray arrayWithObjects:@"zhangsan",@"lisi",@"wangwu", nil];
//        
//        NSMutableData *data = [NSMutableData data];
//        
//        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
//        //编码
//        [archiver encodeObject:array forKey:@"array"];
//        [archiver encodeInt:100 forKey:@"scope"];
//        [archiver encodeObject:@"jack" forKey:@"name"];
//        
//        //完成编码，将上面的归档数据填充到data中，此时data中已经存储了归档对象的数据
//        
//        [archiver finishEncoding];
////        [archiver arcDebugRelease];
//
//        
//        
//        NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data.src"];
//        
//        BOOL success = [data writeToFile:filePath atomically:YES];
//        
//        if (success) {
//            JLog(@"归档成功");
//        }
//        
//    }else if(indexPath.row == 3) {
//        NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"Documents/data.src"];
//        //读取数据
//        NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
//        
//        //创建归档对象，对data中的数据进行解档
//        
//        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
//        
//        NSArray *array = [unarchiver decodeObjectForKey:@"array"];
//        JLog(@"%@",array);
//        id value = [unarchiver decodeObjectForKey:@"scope"];
//        JLog(@"%@",value);
//    }else if(indexPath.row == 4) {
//        [self yyCacheSync];
//    }else if(indexPath.row == 5) {
//        [self yycacheAsync];
//    }else if (indexPath.row == 6) {
//        [self yycacheLRU];
//    }
//    
//    
//}
//YYCache 1.同步方式

- (void)yyCacheSync {
    //模拟数据
    NSString *value = @"I want to know who is jiayuanfang";
    
    //模拟key
    NSString *key = @"jiayuanfang";
    //同步方式
    
    YYCache *cache = [YYCache cacheWithName:@"JCache"];
    //根据key写入缓存value
    [cache setObject:value forKey:key];
    
    //判断缓存是否存在
    BOOL isContains = [cache containsObjectForKey:key];
    
    NSLog(@"containsObject:%@",isContains ? @"YES":@"NO");
    
    
    //根据key读取数据
    
    id newValue = [cache objectForKey:key];
    
    NSLog(@"value -->%@",newValue);
    
    
    //根据key 移除缓存
    [cache removeObjectForKey:key];
    
    //移除所有缓存
    [cache removeAllObjects];
    
    //根据key获取value，为null，说明移除成功
    NSLog(@"value -->%@",[cache objectForKey:key]);

    
}
//2.异步方式
- (void)yycacheAsync {
    
    //模拟数据
    NSString *value = @"I want to know who is jiayuanfang";
    
    //模拟key
    NSString *key = @"jiayuanfang";
    //同步方式
    
    YYCache *cache = [YYCache cacheWithName:@"JCache"];
    
    //根据key写入缓存value
    [cache setObject:value forKey:key withBlock:^{
        NSLog(@"setObject success");
    }];
    
    //判断缓存是否存在
    
    [cache containsObjectForKey:key withBlock:^(NSString * _Nonnull key, BOOL contains) {
        NSLog(@"ContainsObject:%@",contains ? @"YES":@"NO");
    }];
    
    //根据key读取数据
    [cache objectForKey:key withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        NSLog(@"objectForKey:%@",object);
    }];
    
    //根据key移除缓存
    
//    [cache removeObjectForKey:key withBlock:^(NSString * _Nonnull key) {
//        NSLog(@"removeObjectForKey:%@",key);
//    }];
//    
    NSLog(@"--> %@",[cache objectForKey:key]);
    
    //移除所有缓存
//    [cache removeAllObjectsWithBlock:^{
//        NSLog(@"removeAllObjects");
//    }];
    
    //移除所有缓存带进度
    [cache removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
        NSLog(@"removeAllObjects removedCount :%d  totalCount : %d",removedCount,totalCount);
    } endBlock:^(BOOL error) {
        if (error) {
            NSLog(@"移除所有缓存失败");
        }else {
            NSLog(@"成功移除所有缓存");
        }
    }];
}

//YYCache缓存LRU清理

- (void)yycacheLRU {
    YYCache *cache = [YYCache cacheWithName:@"JCache"];
    //内存最大缓存数据个数
    [cache.memoryCache setCountLimit:50];
    //内存最大缓存开销，目前这个没有用
    [cache.memoryCache setCostLimit:1*024];
    //磁盘最大缓存开销
    [cache.diskCache setCostLimit:10 * 1024];
    //磁盘最大缓存数据个数
    [cache.diskCache setCountLimit:50];
    //设置磁盘LRU动态清理频率
    [cache.diskCache setAutoTrimInterval:60];
    
    for (NSInteger i = 0; i < 100; i++) {
        //模拟数据
        NSString *value = @"I want to know who is jiayuanfang";
        
        //模拟key
        NSString *key = [NSString stringWithFormat:@"jiayuanfang%ld",i];

        [cache setObject:value forKey:key];
        
        
    }
    
    NSLog(@"cache.memoryCache.totalCost:%lu",(unsigned long)cache.memoryCache.totalCost);
    NSLog(@"Cache.memoryCache.costLimit:%lu",(unsigned long)cache.memoryCache.costLimit);
    
    NSLog(@"Cache.memoryCache.totalCount:%lu",(unsigned long)cache.memoryCache.totalCount);
    NSLog(@"Cache.memoryCache.countLimit:%lu",(unsigned long)cache.memoryCache.countLimit);


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"yyCache.diskCache.totalCost:%lu",(unsigned long)cache.diskCache.totalCost);
        NSLog(@"yyCache.diskCache.costLimit:%lu",(unsigned long)cache.diskCache.costLimit);
        
        NSLog(@"yyCache.diskCache.totalCount:%lu",(unsigned long)cache.diskCache.totalCount);
        NSLog(@"yyCache.diskCache.countLimit:%lu",(unsigned long)cache.diskCache.countLimit);
        
        for(int i=0 ;i<100;i++){
            //模拟一个key
            NSString *key=[NSString stringWithFormat:@"jiayuanfang%d",i];
            id vuale=[cache objectForKey:key];
            NSLog(@"key ：%@ value : %@",key ,vuale);
        }
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
