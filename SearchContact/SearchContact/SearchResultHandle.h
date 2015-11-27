//
//  SearchResultHandle.h
//  SearchContact
//
//  Created by oucaizi on 15/11/27.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultHandle : NSObject

+(NSMutableArray*)getResultByArray:(NSMutableArray*)array keywords:(NSString*)searchText;

@end
