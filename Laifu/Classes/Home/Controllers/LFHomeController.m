//
//  LFHomeController.m
//  Laifu
//
//  Created by 闫青松 on 13-7-22.
//  Copyright (c) 2013年 于龙. All rights reserved.
//

#import "LFHomeController.h"
#import "DMCustomModalViewController.h"
#import "LFAddTravelController.h"

@interface LFHomeController () <DMCustomViewControllerDelegate>

@property (nonatomic, retain) UITableView    *tableView;
@property (nonatomic, retain) NSMutableArray *activitesArray;
@property (nonatomic, retain) NSArray        *randomColorArray;
@property (nonatomic, retain) LFHomeTopView  *topView;

@property (nonatomic, strong) DMCustomModalViewController *modal;

- (void)clickedButton:(UIButton *)sender;

@end

@implementation LFHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.activitesArray = [NSMutableArray array];
    self.randomColorArray = @[@"#33b5b7",@"#8e57aa",@"#ef3c26",@"#f26c23",@"#fdba2d"];
    
    for (NSInteger i = 0; i < 40; i++) {
        LFActivity *activity = [[LFActivity alloc] init];
        activity.imageURL =  @"http://c.hiphotos.bdimg.com/album/w%3D2048/sign=af68f9174610b912bfc1f1fef7c5fd03/d043ad4bd11373f0e07bd133a50f4bfbfaed04d1.jpg";
        activity.title = [NSString stringWithFormat:@"来福来福来福来福来福来福来福来福来福%d",i * 1000];
        activity.memberCount = i * 2000;
        activity.travelCount = i * 3000;
        activity.randomColor = self.randomColorArray[i % self.randomColorArray.count];
        [self.activitesArray addObject:activity];
        [activity release];
    }
    
    [self setupUI];
    
    
    
    LFAddTravelController *root = [[LFAddTravelController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:root];
    _modal = [[DMCustomModalViewController alloc] initWithRootViewController:navController
                                                        parentViewController:[AppDelegate sharedAppDelegate].tabBarController];
    [_modal setParentViewScaling:0.95];
    [_modal setRootViewControllerHeight:self.view.frame.size.height - 368.0f/2.0f];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.activitesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    LFActivityCell *cell = (LFActivityCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[LFActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.activity = [self.activitesArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 268 / 2.0f;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *controller = [[UIViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
    [AppDelegate hidesTabBar:YES animated:YES];
    
}

#pragma mark - Private

- (void)clickedButton:(UIButton *)sender {
    switch (sender.tag) {
        case kShowGuidTag:
        {
            NSLog(@"Show Guide");
        }
            break;
        case kPublishTag:
        {
            [self.modal setDelegate:self];
            [self.modal presentRootViewControllerWithPresentationStyle:DMCustomModalViewControllerPresentPartScreen
                                                  controllercompletion:^{
                                                      
                                                  }];
            NSLog(@"Add");
        }
            break;
        default:
            break;
    }
}

- (LFHomeTopView *)topView {
    if (_topView == nil) {
        _topView = [[LFHomeTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 88.0f / 2.0f)];
    }
    return _topView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44.0, self.view.frame.size.width, self.view.frame.size.height - 44.0f - 44.0f - 49.0f)];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        _tableView = tableView;
        [tableView release];
    }
    return _tableView;
}

- (void)setupUI {
    LFTitleView *titleView = [[LFTitleView alloc] initWithFrame:CGRectMake(0, 0, 100, 44.0f)];
    titleView.title = NSLocalizedString(@"来福", @"");
    self.navigationItem.titleView = titleView;
    [titleView release];
    
    UIImage *leftImage = [UIImage imageNamed:@"lc_btn.png"];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:leftImage forState:UIControlStateNormal];
    [leftButton setFrame:CGRectMake(0, 0, leftImage.size.width, leftImage.size.height)];
    [leftButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTag:kShowGuidTag];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"cj_btn.png"] forState:UIControlStateNormal];
    [rightButton setFrame:CGRectMake(0, 0, leftImage.size.width, leftImage.size.height)];
    [rightButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTag:kPublishTag];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
    
    self.navigationController.navigationBar.tintColor = [UIColor hexStringToColor:@"#fafafa" alpha:0.97];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = [UIColor hexStringToColor:@"#f9f9f9" alpha:1.0f];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

@end
