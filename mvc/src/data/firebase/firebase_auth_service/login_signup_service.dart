part of firebase_layer;

class LoginSignupService {
  final UsersDBServices services;

  LoginSignupService({required this.services});
  Future<void> signup(
      {required String email,
      required String password,
      required String name}) async {
    final UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user!.updateDisplayName(name);
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();

    final UsersModel usersModel = UsersModel(
      name: name,
      uid: FirebaseAuth.instance.currentUser!.uid,
      email: email,
      isAdmin: false,
      isActive: true,
    );
    await services.saveUser(usersModel: usersModel);
  }

  Future<void> login({required String email, required String password}) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      FirebaseAuth.instance.currentUser!.displayName.toString();
    } on Exception catch (e) {
      print('exception: $e');
    }
  }

  Future<void> facebookLogin() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }
}
