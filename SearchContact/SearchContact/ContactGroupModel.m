//
//  ContactGroupModel.m
//  SearchContact
//
//  Created by oucaizi on 15/11/27.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import "ContactGroupModel.h"
#import "PinYinForObjc.h"
#import "ContactModel.h"

@implementation ContactGroupModel

@synthesize groupArray;
@synthesize groupTitle;

+(instancetype)getModelByArray:(NSMutableArray*)array Title:(NSString*)title{
    ContactGroupModel *model=[[ContactGroupModel alloc] init];
    NSMutableArray *tempArray=[NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[PinYinForObjc chineseConvertToPinYinHead:obj] isEqualToString:title]) {
            ContactModel *model=[[ContactModel alloc] init];
            model.nickName=obj;
            [tempArray addObject:model];
        }
    }];
    model.groupTitle=title;
    model.groupArray=tempArray;
    return model;
}

@end
