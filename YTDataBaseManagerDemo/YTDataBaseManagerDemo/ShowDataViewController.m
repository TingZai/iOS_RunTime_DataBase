//
//  ShowDataViewController.m
//  YTDataBaseManagerDemo
//
//  Created by 余婷 on 16/11/9.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "ShowDataViewController.h"
#import "YTDataBaseManager/YTDataBaseManager.h"
#import "Person.h"
#import "Dog.h"

@interface ShowDataViewController ()<UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation ShowDataViewController

- (NSMutableArray *)dataArray{

    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray new];
    }
    
    return  _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.type isEqual: @"person"]) {
        
        NSArray * persons = [[YTDataBaseManager defaultManager] yt_getAlldataWithClass:[Person class]];
        
        [self.dataArray addObjectsFromArray:persons];
        
    }else{
        
        NSArray * dogs = [[YTDataBaseManager defaultManager] yt_getAlldataWithClass:[Dog class]];
        
        [self.dataArray addObjectsFromArray:dogs];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    if ([self.type  isEqual: @"person"]) {
        
        Person * p = self.dataArray[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"名字:%@",p.name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"年龄:%d",p.age];
        
    }else{
    
        Dog * d = self.dataArray[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"名字:%@",d.name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"类型:%@",d.type];
    }
    return cell;
}



@end
