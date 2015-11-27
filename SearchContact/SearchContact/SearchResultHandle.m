//
//  SearchResultHandle.m
//  SearchContact
//
//  Created by oucaizi on 15/11/27.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import "SearchResultHandle.h"
#import "PinYinForObjc.h"
#import "ChineseInclude.h"

@implementation SearchResultHandle

+(NSMutableArray*)getResultByArray:(NSMutableArray*)array keywords:(NSString*)searchText{
    NSMutableArray *tempResult=[NSMutableArray array];
    if (searchText.length>0&&![ChineseInclude isIncludeChineseInString:searchText]) {
        [array enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([ChineseInclude isIncludeChineseInString:obj]) {
                NSString *pinYin=[PinYinForObjc chineseConvertToPinYin:obj];
                NSRange range=[pinYin rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (range.length>0) {
                    [tempResult addObject:obj];
                }
                
                NSString *pinYinHead=[PinYinForObjc chineseConvertToPinYinHead:obj];
                NSRange rangeh=[pinYinHead rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (rangeh.length>0) {
                    [tempResult addObject:obj];
                }
                
            }else{
                NSRange range=[obj rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (range.length>0) {
                    [tempResult addObject:obj];
                }
            }
        }];
        
    }else if(searchText.length>0&&[ChineseInclude isIncludeChineseInString:searchText]){
      [array enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range=[obj rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.length>0) {
                [tempResult addObject:obj];
            }
        }];
    }

    
    return tempResult;
}

@end
