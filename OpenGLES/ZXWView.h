//
//  ZXWView.h
//  OpenGLES
//
//  Created by 庄晓伟 on 16/9/13.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface ZXWView : NSObject {
    GLuint vertexBufferID;
    GLuint indexBufferID;
    GLuint colorBufferID;
}

@property (nonatomic, strong) GLKBaseEffect                 *baseEffect;
@property (nonatomic, assign) GLsizei                       stride;

- (instancetype)initWithStride:(GLsizei)aStride
                      dataSize:(GLsizeiptr)dataSize
                          data:(const GLvoid *)dataPtr
                         usage:(GLenum)usage;

- (void)prepareToDrawWithAttrib:(GLuint)attrib
            numberOfCoordinates:(GLint)count
                   attribOffset:(GLsizeiptr)offset
                   shouldEnable:(BOOL)shouldEnable;

- (void)drawWithMode:(GLenum)mode
    startVertexIndex:(GLint)start
    numberOfVertices:(GLsizei)count;

- (void)setup;
- (void)display __attribute__((objc_requires_super));

@end
