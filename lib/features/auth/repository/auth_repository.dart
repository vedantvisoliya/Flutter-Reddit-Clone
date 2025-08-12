import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/core/constants/firebase_constants.dart';
import 'package:reddit_clone/core/failure.dart';
import 'package:reddit_clone/core/providers/firebase_providers.dart';
import 'package:reddit_clone/core/type_def.dart';
import 'package:reddit_clone/models/user_model.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firebaseAuth: ref.read(firebaseAuthProvider), 
    firestore: ref.read(firestoreProvider), 
    googleSignIn: ref.read(googleSinInProvider), 
    googleAuthProvider: ref.read(googleAuthProvider),
  )
);

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;
  final GoogleAuthProvider _googleAuthProvider;

  AuthRepository({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
    required GoogleSignIn googleSignIn,
    required GoogleAuthProvider googleAuthProvider,
  }) : _firebaseAuth = firebaseAuth,
       _firestore = firestore,
       _googleSignIn = googleSignIn,
       _googleAuthProvider = googleAuthProvider;

  CollectionReference get _users => _firestore.collection(FirebaseConstants.userCollection);

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map((event) => UserModel.formMap(event.data() as Map<String, dynamic>));
  }

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();


  FutureEither<UserModel> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final GoogleAuthProvider googleProvider = _googleAuthProvider;
        UserCredential credential = await _firebaseAuth.signInWithPopup(googleProvider);

        UserModel userModel;

        if (credential.additionalUserInfo!.isNewUser) {
          userModel = UserModel(
            name: credential.user!.displayName ?? "No Name", 
            profilePic: credential.user!.photoURL ?? Constants.avatarDefault, 
            banner: Constants.bannerDefault, 
            uid: credential.user!.uid, 
            isAuthenticated: true, 
            karma: 0, 
            awards: [],
          );
          await _users.doc(credential.user!.uid).set(userModel.toMap());
        }
        else {
          userModel = await getUserData(credential.user!.uid).first;
          return right(userModel);
        }

        return right(userModel);
      }

      else {
        final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
        final googleAuth = googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

        UserModel userModel;

        if (userCredential.additionalUserInfo!.isNewUser) {
          userModel = UserModel(
            name: userCredential.user!.displayName ?? "No Name", 
            profilePic: userCredential.user!.photoURL ?? Constants.avatarDefault, 
            banner: Constants.bannerDefault, 
            uid: userCredential.user!.uid, 
            isAuthenticated: true, 
            karma: 0, 
            awards: [],
          );
          await _users.doc(userCredential.user!.uid).set(userModel.toMap());
        }
        else {
          userModel = await getUserData(userCredential.user!.uid).first;
          return right(userModel);
        }
        return right(userModel);
      }

    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
    catch (e){
      return left(Failure(e.toString()));
    }
  }
}