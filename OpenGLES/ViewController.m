//
//  ViewController.m
//  OpenGLES
//
//  Created by 庄晓伟 on 16/8/24.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSUInteger, DrawType) {
    DrawTypeTriangle,
    DrawTypeRectangle,
    DrawTypeCube
};

typedef struct {
    GLKVector3 positionCoords;
    GLKVector2 textureCoords;
} SceneVertex;

typedef struct {
    GLKVector3 positionCoords;
} RectangleVertex;

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

static const RectangleVertex verticesForRectangle[] = {
    {-0.5f, -0.5f, 0.0f},
    { 0.5f, -0.5f, 0.0f},
    { 0.5f,  0.5f, 0.0f},
    {-0.5f,  0.5f, 0.0f},
};

@interface ViewController ()

@property (nonatomic, assign) DrawType              drawType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.drawType = DrawTypeRectangle;
    
    [self __initContext];
    [self __init__];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self __draw__];
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

#pragma mark - Methods

- (void)__init__ {
    switch (_drawType) {
        case DrawTypeTriangle:
            [self __initDrawTriangle];
            break;
        case DrawTypeRectangle:
            [self __initDrawRectangle];
            break;
        case DrawTypeCube:
            [self __initDrawCube];
            break;
    }
}

- (void)__initContext {
    GLKView *view = (GLKView *)self.view;
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:view.context];
}

- (void)__draw__ {
    switch (_drawType) {
        case DrawTypeTriangle:
            [self __drawTriangle];
            break;
        case DrawTypeRectangle:
            [self __drawRectangle];
            break;
        case DrawTypeCube:
            [self __drawCube];
            break;
    }
}

#pragma mark - Draw Triangle

- (void)__initDrawTriangle {
    
    glGenBuffers(1, &vertexBufferID);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
    glBufferData(GL_ARRAY_BUFFER, sizeof(verticesWithTexture), verticesWithTexture, GL_STATIC_DRAW);
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    
    UIImage *image = [UIImage imageNamed:@"leaves.gif"];
    GLKTextureInfo *info = [GLKTextureLoader textureWithCGImage:image.CGImage options:nil error:NULL];
    self.baseEffect.texture2d0.name = info.name;
    self.baseEffect.texture2d0.target = info.target;
}

- (void)__drawTriangle {
    [self.baseEffect prepareToDraw];
    glClear(GL_COLOR_BUFFER_BIT);
    
    GLsizeiptr offset = offsetof(SceneVertex, positionCoords);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL + offset);
    
    offset = offsetof(SceneVertex, textureCoords);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL + offset);
    
    glDrawArrays(GL_TRIANGLES, 0, 3);
    
}

#pragma mark - Draw Rectangle 

- (void)__initDrawRectangle {
    glGenBuffers(1, &vertexBufferID);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
    glBufferData(GL_ARRAY_BUFFER, sizeof(verticesForRectangle), verticesForRectangle, GL_STATIC_DRAW);
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
}

- (void)__drawRectangle {
    [self.baseEffect prepareToDraw];
    glClear(GL_COLOR_BUFFER_BIT);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(RectangleVertex), NULL);
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
}

#pragma mark - Draw Cube

- (void)__initDrawCube {
    
}

- (void)__drawCube {
    
}

@end
















































































