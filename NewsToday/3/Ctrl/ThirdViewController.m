


//
//  ThirdViewController.m
//  NewsToday
//
//  Created by Mr_Jia on 2017/4/14.
//  Copyright © 2017年 Mr_Jia. All rights reserved.
//

#import "ThirdViewController.h"
#import <FMDB.h>
@interface ThirdViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) FMDatabase *db;
/**
 *  plist对应的字典
 */
@property (nonatomic, strong) NSDictionary* cityNames;
/**
 *  省份
 */
@property (nonatomic, strong) NSArray* provinces;
/**
 *  城市
 */
@property (nonatomic, strong) NSArray* cities;
/**
 *  选中的省份
 */
@property (nonatomic, strong) NSString* selectedProvince;

@property (nonatomic,strong) UIPickerView *pickerView;
@end





@implementation ThirdViewController
@synthesize db;
/**
 *  懒加载plist
 *
 *  @return plist对应的字典
 */
- (NSDictionary*)cityNames
{
    if (_cityNames == nil) {
        
        NSString* path = [[NSBundle mainBundle] pathForResource:@"cityData" ofType:@"plist"];
        
        _cityNames = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    
    return _cityNames;
}

/**
 *  懒加载省份
 *
 *  @return 省份对应的数组
 */
- (NSArray*)provinces
{
    if (_provinces == nil) {
        
        //将省份保存到数组中  但是字典保存的是无序的 所以读出来的省份也是无序的
        _provinces = [self.cityNames allKeys];
    }
    
    return _provinces;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Third";
    self.view.backgroundColor = [UIColor flatWhiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[YYFPSLabel new]];

    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"operDB.sqlite"];
    
    NSLog(@"%@",filename);
    db = [FMDatabase databaseWithPath:filename];
    if ([db open]) {
        NSLog(@"打开operDB成功");
    }else {
        NSLog(@"打开operDB失败");
    }
    self.selectedProvince = self.provinces[0];

    
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 300)];
    
    _pickerView.dataSource = self;
    _pickerView.delegate   = self;
    
    
    [self.view addSubview:_pickerView];
    
    UIButton *donePickerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    donePickerBtn.frame = CGRectMake(0  ,70,100,40);
    donePickerBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [donePickerBtn setTitle:@"确定" forState:UIControlStateNormal];
    [donePickerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [donePickerBtn addTarget:self action:@selector(hideSexPickerView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:donePickerBtn];
    
}

- (NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0) {
        return self.provinces.count;
    }
    else {
        
        self.cities = [self.cityNames valueForKey:self.selectedProvince];
        
        return self.cities.count;
    }
}


- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //第一列返回所有的省份
    if (component == 0) {
        return self.provinces[row];
    }
    else {
        
        self.cities = [self.cityNames valueForKey:self.selectedProvince];
        
        return self.cities[row];
    }
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 2;
}


- (void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        //选中的省份
        self.selectedProvince = self.provinces[row];
        //重新加载第二列的数据
        [pickerView reloadComponent:1];
        //让第二列归位
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}

- (void)hideSexPickerView{
    
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    NSInteger haha = [self.pickerView selectedRowInComponent:1];
    NSString *str = [self.cities objectAtIndex:haha];
    NSLog(@"%@%@",[self.provinces objectAtIndex:row],str);
//    [self.pickerView removeFromSuperview];
    
}- (void)didReceiveMemoryWarning {
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
