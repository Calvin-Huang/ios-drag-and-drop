//
//  DNDDragContext.m
//  iOS Library
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "DNDDragContext_Private.h"
#import "DNDDragAndDropController_Private.h"


@implementation DNDDragContext {
    BOOL _canceled;
}

#pragma mark - Initialization

- (instancetype)initWithDragHandler:(DNDDragHandler *)handler {
    if ((self = [super init])) {
        _dragHandler = handler;
        _userInfo = [NSMutableDictionary dictionary];
    }
    return self;
}


#pragma mark - Cancel Dragging

- (void)cancelDragging {
    _canceled = YES;
    [self.dragHandler cancelDragging];
    [self.draggingView removeFromSuperview];
}

- (void)cancelDraggingAnimatedWithDuration:(NSTimeInterval)duration animations:(void(^)())animations {
    _canceled = YES;
    [self.dragHandler cancelDragging];
    [UIView animateWithDuration:duration animations:animations completion:^(BOOL finished) {
        [self.draggingView removeFromSuperview];
    }];
}

- (BOOL)isDraggingCancelled {
    return _canceled;
}


#pragma mark - Conversion Helpers

- (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view {
    return [self.dragHandler.controller.dragPaneView convertPoint:point toView:view];
}

- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view {
    return [self.dragHandler.controller.dragPaneView convertPoint:point fromView:view];
}

- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view {
    return [self.dragHandler.controller.dragPaneView convertRect:rect toView:view];
}

- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view {
    return [self.dragHandler.controller.dragPaneView convertRect:rect fromView:view];
}

@end