//
//  RectangleView.m
//  OpenGLES
//
//  Created by 庄晓伟 on 16/9/13.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "RectangleView.h"

typedef struct {
    GLKVector3 positionCoords;
} RectangleVertex;

static const RectangleVertex verticesForRectangle[] = {
    {-0.5f, -0.5f, 0.0f},
    { 0.5f, -0.5f, 0.0f},
    { 0.5f,  0.5f, 0.0f},
    {-0.5f,  0.5f, 0.0f},
};

@implementation RectangleView

- (instancetype)init {
    if (self = [super initWithStride:sizeof(RectangleVertex)
                            dataSize:sizeof(verticesForRectangle)
                                data:verticesForRectangle
                               usage:GL_STATIC_DRAW]) {
        
    }
    return self;
}

- (void)setup {
    
}

- (void)display {
    [super display];
    glClear(GL_COLOR_BUFFER_BIT);
    
    [self prepareToDrawWithAttrib:GLKVertexAttribPosition
              numberOfCoordinates:3
                     attribOffset:offsetof(RectangleVertex, positionCoords)
                     shouldEnable:YES];
    [self drawWithMode:GL_TRIANGLE_FAN
      startVertexIndex:0
      numberOfVertices:4];
}

@end
