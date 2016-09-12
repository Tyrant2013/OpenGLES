//
//  ViewController.m
//  OpenGLES
//
//  Created by 庄晓伟 on 16/8/24.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "ViewController.h"

typedef struct {
    GLKVector3 positionCoords;
    GLKVector2 textureCoords;
} SceneVertex;

//static const SceneVertex vertices[] = {
//    {-0.5f, -0.5f, 0.0f},
//    { 0.5f, -0.5f, 0.0f},
//    {-0.5f,  0.5f, 0.0f}
//};

static const SceneVertex verticesWithTexture[] = {
    {-0.5f, -0.5f, 0.0f, 0.0f, 0.0f},
    { 0.5f, -0.5f, 0.0f, 1.0f, 0.0f},
    {-0.5f,  0.5f, 0.0f, 0.0f, 1.0f}
};

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GLKView *view = (GLKView *)self.view;
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:view.context];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    
    glGenBuffers(1, &vertexBufferID);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
    glBufferData(GL_ARRAY_BUFFER, sizeof(verticesWithTexture), verticesWithTexture, GL_STATIC_DRAW);
    
    UIImage *image = [UIImage imageNamed:@"leaves.gif"];
    GLKTextureInfo *info = [GLKTextureLoader textureWithCGImage:image.CGImage options:nil error:NULL];
    self.baseEffect.texture2d0.name = info.name;
    self.baseEffect.texture2d0.target = info.target;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
//    [self.baseEffect prepareToDraw];
//    
//    glClear(GL_COLOR_BUFFER_BIT);
//    
//    GLsizeiptr offset = offsetof(SceneVertex, positionCoords);
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
//    glEnableVertexAttribArray(GLKVertexAttribPosition);
//    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL + offset);
//    
//    offset = offsetof(SceneVertex, textureCoords);
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
//    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
//    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL + offset);
//    
//    glDrawArrays(GL_TRIANGLES, 0, 3);
    
    [self.baseEffect prepareToDraw];
    
    glClear(GL_COLOR_BUFFER_BIT);
    GLsizeiptr offset = offsetof(SceneVertex, positionCoords);
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL + offset);
    
    offset = offsetof(SceneVertex, textureCoords);
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL + offset);
    
    glDrawArrays(GL_TRIANGLES, 0, 3);
}

- (void)dealloc {
    GLKView *view = (GLKView *)self.view;
    [EAGLContext setCurrentContext:view.context];
    
    if (vertexBufferID != 0) {
        glDeleteBuffers(1, &vertexBufferID);
        
        vertexBufferID = 0;
    }
    
//    ((GLKView *)self.view).context = nil;
    [EAGLContext setCurrentContext:nil];
}

@end
















































































