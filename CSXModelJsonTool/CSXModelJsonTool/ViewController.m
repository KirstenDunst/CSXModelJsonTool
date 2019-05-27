//
//  ViewController.m
//  CSXModelJsonTool
//
//  Created by 曹世鑫 on 2019/5/27.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "ViewController.h"
#import "CSXModelJSON.h"
#import "CSXObjectJsonTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType: UIButtonTypeSystem];
    [btn setTitle:@"名字" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dealThe:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(50, 100, 80, 50);
    [self.view addSubview:btn];
    
}

- (void)dealThe:(UIButton *)sender {
    CSXModelJSON *model = [[CSXModelJSON alloc]init];
    model.nameStr = @"曹世鑫";
    model.age = 28;
    
    NSDictionary *askDic = [CSXObjectJsonTool getObjectData:model];
    NSLog(@">>>>>>%@",askDic);
    
    NSData *askData = [CSXObjectJsonTool getJSON:model options:NSJSONWritingPrettyPrinted error:nil];
    NSLog(@">>>>>>%@",askData);
    
    [CSXObjectJsonTool print:model];
}

@end
