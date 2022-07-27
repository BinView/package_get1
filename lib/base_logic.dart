import 'dart:async';

import 'package:fl_amap/fl_amap.dart';
import 'package:get/get.dart';

import 'base/fl_amap_util.dart';

/// <summary>
/// todo: 基础控制器 包括公共方法、变量、对象等
/// author：zwb
/// dateTime： 2021/11/19 14:31
/// filePath： lib/getx/base_logic.dart
/// desc:
/// <summary>
///
class BaseLogic extends GetxController {
  /// todo：模态框控制器
  bool loading = false;
  int getTimeDown = 60; // 当前倒计时 用于页面显示
  int setTimeLent = 60; // 倒计时长度
  Timer? _timerDown; // 倒计时控制器
  String? local = "未知位置"; // 位置名称
  LatLong? latLong; // 经纬度
  late AMapLocation aMapLocation;

  /// 获取位置 高德
  Future<Null> getLocation({Function(AMapLocation)? resp}) async {
    await FlAmapUtil.initialize();
    aMapLocation = await FlAmapUtil.getLocation() ?? AMapLocation(); // 获取定位
    if (aMapLocation.code == 0) {
      local = aMapLocation.province! + aMapLocation.city!;
      latLong = aMapLocation.latLong;
      if (resp != null) resp(aMapLocation);
    }
    update();
  }

  /// 关闭定位 高德
  closeLocation() {
    FlAmapUtil.dispose();
  }

  /// todo：开启模态框
  void start() {
    loading = true;
    update();
  }

  /// todo：关闭模态框
  void close() {
    loading = false;
    update();
  }

  /// todo：发送验证码
  void sendCode() {
    /// todo： 发送成功 开始倒计时
    if (1 == 1) {
      startTimeDown();
    }
  }

  /// todo：验证码倒计时
  void startTimeDown() {
    print("开始倒计时");
    _timerDown = Timer.periodic(Duration(seconds: 1), (timer) {
      if (getTimeDown-- == 0) endTimeDown();
      update();
    });
  }

  /// todo：结束倒计时
  void endTimeDown() {
    if (_timerDown != null) {
      _timerDown?.cancel();
      getTimeDown = setTimeLent;
      print("倒计时结束");
      update();
    }
  }

  /// todo：页面销毁时的处理
  _closePage() {
    endTimeDown();
    close();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _closePage();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _closePage();
  }
}
