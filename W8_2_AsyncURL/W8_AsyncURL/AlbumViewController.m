//
//  ViewController.m
//  MidTerm
//
//  Created by 김성희 on 2015. 4. 17..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import "AlbumViewController.h"
#import "AlbumCell.h"
#import "PhotoViewController.h"

@implementation AlbumViewController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    // init the data model
    _itemList = [[PhotoModel alloc] init];
    [self makeSectionWithAction:@"init"];

    // add sort button in in the upper right hand corner
    UIBarButtonItem *sortButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize
                                                                                target:self
                                                                                action:@selector(sortByDate)];
    self.navigationItem.rightBarButtonItem = sortButton;

    // cann't select more than one cell simultaneously
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
   
    // register a notification observer
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(reloadTableView:) name:@"refresh" object:nil];
    [notiCenter addObserver:self selector:@selector(loadImage:) name:@"loadImage" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [_itemList restore];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [_sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSDictionary *sectionItem = [_sections objectAtIndex:(int)section];
    NSNumber *sectionCount = [sectionItem objectForKey:@"count"];
   
    return [sectionCount integerValue];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // show section header only sorted
    if ([_mode isEqualToString:@"sort"]) {
        NSDictionary *sectionItem = [_sections objectAtIndex:(int)section];
        NSString *sectionTitle = [sectionItem objectForKey:@"year"];
        
        return sectionTitle;
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *tableId = @"Cell";
    
    AlbumCell *cell = (AlbumCell *)[tableView dequeueReusableCellWithIdentifier:tableId];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:tableId owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *item = [self itemForRowAtIndexPath:(NSIndexPath *)indexPath];
    
    cell.subjectLabel.text = [item objectForKey:@"title"];
    cell.dateLabel.text = (NSString *)[item objectForKey:@"date"];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[item objectForKey:@"imageData"]];
    
    return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *item = [self itemForRowAtIndexPath:(NSIndexPath *)indexPath];
        
        PhotoViewController *detailView = segue.destinationViewController;
        [detailView setDataWithItem:item];
    }
}

#pragma mark - Row Edit
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *item = [self itemForRowAtIndexPath:(NSIndexPath *)indexPath];
    
    [_itemList deleteWithItem:item];
}

#pragma mark - Observer & (Button) Action
- (void)reloadTableView:(NSNotification *)noti {
    NSDictionary *notiDic = [noti userInfo];
    NSString *newMode = [notiDic objectForKey:@"mode"];

    if ([newMode isEqualToString:@"sort"] || [newMode isEqualToString:@"reset"]) {
        _mode = newMode;
    }
    
    [self makeSectionWithAction:_mode];
    [self.tableView reloadData];
}

- (void)loadImage:(NSNotification *)noti {
    [self.tableView reloadData];
}

- (void)sortByDate {
    [_itemList sort];
}

#pragma mark - Internal methods
// make multi section data by year
- (void)makeSectionWithAction:(NSString *)action {
    _sections = [[NSMutableArray alloc] init];
    NSDictionary *section;
    NSNumber *count;
    
    if ([action isEqualToString:@"sort"]) {
        NSMutableDictionary *yearDic = [[NSMutableDictionary alloc] init];
        
        for (NSDictionary *item in _itemList.list) {
            NSString *year = [[item objectForKey:@"date"] substringToIndex:4];

            NSInteger number = [[yearDic objectForKey:year] integerValue] + 1;
            [yearDic setObject:[NSNumber numberWithInteger:number] forKey:year];
        }
        
        NSArray *sortYears = [[yearDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
        for (NSString *year in sortYears) {
            count = [yearDic objectForKey:year];
       
            section = [[NSDictionary alloc] initWithObjectsAndKeys:year, @"year", count, @"count", nil];
            [_sections addObject:section];
        }
    }
    else {
        count = [NSNumber numberWithInteger:[_itemList.list count]];
        section = [[NSDictionary alloc] initWithObjectsAndKeys:@"ALL", @"year", count, @"count", nil];

        [_sections addObject:section];
    }
}

- (NSDictionary *)itemForRowAtIndexPath:(NSIndexPath *)indexPath {
    int total = 0;
    
    for (int i = 0; i < indexPath.section; i++) {
        NSDictionary *sectionItem = [_sections objectAtIndex:(int)i];
        NSNumber *sectionCount = [sectionItem objectForKey:@"count"];
        
        total += [sectionCount intValue];
    }
    
   return [_itemList.list objectAtIndex:(total + indexPath.row)];
}

@end