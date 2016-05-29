//
//  BSUser.h
//  百思不得姐
//
//  Created by 张树 on 16/5/27.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSUser : NSObject
/**用户名 */
@property(nonatomic,strong)NSString *username;
/**性别 */
@property(nonatomic,strong)NSString *sex;
/**图像*/
@property(nonatomic,strong)NSString *profile_image;

@end
