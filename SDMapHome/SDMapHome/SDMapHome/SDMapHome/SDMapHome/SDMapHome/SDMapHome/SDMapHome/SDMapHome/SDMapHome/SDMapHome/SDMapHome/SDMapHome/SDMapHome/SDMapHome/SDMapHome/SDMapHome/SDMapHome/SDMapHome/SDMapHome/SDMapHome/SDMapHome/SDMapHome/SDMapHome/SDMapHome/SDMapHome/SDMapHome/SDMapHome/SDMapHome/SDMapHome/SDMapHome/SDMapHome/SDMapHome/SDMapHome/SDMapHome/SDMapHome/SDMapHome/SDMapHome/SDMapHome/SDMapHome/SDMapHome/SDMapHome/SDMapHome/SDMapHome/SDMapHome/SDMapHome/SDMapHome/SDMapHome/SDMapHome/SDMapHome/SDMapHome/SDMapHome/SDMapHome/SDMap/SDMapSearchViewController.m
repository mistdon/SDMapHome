//
//  SDMapSearchViewController.m
//  SDMapHome
//
//  Created by Allen on 16/4/6.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "SDMapSearchViewController.h"
#import "SDSearchResutlTableViewCell.h"
#import "SDSNumerousView.h"

static NSString *const listCellIdentifier = @"listCellIdentifier";
static NSString *const blankCellIdentifier = @"blankCellIdentifier";

@interface SDMapSearchViewController ()<UISearchBarDelegate,AMapSearchDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (nonatomic, strong)IBOutlet UITableView *listTableView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) SDSNumerousView *headerView;

@property (nonatomic, strong) AMapSearchAPI *searchAPI;


@property (nonatomic, strong) NSMutableArray *datasources;
@end

@implementation SDMapSearchViewController

- (NSMutableArray *)datasources{
    if (!_datasources) {
        _datasources = [[NSMutableArray alloc] init];
    }
    return _datasources;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureSearchAPI];
}
- (void)configureSearchAPI{
    self.searchAPI = [[AMapSearchAPI alloc] init];
    self.searchAPI.delegate  = self;
}
- (void)configureSubViews {
    [self.listTableView registerClass:[SDSearchResutlTableViewCell class] forCellReuseIdentifier:listCellIdentifier];
    [self.listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:blankCellIdentifier];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configureSubViews];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     self.searchBar.delegate = self;
    [self.searchBar becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    _headerView  = nil;
    _searchAPI   = nil;
    [_datasources removeAllObjects];
    _datasources = nil;
    NSLog(@"%s",__FUNCTION__);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)backItemClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark - UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasources.count > 0 ? self.datasources.count : 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.datasources.count > 0) {
        SDSearchResutlTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listCellIdentifier];
        AMapAOI *aoi = self.datasources[indexPath.row];
//        cell.textLabel.text = aoi.name;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:blankCellIdentifier];
        UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 20)];
        lable.text = @"支持地点、公交、地铁、行政区域, 更有智能语音识别";
        lable.numberOfLines = 0;
        [cell.contentView addSubview:lable];
        return cell;
    }
}
#pragma makr - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.datasources[indexPath.row]) {
        AMapAOI *aoi = self.datasources[indexPath.row];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.headerView = [[SDSNumerousView alloc] init];
    self.headerView.backgroundColor = [UIColor lightGrayColor];
    return self.headerView;
}
#pragma mark - UISearchBardelegaet
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"search");
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    CLLocationCoordinate2D coordinate = self.userLocation.location.coordinate;
    request.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    request.keywords = searchBar.text;
    request.types = @"餐饮服务|生活服务|地名地址信息";
    request.sortrule = 0;
    request.requireExtension = YES;
    [self.searchAPI AMapPOIAroundSearch:request];
    [searchBar resignFirstResponder];
}
#pragma mark - AMapPOISearchResponse
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
}
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    if(response.pois.count == 0) return;
    //通过 AMapPOISearchResponse 对象处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %ld",(unsigned long)response.count];
    NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion];
    NSString *strPoi = @"";
    for (AMapPOI *p in response.pois) {
        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.description];
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
    NSLog(@"Place: %@", result);
    if (self.datasources.count>0){
        [self.datasources removeAllObjects];
    }
    [self.datasources addObjectsFromArray:response.pois];
    [self.listTableView reloadData];
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
