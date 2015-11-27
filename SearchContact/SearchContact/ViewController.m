//
//  ViewController.m
//  SearchContact
//
//  Created by oucaizi on 15/11/27.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *ptableView;
@property(nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"搜索";
    [self.view addSubview:self.ptableView];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark UITableViewDelegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* indetitier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indetitier];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetitier];
    }
    cell.textLabel.text=self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Class class;
    switch (indexPath.row) {
        case 0:
        {
             class=NSClassFromString(@"SearchViewController");
        }
            break;
        case 1:
        {
             class=NSClassFromString(@"SearchDisplayViewController");
        }
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:[[class alloc] init] animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

-(NSMutableArray*)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray arrayWithObjects:@"UISearchDisplayController",@"UISearchController", nil];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
