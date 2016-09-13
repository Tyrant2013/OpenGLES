//
//  ZXWView.m
//  OpenGLES
//
//  Created by 庄晓伟 on 16/9/13.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "ZXWView.h"

@implementation ZXWView

- (instancetype)initWithStride:(GLsizei)aStride
                      dataSize:(GLsizeiptr)dataSize
                          data:(const GLvoid *)dataPtr
                         usage:(GLenum)usage {
    if (self = [super init]) {
        _stride = aStride;
        glGenBuffers(1, &vertexBufferID);
        glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
        glBufferData(GL_ARRAY_BUFFER, dataSize, dataPtr, usage);
        
        _baseEffect = [[GLKBaseEffect alloc] init];
        _baseEffect.useConstantColor = GL_TRUE;
        _baseEffect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)prepareToDrawWithAttrib:(GLuint)attrib
            numberOfCoordinates:(GLint)count
                   attribOffset:(GLsizeiptr)offset
                   shouldEnable:(BOOL)shouldEnable {
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
    if (shouldEnable) {
        glEnableVertexAttribArray(attrib);
    }
    glVertexAttribPointer(attrib, count, GL_FLOAT, GL_FALSE, self.stride, NULL + offset);
}

- (void)drawWithMode:(GLenum)mode
    startVertexIndex:(GLint)start
    numberOfVertices:(GLsizei)count {
    glDrawArrays(mode, start, count);
}

- (void)setup {
    
}

- (void)display {
    [self.baseEffect prepareToDraw];
}

- (void)dealloc {
    if (vertexBufferID != 0) {
        glDeleteBuffers(1, &vertexBufferID);
        vertexBufferID = 0;
    }
    if (indexBufferID != 0) {
        glDeleteBuffers(1, &indexBufferID);
        indexBufferID = 0;
    }
}

@end
