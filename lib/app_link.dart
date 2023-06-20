// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:uni_links/uni_links.dart';
//
// 在你的起始 Widget State 加入
// _appLinkInit() async {
//  AppLink.handleIncomingLinks(context);
//  await AppLink.handleInitialUri(context);
// }
//
// @override
// void initState() {
//  super.initState();
//  WidgetsBinding.instance.addPostFrameCallback((_) {
//    _appLinkInit();
//  });
// }
//
// class AppLink {
//
//   static void handleIncomingLinks(BuildContext context) {
//     uriLinkStream.listen((Uri? uri) {
//       if (uri != null) {
//         try {
//           path(context, uri);
//         } catch (e) {
//           print(e);
//         }
//       }
//     },
//     onError: (Object err) {});
//   }
//
//   static Future handleInitialUri(BuildContext context) async {
//     try {
//       final uri = await getInitialUri();
//       if (uri != null) {
//         path(context, uri);
//       }
//       // ignore: empty_catches
//     } on FormatException {}
//   }
//   static Future<bool> path(BuildContext context, Uri? uri) async {
//     if (uri == null) return false;
//
//     try {
//       // 掃描支付 /download?store_id={store_id}
//       if (uri.path == '/download' && uri.queryParameters['store_id'] != null) {
//         _pay(context, uri);
//         return true;
//       }
//
//       // 最新消息 /member/news/{id}
//       if (uri.pathSegments.length == 3 && uri.pathSegments[0] == 'member' && uri.pathSegments[1] == 'news') {
//         _news(context, uri);
//         return true;
//       }
//
//       // 店家內頁 /store/{slug}
//       if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'store') {
//         _store(context, uri);
//         return true;
//       }
//     } catch (e) {
//       print(e);
//     }
//
//     return false;
//   }
//
//   static _pay(BuildContext context, Uri uri) async {
//     String storeId = uri.queryParameters['store_id'] ?? '';
//     // open pay page
//   }
//
//   static _news(BuildContext context, Uri uri) {
//     int id = int.parse(uri.pathSegments[2]);
//     // open news page
//   }
//
//   static _store(BuildContext context, Uri uri) {
//     String slug = uri.pathSegments[1];
//     // open store page
//   }
// }