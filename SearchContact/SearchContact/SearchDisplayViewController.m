//
//  SearchDisplayViewController.m
//  SearchContact
//
//  Created by oucaizi on 15/11/27.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import "SearchDisplayViewController.h"
#import "PinYinForObjc.h"
#import "ContactGroupModel.h"
#import "ContactModel.h"
#import "SearchResultHandle.h"
#import "NSMutableArray+Filter.h"

@interface SearchDisplayViewController ()<UISearchDisplayDelegate,UISearchBarDelegate>

@property(nonatomic,strong) NSMutableArray *data;///数据源
@property(nonatomic,strong) NSMutableArray *sectionIndexs;///数据分区数组
@property(nonatomic,strong) NSMutableArray *dataArray;///各分区数组
@property(nonatomic,strong) NSArray *searchList;///搜索结果数组
@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) UISearchDisplayController *searchDisplayController;

@end

@implementation SearchDisplayViewController
@synthesize searchDisplayController;

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"搜索";
    [self.view addSubview:self.ptableView];
    
    self.data=[NSMutableArray array];
    self.dataArray = [NSMutableArray arrayWithObjects:@"2dddddd",@"sss",@"sssss",@"ssss",@"百度",@"腾讯",@"阿里巴巴",@"dzb8818082@163.com",@"@#3",@"大兵布莱恩特",@"摸诺维茨基",@"课茨基",@"几基",@"付",@"德克诺维茨基",@"首付款",@"的基",@"到基",@"克诺维茨基",@"诺维茨基",@"茨基",@"基",nil];
    self.sectionIndexs=[NSMutableArray array];
    [self.dataArray enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.sectionIndexs addObject:[PinYinForObjc chineseConvertToPinYinHead:obj]];
    }];
    self.sectionIndexs=[self.sectionIndexs filterElement];
    [self.sectionIndexs sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableArray *tempArray=[NSMutableArray array];
    [self.sectionIndexs enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ContactGroupModel *model=[ContactGroupModel getModelByArray:self.dataArray Title:obj];
        [tempArray addObject:model];
    }];
    self.data=tempArray;
    
    self.ptableView.tableHeaderView=self.searchBar;
    
    self.searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.delegate=self;
    
}

//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark UITableViewDelegate/DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        return 1;
    }
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        return self.searchList.count;
    }
    ContactGroupModel *model=self.data[section];
    return model.groupArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* indetitier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indetitier];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetitier];
    }
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text=self.searchList[indexPath.row];
    }else{
        ContactGroupModel *modelGroup=self.data[indexPath.section];
        ContactModel *model=modelGroup.groupArray[indexPath.row];
        cell.textLabel.text=model.nickName;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView!=self.searchDisplayController.searchResultsTableView) {
        // 背景图
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.view.frame), 30)];
        bgView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        // 显示分区的 label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, CGRectGetHeight(self.view.frame), 30)];
        label.text = self.sectionIndexs[section];
        [bgView addSubview:label];
        return bgView;
    }else{
        return nil;
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView!=self.searchDisplayController.searchResultsTableView) {
       return 30;
    }
    else{
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView
{
    return self.sectionIndexs;
}

#pragma mark UISearchDisplayController

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(nullable NSString *)searchString{
    self.searchList=[SearchResultHandle getResultByArray:self.dataArray keywords:searchString];

    return YES;
}

#pragma mark SearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton=YES;
    NSArray *subViews;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        subViews = [(searchBar.subviews[0]) subviews];
    }
    else {
        subViews = searchBar.subviews;
    }
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}

#pragma mark setter/getter

-(UITableView*)ptableView{
    if (!_ptableView) {
        _ptableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_ptableView setDelegate:self];
        [_ptableView setDataSource:self];
    }
    return _ptableView;
}

-(NSArray*)searchList
{
    if (!_searchList) {
        _searchList=[NSArray array];
    }
    return _searchList;
}

-(UISearchBar*)searchBar{
    if (!_searchBar) {
        _searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
        _searchBar.placeholder=@"请输入搜索内容";
        [_searchBar setDelegate:self];
        [_searchBar setBackgroundImage:[self imageWithColor:[UIColor clearColor] size:_searchBar.bounds.size]];
    }
    return _searchBar;
}

@end
