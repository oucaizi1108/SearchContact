//
//  ContactGroupModel.h
//  SearchContact
//
//  Created by oucaizi on 15/11/27.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactGroupModel : NSObject


@property(nonatomic,strong) NSMutableArray *groupArray;
@property(nonatomic,copy) NSString *groupTitle;

+(instancetype)getModelByArray:(NSMutableArray*)array Title:(NSString*)title;

@end
