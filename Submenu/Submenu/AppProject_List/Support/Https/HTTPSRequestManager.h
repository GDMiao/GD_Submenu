//
//  HTTPSRequestManager.h
//  WECI
//
//  Created by Michael-Miao on 2018/3/7.
//  Copyright © 2018年 WECI. All rights reserved.
//  共用 AFHTTPSessionManager 网络请求类

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
typedef NS_ENUM(NSUInteger, RequestMethod) {
	Req_Get,
	Req_Post,
	Req_Put
};
@interface HTTPSRequestManager : NSObject

/*
网络检测
 */
+ (void)AFNetworkReachabilitynetstatus:(void (^)(AFNetworkReachabilityStatus status))netstatus;
/**
 HTTPS_Req Request parameters  return : success failure
 
 @param method GET/POST
 @param urlStr 接口路径
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)HTTPS_Req:(RequestMethod)method urlStr:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id object))success failure:(void (^)(NSError *error))failure;
/**
 HTTPS_Req Request parameters body (GET body -> nil ; POST body -> NSData) return : success failure netstatus
 
 @param method GET/POST
 @param urlStr 接口路径
 @param parameters 参数
 @param body body
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)HTTPS_Req:(RequestMethod)method urlStr:(NSString *)urlStr parameters:(id)parameters body:(id)body success:(void (^)(id object))success failure:(void (^)(NSError *error))failure;

/**
 HTTPS_Req Request parameters return : success failure netstatus
 
 @param method GET/POST
 @param urlStr 接口路径
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)HTTPS_Req:(RequestMethod)method urlStr:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id object))success failure:(void (^)(NSError *error))failure netstatus:(void (^)(AFNetworkReachabilityStatus status))netstatus;

/**
 上传方法
 
 @param uploadUrl 上传接口路径
 @param params 参数
 @param filePath 本来文件路径
 @param name 文件名
 @param progress 进度
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)HTTPS_upload:(NSString *)uploadUrl parameters:(id)params filePath:(NSString *)filePath name:(NSString *)name progress:(void (^)(NSProgress *))progress success:(void (^)(id object))success failure:(void (^)(NSError *))failure;


/**
 下载方法
 
 @param url 下载路径
 @param progress 下载进度
 @param destination destination URL处理的回调 targetPath:文件下载到沙盒中的临时路径 response:响应头信息
 @param failure 失败回调
 */
+ (void)HTTPS_download:(NSString *)url progress:(void (^)(NSProgress *progress))progress destination:(NSURL *(^)(NSURL *targetPath, NSURLResponse *response))destination failure:(void (^)(NSURLResponse * response, NSURL * filePath, NSError * error))failure;
@end
