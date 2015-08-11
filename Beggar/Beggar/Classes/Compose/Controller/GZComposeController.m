//
//  GZComposeController.m
//  Beggar
//
//  Created by Madao on 15/8/10.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZComposeController.h"
#import "GZHttpTool.h"
#import "XMGStatusBarHUD.h"
#import "GZAccountTool.h"
#import "GZComposeTextView.h"

NSInteger const kComposePhotoWH = 80;
NSInteger const kComposeBtnWH = 24;
NSInteger const kComposeMargin = 10;

@interface GZComposeController () <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

/** 输入控件 */
@property (nonatomic, weak) GZComposeTextView *textView;

@property (weak, nonatomic) UIImageView *photoView;

@property (weak, nonatomic) UIButton *photoBtn;

/** 判断当前textview是否处于非编辑状态 */
@property (assign, nonatomic) BOOL textEditState;

@property (strong, nonatomic) UIActionSheet *addPhoto;

@property (strong, nonatomic) UIActionSheet *deletePhoto;

@end

@implementation GZComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏内容
    [self setupNav];
    
    // 添加输入控件
    [self setupTextView];
    
    // 添加photoBtn
    [self setupPhotoBtn];
    
    // 添加photoView
    [self setupPhotoView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.photoBtn.selected) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.textEditState == NO) {
        [self.textView becomeFirstResponder];
    }
    
}

- (void)dealloc
{
    [GZNotificationCenter removeObserver:self];
}

#pragma mark - 导航栏

/**
 * 设置导航栏内容
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    NSString *name = [GZAccountTool account].userName;
    self.title = name;
}


#pragma mark - photoBtn

- (void)setupPhotoBtn
{
    UIButton *photoBtn = [[UIButton alloc] init];
    photoBtn.width = kComposeBtnWH;
    photoBtn.height = kComposeBtnWH;
    photoBtn.y = self.view.height - photoBtn.height - 5;
    photoBtn.x = 2 * kComposeMargin;
    
    [photoBtn setImage:[UIImage imageNamed:@"compose_toolbar_1"] forState:UIControlStateNormal];
    [photoBtn setImage:[UIImage imageNamed:@"compose_toolbar_1_on"] forState:UIControlStateSelected];
    
    [photoBtn addTarget:self action:@selector(clickPhotoBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:photoBtn];
    self.photoBtn = photoBtn;
}

- (void)clickPhotoBtn
{
    if (!self.photoBtn.selected) { // 选取图片
       
        [self.addPhoto showInView:self.view];
        
    } else { // 删除图片
        
        [self.deletePhoto showInView:self.view];
    }
}

- (UIActionSheet *)addPhoto
{
    if (!_addPhoto) {
        _addPhoto = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄照片",@"从照片库中选择", nil];
    }
    return _addPhoto;
}

- (UIActionSheet *)deletePhoto
{
    if (!_deletePhoto) {
        _deletePhoto = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除照片" otherButtonTitles:nil];
    }
    return _deletePhoto;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == self.addPhoto) {
        
        if (buttonIndex == 0) { // 相机
            [self openCamera];
        } else if (buttonIndex == 1) { // 图库
            [self openAlbum];
        }
        
    } else if (actionSheet == self.deletePhoto) {
        
        if (buttonIndex == 0) { // 删除照片
            [self deleteImage];
        }
    }
}

- (void)deleteImage
{
    self.photoView.image = nil;
    self.photoView.hidden = YES;
    self.textView.width = GZScreenW;
    self.photoBtn.selected = NO;
    [self textDidChange];
}

- (void)addImage:(UIImage *)image
{
    self.photoView.image = image;
    self.photoView.hidden = NO;
    self.textView.width = GZScreenW - 2 * kComposeMargin - kComposePhotoWH;
    self.photoBtn.selected = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

- (void)openAlbum
{
    [self.view endEditing:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
    });
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    [ipc.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_nav_bg"]]];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self addImage:info[UIImagePickerControllerOriginalImage]];
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSUInteger options = [userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        if (keyboardF.origin.y > self.view.height) {
            self.photoBtn.y = self.view.height - self.photoBtn.height - 5;
        } else {
            self.photoBtn.y = keyboardF.origin.y - self.photoBtn.height - 5;
        }
    } completion:nil];
    
    CGRect keyboardBeginF = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    if (keyboardBeginF.origin.y > keyboardF.origin.y) {
        self.textEditState = NO;
    }
}

- (void)setupPhotoView
{
    UIImageView *photoView = [[UIImageView alloc] init];
    CGFloat photoX = GZScreenW - kComposeMargin - kComposePhotoWH;
    CGFloat photoY = 64 + kComposeMargin;
    CGFloat photoW = kComposePhotoWH;
    CGFloat photoH = kComposePhotoWH;
    photoView.frame = CGRectMake(photoX, photoY, photoW, photoH);
    
    photoView.contentMode = UIViewContentModeScaleAspectFill;
    photoView.clipsToBounds = YES;
    
    [self.view addSubview:photoView];
    self.photoView = photoView;
}

#pragma mark - textView

/**
 * 添加输入控件
 */
- (void)setupTextView
{
    // 在这个控制器中，textView的contentInset.top默认会等于64
    GZComposeTextView *textView = [[GZComposeTextView alloc] init];
    // 垂直方向上永远可以拖拽（有弹簧效果）
    textView.alwaysBounceVertical = YES;
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.delegate = self;
    textView.placeholder = @"分享新鲜事...";
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 文字改变的通知
    [GZNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    [GZNotificationCenter addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)send
{
    [XMGStatusBarHUD showLoading:@"正在发送"];
    
    if (self.photoView.image) {
        [self sendWithPhoto];
    } else {
        [self sendWithoutPhoto];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendWithPhoto
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    
    [[GZHttpTool shareHttpTool] postWithURL:kGZPhotoUpdate params:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        UIImage *image = self.photoView.image;
        
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        
        [formData appendPartWithFileData:data name:@"photo" fileName:@"test.jpg" mimeType:@"image/jpeg"];

    } success:^(id json) {
        [XMGStatusBarHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        GZLog(@"%@",error);
        [XMGStatusBarHUD showError:@"发送失败"];
    }];
}

- (void)sendWithoutPhoto
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    
    [[GZHttpTool shareHttpTool] postWithURL:kGZStatusUpdate params:params success:^(id json) {
        
        [XMGStatusBarHUD showSuccess:@"发送成功"];
        
    } failure:^(NSError *error) {
        [XMGStatusBarHUD showError:@"发送失败"];
    }];
}

/**
 * 监听文字改变
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
