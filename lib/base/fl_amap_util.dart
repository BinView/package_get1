import 'package:bot_toast/bot_toast.dart';
import 'package:fl_amap/fl_amap.dart';

/// <summary>
/// author：zwb
/// dateTime： 2021/12/20 15:02
/// filePath： lib/util/fl_amap_util.dart
/// desc: 高德定位工具类
/// <summary>
///
class FlAmapUtil {
  static initialize() async {
    /// 初始化AMap
    await FlAMapLocation()
        .initialize(
          AMapLocationOption(),
        )
        .then(
          (value) => print("初始化AMap${value ? '成功' : '失败'}"),
        );
  }

  static Future<AMapLocation?> getLocation() async {
    /// 务必先初始化 并获取权限
    AMapLocation? location = await FlAMapLocation().getLocation(true);
    if (location!.code == 12) BotToast.showText(text: "当前缺少位置权限，当前无法获取位置");
    return location;
  }

  static dispose() {
    FlAMapLocation().dispose();
  }
}
