import 'package:geolocator/geolocator.dart';

String getChannelId(Position position, {double distanceMeters = 500}) {
  const double metersPerDegree = 111320.0;
  final double gridSize = distanceMeters / metersPerDegree;

  double roundDown(double value, double grid) =>
      (value / grid).floorToDouble() * grid;

  final latRounded = roundDown(position.latitude, gridSize);
  final lngRounded = roundDown(position.longitude, gridSize);

  return '${latRounded.toStringAsFixed(6)}_${lngRounded.toStringAsFixed(6)}_${distanceMeters.toInt()}m';
}
