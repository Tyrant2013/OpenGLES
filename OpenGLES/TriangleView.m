//
//  TriangleView.m
//  OpenGLES
//
//  Created by 庄晓伟 on 16/9/13.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "TriangleView.h"

typedef struct {
    GLKVector3 positionCoords;
    GLKVector2 textureCoords;
} Vertex;

static const Vertex verticesWithTexture[] = {
    {-0.5f, -0.5f, 0.0f, 0.0f, 0.0f},
    { 0.5f, -0.5f, 0.0f, 1.0f, 0.0f},
    {-0.5f,  0.5f, 0.0f, 0.0f, 1.0f}
};

@implementation TriangleView

- (instancetype)init {
    if (self = [super initWithStride:sizeof(Vertex)
                            dataSize:sizeof(verticesWithTexture)
                                data:verticesWithTexture
                               usage:GL_STATIC_DRAW]) {
        
    }
    return self;
}

- (void)setup {
    UIImage *image = [UIImage imageNamed:@"leaves.gif"];
    GLKTextureInfo *info = [GLKTextureLoader textureWithCGImage:image.CGImage options:nil error:NULL];
    self.baseEffect.texture2d0.name = info.name;
    self.baseEffect.texture2d0.target = info.target;
}

- (void)display {
    [super display];
    glClear(GL_COLOR_BUFFER_BIT);
    
    [self prepareToDrawWithAttrib:GLKVertexAttribPosition
              numberOfCoordinates:3
                     attribOffset:offsetof(Vertex, positionCoords)
                     shouldEnable:YES];
    [self prepareToDrawWithAttrib:GLKVertexAttribTexCoord0
              numberOfCoordinates:2
                     attribOffset:offsetof(Vertex, textureCoords)
                     shouldEnable:YES];
    [self drawWithMode:GL_TRIANGLES
      startVertexIndex:0
      numberOfVertices:3];
}

@end
