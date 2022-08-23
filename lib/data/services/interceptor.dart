import 'package:dio/dio.dart';
import 'package:flutter_template/utils/shared_prefs.dart';
import 'package:flutter_template/utils/constants.dart' as constants;

import 'api_helper.dart';

Dio addInterceptors(Dio dio, bool basicAuth) {
  return dio
    ..interceptors.add(
      basicAuth ? _getBasicInterceptor(dio) : _getProtectedInterceptor(dio),
    );
}

InterceptorsWrapper _getBasicInterceptor(Dio dio) {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers['Authorization'] = 'Basic ${constants.basicToken}';
      return handler.next(options);
    },
    onError: (error, handler) {
      return handler.next(error);
    },
  );
}

InterceptorsWrapper _getProtectedInterceptor(Dio dio) {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      if (ApiHelper.token == null) {
        dio.lock();

        ApiHelper.getRefreshToken().then((response) {
          ApiHelper.token = response?.data['access_token'];
          SharedPrefs.setRefreshToken(refreshToken: response?.data['refresh_token']);
          options.headers['Authorization'] = 'Bearer ${ApiHelper.token}';
          handler.next(options);
        }).catchError((error, stackTrace) {
          handler.reject(error, true);
        }).whenComplete(() => dio.unlock()); // unlock the dio
      } else {
        options.headers['Authorization'] = 'Bearer ${ApiHelper.token}';
        return handler.next(options);
      }
    },
    onError: (error, handler) {
      //print(error);
      // Assume 401 stands for token expired
      if (error.response?.statusCode == 401) {
        final options = error.response!.requestOptions;
        // If the token has been updated, repeat directly.
        if ('Bearer ${ApiHelper.token}' != options.headers['Authorization']) {
          options.headers['Authorization'] = 'Bearer ${ApiHelper.token}';
          //repeat
          dio.fetch(options).then(
            (r) => handler.resolve(r),
            onError: (e) {
              handler.reject(e);
            },
          );
          return;
        }
        // update token and repeat
        // Lock to block the incoming request until the token updated
        dio.lock();
        dio.interceptors.responseLock.lock();
        dio.interceptors.errorLock.lock();

        ApiHelper.getRefreshToken().then((response) {
          //update token
          ApiHelper.token = response?.data['access_token'];
          SharedPrefs.setRefreshToken(refreshToken: response?.data['refresh_token']);
          options.headers['Authorization'] = 'Bearer ${ApiHelper.token}';
        }).whenComplete(() {
          dio.unlock();
          dio.interceptors.responseLock.unlock();
          dio.interceptors.errorLock.unlock();
        }).then((e) {
          //repeat
          dio.fetch(options).then(
            (r) => handler.resolve(r),
            onError: (e) {
              handler.reject(e);
            },
          );
        });
        return;
      }
      return handler.next(error);
    },
  );
}
