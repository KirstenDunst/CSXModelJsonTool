//
//  FBObjectJsonTool.m
//  FSFuBei
//
//  Created by 曹世鑫 on 2019/5/27.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "CSXObjectJsonTool.h"
#import <objc/runtime.h>

@implementation CSXObjectJsonTool

+ (NSDictionary*)getObjectData:(id)obj {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++) {
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil) {
            value = [self getValueWithPropName:prop];
        } else { 
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}

+ (void)print:(id)obj {
#ifdef DEBUG
    NSLog(@"%@", [self getObjectData:obj]);
#else
#endif
}

+ (id)getValueWithPropName:(objc_property_t)obj {
    //获取属性类型等参数（字段的类型）
    NSString *propertyType = [NSString stringWithCString: property_getAttributes(obj) encoding:NSUTF8StringEncoding];
    NSLog(@">>>>>>>>>>>>>>%@",propertyType);
    if ([propertyType hasPrefix:@"T@\"NSString\""]) {
        return @"";
    }
    if ([propertyType hasPrefix:@"T@\"NSData\""]) {
        return [NSNumber numberWithBool:0];
    }
    if ([propertyType hasPrefix:@"Ti"]||[propertyType hasPrefix:@"TI"]||[propertyType hasPrefix:@"Ts"]||[propertyType hasPrefix:@"TS"]||[propertyType hasPrefix:@"TB"]||[propertyType hasPrefix:@"Tq"]||[propertyType hasPrefix:@"TQ"]) {
        return [NSNumber numberWithInteger:0];
    }
    return [NSNull null];
}


+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error {
    return [NSJSONSerialization dataWithJSONObject:[self getObjectData:obj] options:options error:error];
}

+ (id)getObjectInternal:(id)obj {
    if([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSNull class]]) {
        return obj;
    }
    if([obj isKindOfClass:[NSArray class]]) {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++) {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys) {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}

@end
