// import 'package:bloc_test/bloc_test.dart';
// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:weather_app/data/firebase/firebase_layer.dart';
// import 'package:weather_app/data/weather/weather_data.dart';
// import 'package:weather_app/domain/weather/weather_domain.dart';
// import 'package:weather_app/presentation/detail/bloc/detail_bloc.dart';
//
// import '../../../domain/weather/use_cases/get_weather_use_cases_test.dart';
//
// void main() {
//   final WeatherUseCases _useCase = WeatherUseCaseMock();
//   late DetailBloc _bloc;
//   final instance = FakeFirebaseFirestore();
//
//   setUpAll(() {
//     _bloc = DetailBloc(
//       useCases: _useCase,
//       services: instance,
//     );
//   });
//   group('Test load event', () {
//     blocTest<DetailBloc, DetailState>("Emit success state",
//         build: () => _bloc,
//         act: (DetailBloc bloc) {
//           when(() => _useCase.getDetail(
//                 unit: "",
//                 countryName: "",
//               )).thenAnswer(
//             (_) async => DetailModel(),
//           );
//
//           bloc.add(
//             DetailLoadEvent(
//               countryName: '',
//             ),
//           );
//         },
//         expect: () => <DetailState>[
//               DetailLoadingState(),
//               DetailLoadedState(
//                   detailModel: DetailModel(), listFav: [FavoritesModel()]),
//             ],
//         verify: (DetailBloc bloc) {
//           verify(() => _useCase.getDetail(
//                 unit: "",
//                 countryName: "",
//               )).called(1);
//         });
//
//     // blocTest<SaleChannelManagementBloc, SaleChannelManagementState>(
//     //   "Emit [SaleChannelFailState] when call SaleChannelManagementLoadEvent fail",
//     //   build: () => saleChannelManagementBloc,
//     //   act: (SaleChannelManagementBloc bloc) {
//     //     when(() => mockFetchSaleChannelUseCase(
//     //           limit: 10,
//     //           page: 1,
//     //           outletId: 1,
//     //         )).thenThrow(fakeException);
//     //
//     //     bloc.add(const SaleChannelManagementLoadEvent(
//     //       limit: 10,
//     //       page: 1,
//     //       outletId: 1,
//     //     ));
//     //   },
//     //   expect: () => <SaleChannelManagementState>[
//     //     SaleChannelManagementLoadingState(),
//     //     SaleChannelManagementFailureState(apiException: fakeException),
//     //   ],
//     // );
//   });
// }
