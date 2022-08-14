import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../data/country/country_data.dart';
import '../../../../../utils/utils_layer.dart';
import '../../../../detail/detail_route.dart';

class SearchResultWidget extends StatefulWidget {
  const SearchResultWidget({
    Key? key,
    required this.countryModel,
  }) : super(key: key);

  final List<CountryModel> countryModel;

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  User? user;

  onRefresh(userCred) {
    setState(() {
      user = userCred;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemBuilder: (context, index) => Card(
            child: ListTile(
                title: Text(
                  widget.countryModel[index].name?.common ?? '',
                ),
                onTap: () async {
                  // if (user != null) {
                  // context.read<SearchBloc>().add(
                  //       SearchAddEvent(
                  //         woeid: widget.state.locationModel!
                  //             .elementAt(index)
                  //             .woeid,
                  //         favorite: false,
                  //         locationName: widget.state.locationModel!
                  //             .elementAt(index)
                  //             .title
                  //             .toString(),
                  //         docID:
                  //             '${widget.state.locationModel!.elementAt(index).title} - ${FirebaseAuth.instance.currentUser!.uid}',
                  //       ),
                  //     );
                  //
                  //   await loginNavigator(
                  //     context,
                  //     index,
                  //   );
                  // } else {
                  //   await notLoginNavigator(context, index);
                  // }

                  await Navigator.pushNamed(
                    context,
                    RouteDefine.detailScreen.name,
                    arguments: DetailArgument(
                      cityName: widget.countryModel[index].capital?.first ?? '',
                      countryName:
                          widget.countryModel[index].name?.common ?? '',
                    ),
                  );
                }),
          ),
          itemCount: widget.countryModel.length,
        ),
      ),
    );
  }

// Future notLoginNavigator(BuildContext context, int index) async {
//   return Navigator.pushNamed(
//     context,
//     RouteDefine.detailScreen.name,
//     arguments: DetailArguments(
//       locationModel: LocationModel(
//         locationType:
//             widget.state.locationModel!.elementAt(index).locationType,
//         woeid: widget.state.locationModel!.elementAt(index).woeid,
//         lattLong: widget.state.locationModel!.elementAt(index).lattLong,
//         title: widget.state.locationModel!.elementAt(index).title,
//       ),
//     ),
//   );
}

// Future loginNavigator(
//   BuildContext context,
//   int index,
// ) async {
//   return Navigator.pushNamed(
//     context,
//     RouteDefine.detailScreen.name,
//     arguments: DetailArguments(
//       docID: widget.state.favoritesModel!.elementAt(index).docID,
//       favoritesModel: FavoritesModel(
//         favorite: widget.state.favoritesModel!.elementAt(index).favorite,
//         docID: widget.state.favoritesModel!.elementAt(index).docID,
//       ),
//       locationModel: LocationModel(
//         locationType:
//             widget.state.locationModel!.elementAt(index).locationType,
//         woeid: widget.state.locationModel!.elementAt(index).woeid,
//         lattLong: widget.state.locationModel!.elementAt(index).lattLong,
//         title: widget.state.locationModel!.elementAt(index).title,
//       ),
//     ),
//   );
// }
