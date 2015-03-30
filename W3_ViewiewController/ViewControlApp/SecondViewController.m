//
//  SecondViewController.m
//  ViewControlApp
//
//  Created by 김성희 on 2015. 3. 18..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import "SecondViewController.h"
#import "PersonModel.h"

@implementation SecondViewController

- (IBAction)searchStudent:(id)sender {
    NSLog(@"search %@", _students);
   
    NSString *inputName = [name text];
    NSLog(@"%@", inputName);
    
    NSString *number = [[NSString alloc] initWithFormat:@"%@", [_students findPersonNumberByName:inputName]];
    [searchResult setText:number];

//  crash code -- why?
//    NSNumber *number = [_students findPersonNumberByName:inputName];
//    [searchResult setText:[number stringValue]];
}

// alert code
- (IBAction)showNames:(id)sender {
    NSLog(@"showNames");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"전체 이름"
                                                                   message:[_students personNameAtIndex:1]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"Second.viewDidLog");
    _students = [[PersonModel alloc] initWithFilePath:@"/tmp/students.txt"];
    
    NSLog(@"viewDidLog %@", _students);
/*
        _students = @[
  @{@"name":@"이진우",@"number":@131056},
  @{@"name":@"김창규",@"number":@131020},
  @{@"name":@"박태준",@"number":@141037},
  @{@"name":@"심보희",@"number":@141051},
  @{@"name":@"고형진",@"number":@141004},
  @{@"name":@"조영대",@"number":@141083},
  @{@"name":@"조현호",@"number":@141085},
  @{@"name":@"신윤서",@"number":@141049} ];
*/
    
    [searchResult setText:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
