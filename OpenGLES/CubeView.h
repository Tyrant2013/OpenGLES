//
//  CubeView.h
//  OpenGLES
//
//  Created by 庄晓伟 on 16/9/13.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "ZXWView.h"

@interface CubeView : ZXWView {
    GLuint colorIndexBufferID;
}

@property (nonatomic, assign) float                         rotation;

@end
