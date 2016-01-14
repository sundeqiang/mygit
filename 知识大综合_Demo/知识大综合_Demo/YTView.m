//
//  YTView.m
//  03 - 小黄人
//
//  Created by 杨阳 on 16/1/12.
//  Copyright © 2016年 yangyang. All rights reserved.
//

#import "YTView.h"


//半径
#define YTRadius 100

//身体高度
#define YTHeight 200

#define YTTopY 200

//设置颜色
#define YTColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]

@implementation YTView

- (void)drawRect:(CGRect)rect{

    [super drawRect:rect];
    //1.上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2.身体
    drawBody(ctx, rect);
    
    //3.嘴
    drawZui(ctx, rect);
    //4.画眼睛
    drawEyes(ctx, rect);
    
    //5.画头发
    drawHair(ctx, rect);
  
}

#pragma mark - 画头发
void drawHair(CGContextRef  ctx, CGRect rect){

    //设置线的颜色
    [[UIColor blackColor] set];
    
    //设置线宽
    CGContextSetLineWidth(ctx, 3);
    
    CGFloat startX = rect.size.width * 0.5;
    CGFloat startY = YTTopY - YTRadius;
    
    //1.第一根头发
    //设置头发起点
    CGContextMoveToPoint(ctx, startX  - 5, startY + 7);
    //从起点画一根头发
    CGContextAddLineToPoint(ctx, startX - 10, startY - 50);
    CGContextStrokePath(ctx);
    
    //2.第二根头发
    CGContextMoveToPoint(ctx, startX  + 4, startY + 6);
    CGContextAddLineToPoint(ctx, startX + 7, startY - 50);
    CGContextStrokePath(ctx);
    
    //3.第三根头发
    CGContextMoveToPoint(ctx, startX + 8, startY + 10);
    CGContextAddLineToPoint(ctx, startX + 15, startY - 55);
    CGContextStrokePath(ctx);
    
    
}

#pragma mark - 画眼睛
void drawEyes(CGContextRef  ctx, CGRect rect){

    //1.黑色绑带
    CGFloat startX = rect.size.width * 0.5 - YTRadius - 3;
    CGFloat startY = YTTopY;
    CGContextMoveToPoint(ctx, startX, startY);
    
    CGFloat endY = startY;
    CGFloat endX = startX + YTRadius * 2 + 6;
    CGContextAddLineToPoint(ctx, endX, endY);
    
    //设置线宽
    CGContextSetLineWidth(ctx, 20);
    
    //绘制线条
    CGContextStrokePath(ctx);
    
    //2.最外圈的镜框
    //a.外面黑色框
    //左眼
    [YTColor(61, 62, 66) set];
    CGFloat kuangRadius = YTRadius * 0.4;
    CGFloat kuangY = startY;
    CGFloat kuangX = rect.size.width * 0.5 - kuangRadius;
    CGContextAddArc(ctx, kuangX, kuangY, kuangRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
    
    //b.里面的白色框
    [[UIColor whiteColor] set];
    CGFloat whiteRadius = kuangRadius * 0.7f;
    
    CGContextAddArc(ctx, kuangX, kuangY, whiteRadius, 0, M_PI * 2, 0);
    
    CGContextFillPath(ctx);
    
    //c.里面的褐色框
    [YTColor(102, 19, 14) set];
    CGFloat brownX = rect.size.width * 0.5 * 0.83;
    CGFloat brownY = kuangY;
    CGFloat brownRadius = kuangRadius * 0.35;
    
    CGContextAddArc(ctx, brownX, brownY, brownRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
    
    //d.里面的褐色
    [[UIColor blackColor] set];
    CGFloat blackX = brownX;
    CGFloat blackY = brownY;
    CGFloat blackRadius = brownRadius * 0.5;
    
    CGContextAddArc(ctx, blackX, blackY, blackRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
    
    //e.里面的白色
    [[UIColor whiteColor] set];
    CGFloat swhiteX = blackX - blackRadius * 0.5;
    CGFloat swhiteY = blackY - blackRadius * 0.5;
    CGFloat swhiteRadius = blackRadius * 0.5;
    CGContextAddArc(ctx, swhiteX, swhiteY, swhiteRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
    
    
}

#pragma mark - 画嘴
void drawZui(CGContextRef  ctx, CGRect rect){

    //中间的控制点
    CGFloat controlX = rect.size.width * 0.5;
    CGFloat controlY = rect.size.height * 0.5;
    //当前点
    CGFloat margeinX = 50;
    CGFloat margeinY = 20;
    CGFloat currentX = controlX - margeinX;
    CGFloat currentY = controlY - margeinY;
    CGContextMoveToPoint(ctx, currentX, currentY);
    
    //结束点
    CGFloat endX = controlX + margeinX;
    CGFloat endY = currentY;
    
    //贝塞尔曲线
    CGContextAddQuadCurveToPoint(ctx, controlX, controlY, endX, endY);
    
    //设置颜色
    [[UIColor blackColor] set];
    
    //设置线宽
    CGContextSetLineWidth(ctx, 5);
    
    //渲染
    CGContextStrokePath(ctx);
}

#pragma mark - 画身体
void drawBody(CGContextRef  ctx, CGRect rect){

    //上半圆
    CGFloat topX = rect.size.width * 0.5;
    CGFloat topY = YTTopY;
    CGFloat topRadius = YTRadius;
    //参数：a.上下文  b、c.圆弧的最高点  d.起始角度 c.终点角度 d.是否顺时针
    CGContextAddArc(ctx, topX, topY, topRadius, 0, M_PI, 1);
    
    //向下延伸
    CGFloat middleX = topX - topRadius;
    CGFloat middleH = YTHeight; //中间身体的高度
    CGFloat middleY = topY + middleH;
    CGContextAddLineToPoint(ctx, middleX, middleY);
    
    //下半圆
    CGFloat bottomX = topX;
    CGFloat bottomY = middleY;
    CGFloat bottomRadius = topRadius;
    CGContextAddArc(ctx,bottomX, bottomY, bottomRadius, M_PI, 0, 1);
    
    //合并路径
    CGContextClosePath(ctx);
    
    //设置颜色
    [YTColor(252, 218, 0) set];
    
    //利用填充方式画出之前的路径
    //    CGContextStrokePath(ctx);
    CGContextFillPath(ctx);
    
}


@end
