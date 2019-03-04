//
//  UIView+GetController.h
//  PassCard
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 meiriyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GetController)

/**
 获取view的所在的controller

 */
-(UIViewController * )cpx_getSuperControllerOfTheView;

/**
 获取view所在UITableViewCell

 */
-(UITableViewCell * )cpx_getSuperContainerCell;

/**
 根据点击的视图 、获取当前indexPath
 
 @param tableView tableView
 */
- (NSIndexPath *)cpx_indexPathInTable:(UITableView *)tableView;





@end


@interface UITableViewCell (GetContainerTable)

/**
 获取cell所在的tableview
 
 */
-(UITableView * )cpx_getSuperContainerTableWithCell;


@end
