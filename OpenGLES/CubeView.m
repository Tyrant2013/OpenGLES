//
//  CubeView.m
//  OpenGLES
//
//  Created by 庄晓伟 on 16/9/13.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "CubeView.h"

typedef struct {
    GLKVector3 positionCoords;
} RectangleVertex;

static const RectangleVertex verticesForCube[] = {
    {-0.5f, -0.5f,  0.0f},
    { 0.5f, -0.5f,  0.0f},
    { 0.5f,  0.5f,  0.0f},
    {-0.5f,  0.5f,  0.0f},
    {-0.5f, -0.5f, -0.5f},
    { 0.5f, -0.5f, -0.5f},
    { 0.5f,  0.5f, -0.5f},
    {-0.5f,  0.5f, -0.5f},
};
static const GLbyte indexs[] = {
    //front
    0, 1, 2,
    2, 3, 0,
    //back
    4, 5, 6,
    6, 7, 4,
    //left
    0, 4, 7,
    7, 3, 0,
    //right
    2, 5, 6,
    6, 3, 2,
    //top
    3, 2, 6,
    6, 7, 3,
    //bottom
    0, 1, 5,
    5, 4, 0
};

@implementation CubeView

- (instancetype)init {
    if (self = [super initWithStride:sizeof(RectangleVertex)
                            dataSize:sizeof(verticesForCube)
                                data:verticesForCube
                               usage:GL_STATIC_DRAW]) {
        glGenBuffers(1, &indexBufferID);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBufferID);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indexs), indexs, GL_STATIC_DRAW);
    }
    return self;
}

- (void)setup {
    
}

- (void)display {
    [super display];
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    
    [self prepareToDrawWithAttrib:GLKVertexAttribPosition
              numberOfCoordinates:3
                     attribOffset:offsetof(RectangleVertex, positionCoords)
                     shouldEnable:YES];
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBufferID);
    glDrawElements(GL_TRIANGLE_STRIP, sizeof(indexs) / sizeof(indexs[0]), GL_UNSIGNED_BYTE, (void *)0);
}

@end
