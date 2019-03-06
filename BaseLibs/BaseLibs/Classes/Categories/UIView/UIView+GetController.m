//
//  UIView+GetController.m
//  PassCard
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 meiriyou. All rights reserved.
//

#import "UIView+GetController.h"

@implementation UIView (GetController)

-(UIViewController * )cpx_getSuperControllerOfTheView{
    
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            UIViewController * vc = (UIViewController *)next;

            return vc;
        }
        
        next = [next nextResponder];
        
    } while (next != nil);
    return nil;

}
-(UITableViewCell * )cpx_getSuperContainerCell{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UITableViewCell class]]) {
            UITableViewCell * cell = (UITableViewCell *)next;
            
            return cell;
        }
        
        next = [next nextResponder];
        
    } while (next != nil);
    return nil;
}

- (NSIndexPath *)cpx_indexPathInTable:(UITableView *)tableView{
    
    UIResponder *next = [self nextResponder];
    UITableViewCell *cell = nil;
    do {
        if ([next isKindOfClass:[UITableViewCell class]]) {
            cell = (UITableViewCell *)next;
            return  [tableView indexPathForCell:cell];
            
        }
        
        next = [next nextResponder];
        
    } while (next != nil);
    return nil;
    
}


@end

@implementation UITableViewCell (GetContainerTable)
-(UITableView * )cpx_getSuperContainerTableWithCell{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UITableView class]]) {
            UITableView * table = (UITableView *)next;
            
            return table;
        }
        
        next = [next nextResponder];
        
    } while (next != nil);
    return nil;
}



@end
