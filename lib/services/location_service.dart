import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart'; // 可删掉

class LocationService {
  // 获取定位权限并处理用户的响应
  Future<bool> _handleLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    // 如果从未请求过权限，发起请求
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('用户拒绝了定位权限');
        return false;
      }
    }

    // 用户永久拒绝权限，需要引导用户到系统设置中打开
    if (permission == LocationPermission.deniedForever) {
      print('定位权限被永久拒绝，无法再次请求');
      await Geolocator.openAppSettings(); // 注意使用 geolocator 的 openAppSettings
      return false;
    }

    // 权限可用
    return true;
  }

  // 获取当前位置信息
  Future<Position?> getCurrentPosition() async {
    try {
      bool hasPermission = await _handleLocationPermission();
      if (!hasPermission) return null;

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print('定位成功: $position');
      return position;
    } catch (e) {
      print('定位失败: $e');
      return null;
    }
  }

  // 模拟附近商圈列表（后续可接 API）
  List<String> getNearbyChannels(Position position) {
    if (position.latitude > 39.90 && position.latitude < 39.92) {
      return ['北京王府井地铁站', '北京协和医院', '北京银泰中心', '星巴克(王府井店)'];
    }
    return ['上海陆家嘴地铁站', '上海环球金融中心', '上海正大广场', '星巴克(陆家嘴店)'];
  }
}
