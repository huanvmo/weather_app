part of firebase_layer;

class UsersDBServices {
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  Future saveUser({
    required UsersModel usersModel,
  }) async {
    try {
      await users.doc(usersModel.email).set(
            usersModel.toJson(),
          );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future getUser({
    required String email,
  }) async {
    try {
      final data = await users.doc(email).get();
      final user = UsersModel.fromJson(data.data() as Map<String, dynamic>);
      return user;
    } catch (e) {
      return false;
    }
  }

  Future updateUser({
    required UsersModel usersModel,
    required String email,
  }) async {
    try {
      await users.doc(email).update(
            usersModel.toJson(),
          );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future deleteUser({
    required String email,
  }) async {
    try {
      await users.doc(email).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<UsersModel>> getListUsers() {
    return users.snapshots().map((user) {
      return user.docs
          .map(
            (e) => UsersModel.fromJson(
              e.data() as Map<String, dynamic>,
            ),
          )
          .toList();
    });
  }

  Future<void> updateUserAvatar({required String photoUrl}) async {
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final _currentUser = FirebaseAuth.instance.currentUser!;

    final String storageRef = await firebaseStorage
        .ref('userAvatar/${_currentUser.uid}')
        .putFile(
          File(photoUrl),
        )
        .snapshot
        .ref
        .getDownloadURL();

    await FirebaseAuth.instance.currentUser!.updatePhotoURL(storageRef);
    final UsersModel _model = UsersModel(avatarUrl: storageRef);
    await updateUser(
      usersModel: _model,
      email: _currentUser.email ?? '',
    );
  }

  Future<void> updateUserDisplayName({required String userName}) async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(
      userName,
    );
    final _currentUser = FirebaseAuth.instance.currentUser!;

    final UsersModel _model = UsersModel(name: userName);
    await updateUser(
      usersModel: _model,
      email: _currentUser.email ?? '',
    );
  }
}
