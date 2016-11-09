//
//  ViewController.m
//  YTDataBaseManagerDemo
//
//  Created by 余婷 on 16/11/9.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Dog.h"
#import "YTDataBaseManager/YTDataBaseManager.h"
#import "ShowDataViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *personInfo;
@property (weak, nonatomic) IBOutlet UILabel *dogInfo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //删除测试
    [[YTDataBaseManager defaultManager] yt_deleteDataWithKey:@"name" value:@"Person_Q" tClass:[Person class]];
}

- (IBAction)makePerson:(id)sender {
    
    Person * p = [Person new];
    p.name = [NSString stringWithFormat:@"Person_%c",'A'+arc4random()%26];
    p.age = arc4random()%20+10;
    self.personInfo.text = [NSString stringWithFormat:@"名字:%@,年龄:%d",p.name,p.age];
    [[YTDataBaseManager defaultManager] yt_insertObject:p];
}
- (IBAction)makeDog:(id)sender {
    
    Dog * dog = [Dog new];
    dog.name = [NSString stringWithFormat:@"Dog_%c",'a'+arc4random()%26];
    dog.type = [NSString stringWithFormat:@"type_%c",'a'+arc4random()%26];
    dog.color = [NSString stringWithFormat:@"color_%c",'a'+arc4random()%26];
    self.dogInfo.text = [NSString stringWithFormat:@"name:%@,type:%@,color:%@",dog.name,dog.type,dog.color];
    [[YTDataBaseManager defaultManager] yt_insertObject:dog];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ShowDataViewController * show = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"person"]) {
        
        show.type = @"person";
    }else{
        
        show.type = @"dog";
    }
}


@end
