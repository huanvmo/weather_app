import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/data/weather/weather_data.dart';

void main() {
  final instance = FakeFirebaseFirestore();
  Map<String,dynamic> _getData;

  setUpAll(() async {
    instance.collection("favorites");
    _getData = await instance.collection('favorites').doc('').collection('countryName').get();
  });

  test('Get favorites', () {
    final _data = {
      "countryName": "VietNam",
      "cityName":"HaNoi"
    };
    when(
          () => instance.collection('favorites').doc('').collection('countryName').get(),
    ).thenAnswer(
          (_) => Future.value(
            {
              "users": {
                "8k3nxCWDU2JkXQKGXhev": {
                  "username": "Bob"
                }
              }
            },
      ),
    );
    expect(_repo.getCountryName(countryName: ''), isNotNull);
    verify(() => _api.getCountryName('')).called(1);
  });
}