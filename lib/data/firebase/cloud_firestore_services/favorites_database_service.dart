part of firebase_layer;

class FavoritesDBServices {
  final CollectionReference favorite =
      FirebaseFirestore.instance.collection("favorites");

  Future<List<FavoritesModel>> getFav({required String uid}) async {
    try {
      final List<FavoritesModel> _listModel = [];
      final favQuery = await favorite.doc(uid).collection("countryName").get();

      await Future.forEach<QueryDocumentSnapshot<Map<String, dynamic>>>(
          favQuery.docs, (element) {
        final FavoritesModel _model = FavoritesModel.fromJson(element.data());

        _listModel.add(_model);
      });
      return _listModel;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future deleteFav({required String uid,required String docId}) async {
    try {
      await favorite.doc(uid).collection("countryName").doc(docId).delete();
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future updateFav(
      {required FavoritesModel favoritesModel, required String uid}) async {
    try {
      await favorite.doc(uid).update(
            favoritesModel.toJson(),
          );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> favoriteUpdate({
    required FavoritesModel favoritesModel,
    required String uid,
  }) async {
    await updateFav(
      uid: uid,
      favoritesModel: favoritesModel,
    );
  }

  Future<void> favoriteAdd({
    required FavoritesModel favoritesModel,
    required String uid,
  }) async {
    try {
      await favorite
          .doc(uid)
          .collection('countryName')
          .doc(favoritesModel.countryName)
          .set(
            favoritesModel.toJson(),
          );
    } catch (e) {
      throw Exception(e);
    }
  }
}
