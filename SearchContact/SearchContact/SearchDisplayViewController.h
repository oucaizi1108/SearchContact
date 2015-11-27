//
//  SearchDisplayViewController.h
//  SearchContact
//
//  Created by oucaizi on 15/11/27.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface SearchDisplayViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *ptableView;



@end
