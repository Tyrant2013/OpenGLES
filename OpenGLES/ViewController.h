//
//  ViewController.h
//  OpenGLES
//
//  Created by 庄晓伟 on 16/8/24.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface ViewController : GLKViewController {
    GLuint vertexBufferID;
}

@property (nonatomic, strong) GLKBaseEffect *baseEffect;

@end

