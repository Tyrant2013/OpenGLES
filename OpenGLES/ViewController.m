//
//  ViewController.m
//  OpenGLES
//
//  Created by 庄晓伟 on 16/8/24.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "ViewController.h"

#import "TriangleView.h"
#import "RectangleView.h"
#import "CubeView.h"

typedef NS_ENUM(NSUInteger, DrawType) {
    DrawTypeTriangle,
    DrawTypeRectangle,
    DrawTypeCube
};

//typedef struct {
//    GLKVector3 positionCoords;
//    GLKVector2 textureCoords;
//} SceneVertex;
//
//typedef struct {
//    GLKVector3 positionCoords;
//} RectangleVertex;
//
//static const SceneVertex verticesWithTexture[] = {
//    {-0.5f, -0.5f, 0.0f, 0.0f, 0.0f},
//    { 0.5f, -0.5f, 0.0f, 1.0f, 0.0f},
//    {-0.5f,  0.5f, 0.0f, 0.0f, 1.0f}
//};
//
//static const RectangleVertex verticesForRectangle[] = {
//    {-0.5f, -0.5f, 0.0f},
//    { 0.5f, -0.5f, 0.0f},
//    { 0.5f,  0.5f, 0.0f},
//    {-0.5f,  0.5f, 0.0f},
//};
//
//static const RectangleVertex verticesForCube[] = {
//    {-0.5f, -0.5f,  0.0f},
//    { 0.5f, -0.5f,  0.0f},
//    { 0.5f,  0.5f,  0.0f},
//    {-0.5f,  0.5f,  0.0f},
//    {-0.5f, -0.5f, -0.5f},
//    { 0.5f, -0.5f, -0.5f},
//    { 0.5f,  0.5f, -0.5f},
//    {-0.5f,  0.5f, -0.5f},
//};
//static const GLbyte indexs[] = {
//    //front
//    0, 1, 2,
//    2, 3, 0,
//    //back
//    4, 5, 6,
//    6, 7, 4,
//    //left
//    0, 4, 7,
//    7, 3, 0,
//    //right
//    2, 5, 6,
//    6, 3, 2,
//    //top
//    3, 2, 6,
//    6, 7, 3,
//    //bottom
//    0, 1, 5,
//    5, 4, 0
//};

@interface ViewController ()

@property (nonatomic, assign) DrawType              drawType;
@property (nonatomic, assign) float                 rotation;
@property (nonatomic, strong) TriangleView          *triangelView;
@property (nonatomic, strong) RectangleView         *rectangleView;
@property (nonatomic, strong) CubeView              *cubeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.drawType = DrawTypeCube;
    
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

#pragma mark - GLKViewControllerDelegate

- (void)glkViewControllerUpdate:(GLKViewController *)controller {
    if (_drawType == DrawTypeCube) {
        float aspect = fabs(CGRectGetWidth(self.view.bounds) / CGRectGetHeight(self.view.bounds));
        GLKMatrix4 projectMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
        self.cubeView.baseEffect.transform.projectionMatrix = projectMatrix;
        
        GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -5.5f);
        modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, _rotation, 1.0f, 1.0f, 1.0f);
        self.cubeView.baseEffect.transform.modelviewMatrix = modelViewMatrix;
        
        _rotation += self.timeSinceLastUpdate * 0.5f;
    }
}

- (void)dealloc {
    GLKView *view = (GLKView *)self.view;
    [EAGLContext setCurrentContext:view.context];
    
//    if (vertexBufferID != 0) {
//        glDeleteBuffers(1, &vertexBufferID);
//        
//        vertexBufferID = 0;
//    }
//    
//    if (indexBufferID != 0) {
//        glDeleteBuffers(1, &indexBufferID);
//        
//        indexBufferID = 0;
//    }
    
//    ((GLKView *)self.view).context = nil;
    [EAGLContext setCurrentContext:nil];
}

#pragma mark - Methods

- (void)__init__ {
    switch (_drawType) {
        case DrawTypeTriangle:
//            [self __initDrawTriangle];
            [self.triangelView setup];
            break;
        case DrawTypeRectangle:
//           [self __initDrawTriangle];
            [self.rectangleView setup];
            break;
        case DrawTypeCube:
            self.delegate = self;
//            [self __initDrawCube];
            
//            _rotation = 0.8f;
//            float aspect = fabs(CGRectGetWidth(self.view.bounds) / CGRectGetHeight(self.view.bounds));
//            GLKMatrix4 projectMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
//            self.cubeView.baseEffect.transform.projectionMatrix = projectMatrix;
//            
//            GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -5.5f);
//            modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, _rotation, 1.0f, 1.0f, 1.0f);
//            self.cubeView.baseEffect.transform.modelviewMatrix = modelViewMatrix;
            
            [self.cubeView setup];
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
//            [self __drawTriangle];
            [self.triangelView display];
            break;
        case DrawTypeRectangle:
//            [self __drawRectangle];
            [self.rectangleView display];
            break;
        case DrawTypeCube:
//            [self __drawCube];
            [self.cubeView display];
            break;
    }
}

//#pragma mark - Draw Triangle
//
//- (void)__initDrawTriangle {
//    glGenBuffers(1, &vertexBufferID);
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(verticesWithTexture), verticesWithTexture, GL_STATIC_DRAW);
//    
//    self.baseEffect = [[GLKBaseEffect alloc] init];
//    self.baseEffect.useConstantColor = GL_TRUE;
//    self.baseEffect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
//    
//    UIImage *image = [UIImage imageNamed:@"leaves.gif"];
//    GLKTextureInfo *info = [GLKTextureLoader textureWithCGImage:image.CGImage options:nil error:NULL];
//    self.baseEffect.texture2d0.name = info.name;
//    self.baseEffect.texture2d0.target = info.target;
//    
//    NSLog(@"---------- %lu, %lu", sizeof(verticesWithTexture), sizeof(SceneVertex));
//}
//
//- (void)__drawTriangle {
//    [self.baseEffect prepareToDraw];
//    glClear(GL_COLOR_BUFFER_BIT);
//    
//    GLsizeiptr offset = offsetof(SceneVertex, positionCoords);
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
//    glEnableVertexAttribArray(GLKVertexAttribPosition);
//    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL + offset);
//    
//    offset = offsetof(SceneVertex, textureCoords);
//    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
//    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL + offset);
//    
//    glDrawArrays(GL_TRIANGLES, 0, 3);
//    
//}

//#pragma mark - Draw Rectangle 
//
//- (void)__initDrawRectangle {
//    glGenBuffers(1, &vertexBufferID);
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(verticesForRectangle), verticesForRectangle, GL_STATIC_DRAW);
//    
//    self.baseEffect = [[GLKBaseEffect alloc] init];
//    self.baseEffect.useConstantColor = GL_TRUE;
//    self.baseEffect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
//}
//
//- (void)__drawRectangle {
//    [self.baseEffect prepareToDraw];
//    glClear(GL_COLOR_BUFFER_BIT);
//    
//    glEnableVertexAttribArray(GLKVertexAttribPosition);
//    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(RectangleVertex), NULL);
//    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
//}

//#pragma mark - Draw Cube
//
//- (void)__initDrawCube {
//    ((GLKView *)self.view).drawableDepthFormat = GLKViewDrawableDepthFormat24;
//    
//    self.baseEffect = [[GLKBaseEffect alloc] init];
//    self.baseEffect.useConstantColor = GL_TRUE;
//    self.baseEffect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
//    
//    glGenBuffers(1, &vertexBufferID);
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(verticesForCube), verticesForCube, GL_STATIC_DRAW);
//    
//    glGenBuffers(1, &indexBufferID);
//    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBufferID);
//    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indexs), indexs, GL_STATIC_DRAW);
//}
//
//- (void)__drawCube {
//    [self.baseEffect prepareToDraw];
//    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
//    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
//    
//    glEnable(GL_DEPTH_TEST);
//    
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
//    glEnableVertexAttribArray(GLKVertexAttribPosition);
//    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_TRUE, sizeof(RectangleVertex), NULL);
//    
//    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBufferID);
//    glDrawElements(GL_TRIANGLE_STRIP, sizeof(indexs) / sizeof(indexs[0]), GL_UNSIGNED_BYTE, (void *)0);
//}

- (TriangleView *)triangelView {
    if (_triangelView == nil) {
        _triangelView = [[TriangleView alloc] init];
    }
    return _triangelView;
}

- (RectangleView *)rectangleView {
    if (_rectangleView == nil) {
        _rectangleView = [[RectangleView alloc] init];
    }
    return _rectangleView;
}

- (CubeView *)cubeView {
    if (_cubeView == nil) {
        _cubeView = [[CubeView alloc] init];
    }
    return _cubeView;
}

@end
