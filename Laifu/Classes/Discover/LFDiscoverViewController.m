////  LFDiscoverViewController.m//  Laifu////  Created by 于龙 on 13-7-21.//  Copyright (c) 2013年 于龙. All rights reserved.//#import "LFDiscoverViewController.h"#import "DefineRequestUrl.h"#import "LFRecommendViewController.h"#import "LFNearbyViewController.h"#import "LFSortViewController.h"#import "LFScanningViewController.h"#import "AppDelegate.h"#import "LFGuideView.h"#define screenWidth                  [[UIScreen mainScreen] bounds].size.width  #define screenHeight                 [[UIScreen mainScreen] bounds].size.height #define frame_1                     CGRectMake(7, 4.5, 148, 51)#define frame_2                     CGRectMake(165, 4.5, 148, 51)#define imageViewFrame              CGRectMake(8, 7.5, 36, 36)#define titleFrame                  CGRectMake(50, 7.5, 80, 20)#define amountFrame                 CGRectMake(50, 27.5, 80, 16)@interface LFDiscoverViewController ()@end@implementation LFDiscoverViewController@synthesize searchDisplayController;- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];    if (self) {        // Custom initialization    }    return self;}- (void)viewDidLoad{    [super viewDidLoad];    self.navigationController.navigationBar.tintColor = [UIColor hexStringToColor:@"#fafafa" alpha:0.97];          _array = [[NSArray alloc] initWithObjects:@"11",@"12",@"21",@"22",@"31",@"32",@"41",@"42",@"51",@"52",@"61",@"62", nil];    [self createNavigationBar];    [self createSearchBar];    [self createTableView];    self.view.backgroundColor = kAllBackgroundColor;	// Do any additional setup after loading the view.}- (void)createNavigationBar {        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];    titleView.backgroundColor = [UIColor clearColor];        UIButton *guideBtn = [UIButton buttonWithType:UIButtonTypeCustom];    guideBtn.frame = CGRectMake(10, 7, 30, 30);    [guideBtn setShowsTouchWhenHighlighted:YES];    [guideBtn setBackgroundImage:[UIImage imageNamed:@"lc_btn.png"] forState:UIControlStateNormal];    [guideBtn addTarget:self action:@selector(guideBtnAction:) forControlEvents:UIControlEventTouchUpInside];    [titleView addSubview:guideBtn];        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(115, 7, 80, 29)];    title.backgroundColor = [UIColor clearColor];//    title.font = [UIFont systemFontOfSize:16.0f];    title.textAlignment = UITextAlignmentCenter;    title.text = @"发现";    [titleView addSubview:title];    [title release];        UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];    scanBtn.frame = CGRectMake(225, 7, 75, 29);    [scanBtn setShowsTouchWhenHighlighted:YES];    [scanBtn setTitle:@"扫二维码" forState:UIControlStateNormal];    scanBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];    [scanBtn setBackgroundColor:kScanBtnColor];    [scanBtn.layer setCornerRadius:2.0];    [scanBtn addTarget:self action:@selector(scanBtnClicked:) forControlEvents:UIControlEventTouchUpInside];    [titleView addSubview:scanBtn];    self.navigationItem.titleView = titleView;}    - (void)createSearchBar {        _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];    _searchView.layer.contents = (id)[[UIImage imageNamed:@"search_yd_btn.png"]CGImage];    [self.view addSubview:_searchView];    [_searchView release];        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];    _searchBar.delegate = self;    _searchBar.showsCancelButton = NO;    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;    _searchBar.placeholder = @"Search";    _searchBar.keyboardType = UIKeyboardTypeDefault;    //    [searchBar sizeToFit];    [_searchBar setTintColor:[UIColor clearColor]];    _searchBar.barStyle = UIBarStyleBlackOpaque;        for (UIView *subview in _searchBar.subviews)       {            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])          {                [subview removeFromSuperview];                break;          }       }     [_searchView addSubview:_searchBar];        searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];    [self performSelector:@selector(setSearchDisplayController:) withObject:searchDisplayController];    [searchDisplayController setDelegate:self];    [searchDisplayController setSearchResultsDelegate:self];    [searchDisplayController setSearchResultsDataSource:self];    //    self.filteredListContent = [NSMutableArray arrayWithCapacity:[allCityNames count]];}- (void)createTableView {        UITapGestureRecognizer *ftapGesture = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)]autorelease];     [ftapGesture setNumberOfTapsRequired:1];     UITapGestureRecognizer *ntapGesture = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)]autorelease];     [ntapGesture setNumberOfTapsRequired:1];        UIView *friendView = [[UIView alloc] initWithFrame:CGRectMake(0, _searchView.frame.origin.y+_searchView.frame.size.height, 159.5f, 44)];    friendView.tag = 1000;    friendView.backgroundColor = [UIColor whiteColor];    friendView.userInteractionEnabled = YES;    [friendView addGestureRecognizer:ftapGesture];      [self.view addSubview:friendView];    [friendView release];        UIView *flogoView = [[UIView alloc] initWithFrame:CGRectMake(25, 11, 22, 22)];    flogoView.layer.contents = (id)[[UIImage imageNamed:@"pytj_btn.png"]CGImage];    [friendView addSubview:flogoView];    [flogoView release];        UILabel *ftitle = [[UILabel alloc] initWithFrame:CGRectMake(flogoView.frame.origin.x+flogoView.frame.size.width, flogoView.frame.origin.y, 80, flogoView.frame.size.height)];    ftitle.backgroundColor = [UIColor clearColor];    ftitle.text = @"朋友推荐";    ftitle.textAlignment = UITextAlignmentCenter;    [friendView addSubview:ftitle];    [ftitle release];        _amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(ftitle.frame.origin.x+ftitle.frame.size.width, ftitle.frame.origin.y, 24, 22)];    _amountLabel.textAlignment = UITextAlignmentCenter;    [_amountLabel.layer setCornerRadius:10];    _amountLabel.text = @"36";    _amountLabel.textColor = [UIColor whiteColor];    _amountLabel.backgroundColor = [UIColor redColor];    [friendView addSubview:_amountLabel];    [_amountLabel release];        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(friendView.frame.origin.x+friendView.frame.size.width,friendView.frame.origin.y,1, 44)];    lineView.backgroundColor = kSingleLineColor;    [self.view addSubview:lineView];    [lineView release];        UIView *nearbyView = [[UIView alloc] initWithFrame:CGRectMake(lineView.frame.origin.x+lineView.frame.size.width, friendView.frame.origin.y, 159.5f, 44)];    nearbyView.userInteractionEnabled = YES;    nearbyView.tag = 1001;    [nearbyView addGestureRecognizer:ntapGesture];      nearbyView.backgroundColor = [UIColor whiteColor];    [self.view addSubview:nearbyView];    [nearbyView release];        UIView *nlogoView = [[UIView alloc] initWithFrame:CGRectMake(25, 11, 22, 22)];    nlogoView.layer.contents = (id)[[UIImage imageNamed:@"fj_btn.png"]CGImage];    [nearbyView addSubview:nlogoView];    [nlogoView release];        UILabel *ntitle = [[UILabel alloc] initWithFrame:CGRectMake(nlogoView.frame.origin.x+nlogoView.frame.size.width, nlogoView.frame.origin.y, 80, nlogoView.frame.size.height)];    ntitle.backgroundColor = [UIColor clearColor];    ntitle.text = @"查看附近";    ntitle.textAlignment = UITextAlignmentCenter;    [nearbyView addSubview:ntitle];    [ntitle release];        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,friendView.frame.origin.y+friendView.frame.size.height, self.view.bounds.size.width,kHeight-64-_searchView.frame.size.height-friendView.frame.size.height-49) style:UITableViewStylePlain];    [_tableView setBackgroundView:nil];    _tableView.backgroundColor = [UIColor clearColor];    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;    _tableView.delegate = self;    _tableView.dataSource = self;    [self.view addSubview:_tableView];    [_tableView release];}- (void)event:(UITapGestureRecognizer *)gesture  {      NSLog(@"单机==%d",gesture.view.tag);          AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];    switch (gesture.view.tag) {        case 1000:        {            LFRecommendViewController *recommendController = [[LFRecommendViewController alloc] init];                        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:recommendController];            [[appDelegate window] addSubview:nav.view];            [nav.view release];            [recommendController release];            break;        }            case 1001:        {            LFNearbyViewController *nearbyController = [[LFNearbyViewController alloc] init];                        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:nearbyController];            [[appDelegate window] addSubview:nav.view];            [nav.view release];            [nearbyController release];            break;        }        default:            break;    }}- (void)typeBtnClicked:(id)sender {        NSLog(@"type");        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];        LFSortViewController *sortController = [[LFSortViewController alloc] init];        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sortController];        [[appDelegate window] addSubview:nav.view];    [nav.view release];    [sortController release];}- (void)guideBtnAction:(id)sender {        NSLog(@"%f====%f",screenWidth,screenHeight);        NSString *imageName = screenHeight == 568? @"discover_iphone5.png":@"discover_iphone4.png";    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];    LFGuideView *guideView = [[LFGuideView alloc] initWithFrame:CGRectMake(0,20,screenWidth,screenHeight-20) withImage:imageName];      [[appDelegate window] addSubview:guideView];    [guideView release];}- (void)scanBtnClicked:(id)sender {        NSLog(@"scan");        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];    LFScanningViewController *scanController = [[LFScanningViewController alloc] init];        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:scanController];    [[appDelegate window] addSubview:nav.view];    [nav.view release];       [scanController release];}#pragma mark -#pragma mark UISearchBarDelegate- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {        _searchBar.showsCancelButton = YES;}- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {        _searchBar.showsCancelButton = NO;}- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{	[_searchBar resignFirstResponder];}// called when cancel button pressed- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{	[_searchBar resignFirstResponder];}#pragma mark - Table view data source- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {        return 60;}- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{        return 1;}- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{    return [_array count]%2 == 0? [_array count]/2:([_array count]+1)/2;}- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{        NSString *CardBindCellIdentifier = @"CardBindCellIdentifier";		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CardBindCellIdentifier];		if(cell == nil) {                cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CardBindCellIdentifier"] autorelease];	}        for(UIView *sub in cell.contentView.subviews){                [sub removeFromSuperview];    }        NSInteger row = indexPath.row;                    if (row <= [_array count]/2-1) {        [self createBtnItem:frame_1 Tag:2*row Title:[_array objectAtIndex:2*row] cell:cell];        [self createBtnItem:frame_2 Tag:2*row+1 Title:[_array objectAtIndex:2*row+1] cell:cell];    } else {        [self createBtnItem:frame_1 Tag:2*row Title:[_array objectAtIndex:2*row] cell:cell];    }        cell.selectionStyle = UITableViewCellSelectionStyleNone;    return cell;}- (UIButton *)createBtnItem:(CGRect)frame Tag:(NSInteger)tag Title:(NSString*) titleString cell:(UITableViewCell *)cellView {         UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];    typeBtn.frame = frame;    [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];    [typeBtn addTarget:self action:@selector(typeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];    typeBtn.backgroundColor = [UIColor whiteColor];    [cellView.contentView addSubview:typeBtn];        UIImageView *image = [[UIImageView alloc] init];    image.frame = imageViewFrame;    [image setBackgroundColor:[UIColor grayColor]];    [typeBtn addSubview:image];    [image release];        UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleFrame];    titleLabel.backgroundColor = [UIColor redColor];    titleLabel.text = titleString;    titleLabel.textAlignment = UITextAlignmentCenter;    [typeBtn addSubview:titleLabel];    [titleLabel release];        UILabel *amountLabel = [[UILabel alloc] initWithFrame:amountFrame];    amountLabel.backgroundColor = [UIColor greenColor];    amountLabel.textAlignment = UITextAlignmentCenter;    [typeBtn addSubview:amountLabel];    [amountLabel release];    return typeBtn;}- (void)didReceiveMemoryWarning{    [super didReceiveMemoryWarning];    // Dispose of any resources that can be recreated.}@end