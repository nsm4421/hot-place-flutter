import 'package:geolocator/geolocator.dart';
import 'package:hot_place/data/model/map/place/place.model.dart';

import '../../../core/util/page.util.dart';

abstract class MapDataSource {
  Future<Position> getCurrentLocation();

  Future<CustomPageable<PlaceModel>> searchPlaces(String keyword,
      {int? page, int? size});
}