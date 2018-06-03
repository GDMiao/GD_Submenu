//
//  AFNHTTPSRequestManager.m
//  WECI
//
//  Created by Michael-Miao on 2018/3/7.
//  Copyright © 2018年 WECI. All rights reserved.
//

#import "HTTPSRequestManager.h"
AFHTTPSessionManager *netManager = nil;
@implementation HTTPSRequestManager

+ (AFHTTPSessionManager *)sharedManager
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		netManager = [AFHTTPSessionManager manager];
		netManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];//不设置会报-1016或者会有编码问题
		netManager.requestSerializer = [AFHTTPRequestSerializer serializer]; //不设置会报-1016或者会有编码问题
		netManager.responseSerializer = [AFHTTPResponseSerializer serializer]; //不设置会报 error 3840
		netManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/x-javascript", nil];


	});
	return netManager;
}

+ (void)AFNetworkReachabilitynetstatus:(void (^)(AFNetworkReachabilityStatus status))netstatus
{
	AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
	[manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
		// 当网络状态改变时调用
		switch (status) {
			case AFNetworkReachabilityStatusUnknown:
				NSLog(@"未知网络");
				break;
			case AFNetworkReachabilityStatusNotReachable:
				NSLog(@"没有网络");
				break;
			case AFNetworkReachabilityStatusReachableViaWWAN:
				NSLog(@"手机自带网络");
				break;
			case AFNetworkReachabilityStatusReachableViaWiFi:
				NSLog(@"WIFI");
				break;
		}
	
		if(netstatus){netstatus(status);}
	}];
	//开始监控
	[manager startMonitoring];

}



+ (void)HTTPS_Req:(RequestMethod)method urlStr:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
//	[HTTPSRequestManager AFNetworkReachabilitynetstatus:^(AFNetworkReachabilityStatus status) {
//		if (status == AFNetworkReachabilityStatusNotReachable) {
//			NSLog(@"无网络状态");
//			[MBProgressHUD showAutoMessage:@"网络连接失败！" ToView:kWindow];
//			return;
//		}
//	}];
	
	NSAssert(urlStr != nil, @"url不能为空");
	AFHTTPSessionManager * manager = [HTTPSRequestManager sharedManager];
	[manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
		if (status == AFNetworkReachabilityStatusNotReachable) {
			NSLog(@"无网络状态");
			//[MBProgressHUD showAutoMessage:@"网络连接失败！" ToView:kWindow];
			return;
		}
	}];
	switch (method) {
		case Req_Get:{
			[manager GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
				if (success) {
					success(responseObject);
				}
			} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
				if (failure) {
					failure(error);
				}
			}];
		}
			break;
		case Req_Post:{
			[manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
				if (success) {
					success(responseObject);
				}
			} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
				if (failure) {
					failure(error);
				}
			}];
		}
			break;
		case Req_Put:{
			manager.requestSerializer.HTTPMethodsEncodingParametersInURI = parameters;
			[manager PUT:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
				if (success) {
					success(responseObject);
				}
			} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
				if (failure) {
					failure(error);
				}
			}];
		}
			break;
		default:
			break;
	}
}

//
+ (void)HTTPS_Req:(RequestMethod)method urlStr:(NSString *)urlStr parameters:(id)parameters body:(id)body success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
	NSAssert(urlStr != nil, @"url不能为空");
	NSError *error;
	AFHTTPSessionManager * manager = [HTTPSRequestManager sharedManager];
	[manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
		if (status == AFNetworkReachabilityStatusNotReachable) {
			NSLog(@"无网络状态");
			//[MBProgressHUD showAutoMessage:@"网络连接失败！" ToView:kWindow];
			return;
		}
	}];
	switch (method) {
		case Req_Get:{
			[manager GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
				if (success) {
					success(responseObject);
				}
			} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
				if (failure) {
					failure(error);
				}
			}];
		}
			break;
		case Req_Post:{
			
			NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST"URLString:urlStr parameters:parameters error:&error];
			[request addValue:@"application/json"forHTTPHeaderField:@"content-type"];
			NSData *bodyData  =[NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:nil];
			[request setHTTPBody:bodyData];
			request.timeoutInterval = 30; 
			[[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
				
				//NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
				
				if (success && responseObject) {
					success(responseObject);
				}
				if (failure && error) {
					failure(error);
				}
			}] resume];
			
		}
			break;
		case Req_Put:{
			[manager PUT:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
				if (success) {
					success(responseObject);
				}
			} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
				if (failure) {
					failure(error);
				}
			}];
		}
			break;
		default:
			break;
	}
}

/**
 HTTPS_Req Request parameters return : success failure netstatus
 
 @param method GET/POST
 @param urlStr 接口路径
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)HTTPS_Req:(RequestMethod)method urlStr:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure netstatus:(void (^)(AFNetworkReachabilityStatus))netstatus
{
	NSAssert(urlStr != nil, @"url不能为空");
	AFHTTPSessionManager * manager = [HTTPSRequestManager sharedManager];
	[manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
		if (status == AFNetworkReachabilityStatusNotReachable) {
			NSLog(@"无网络状态");
			//[MBProgressHUD showAutoMessage:@"网络连接失败！" ToView:kWindow];
			return;
		}
		if (status ==  AFNetworkReachabilityStatusReachableViaWWAN) {
			NSLog(@"移动蜂窝网络");
			netstatus(status);
		}
		
	}];
	switch (method) {
		case Req_Get:{
			[manager GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
				if (success) {
					success(responseObject);
				}
			} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
				if (failure) {
					failure(error);
				}
			}];
		}
			break;
		case Req_Post:{
			[manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
				if (success) {
					success(responseObject);
				}
			} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
				if (failure) {
					failure(error);
				}
			}];
		}
			break;
		default:
			break;
	}
}

//
+ (void)HTTPS_upload:(NSString *)uploadUrl parameters:(id)params filePath:(NSString *)filePath name:(NSString *)name progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
	NSAssert(uploadUrl != nil, @"url不能为空");
	AFHTTPSessionManager *manager = [HTTPSRequestManager sharedManager];
	
	[manager POST:uploadUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
		
		/*
		 第一个参数:要上传的文件的URL
		 第二个参数:后台接口规定
		 第三个参数:错误信息
		 */
		[formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:name error:nil];
	} progress:^(NSProgress * _Nonnull uploadProgress) {
		
		if (progress) {
			progress(uploadProgress);
		}
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		
		if (success) {
			success(responseObject);
		}
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		
		if (failure) {
			failure(error);
		}
		
	}];
}

//
+(void)HTTPS_download:(NSString *)url progress:(void (^)(NSProgress *))progress destination:(NSURL *(^)(NSURL *, NSURLResponse *))destination failure:(void (^)(NSURLResponse *, NSURL *, NSError *))failure
{
	NSAssert(url != nil, @"url不能为空");
	// 1 创建会话管理者
	AFHTTPSessionManager *manager = [HTTPSRequestManager sharedManager];
	
	// 2 创建请求路径 请求对象
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	
	// 3 创建请求下载操作对象
	NSURLSessionDownloadTask *downTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
		
		if (progress) {
			progress(downloadProgress);
		}
		
	} destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
		
		if (destination) {
			return  destination(targetPath, response);
		} else {
			return nil;
		}
	} completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
		if (failure) {
			failure(response, filePath, error);
		}
	}];
	
	// 4 执行任务发送下载操作请求
	[downTask resume];
}


@end
