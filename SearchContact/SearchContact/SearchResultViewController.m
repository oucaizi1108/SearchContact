//
//  SearchResultViewController.m
//  SearchContact
//
//  Created by oucaizi on 15/11/27.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import "SearchResultViewController.h"
#import "ContactModel.h"

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title=@"搜索结果";
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"FollowTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ContactModel *model=self.dataSource[indexPath.row];
    cell.textLabel.text=model.nickName;
    return cell;
}


@end
