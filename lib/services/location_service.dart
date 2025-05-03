// lib/services/location_service.dart
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position?> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled || permission == LocationPermission.deniedForever) {
      return null;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        return null;
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  List<String> getNearbyChannels(Position position) {
    // 示例实现：根据经纬度四舍五入生成网格频道名
    final latGrid = (position.latitude * 100).round(); // 缩放为整数
    final lngGrid = (position.longitude * 100).round();

    return List.generate(5, (i) {
      return '频道_${latGrid + i}_${lngGrid + i}'; // 示例频道名
    });
  }
}
