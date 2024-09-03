import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';

class FirebaseError extends Failure{
  FirebaseError(super.message);
  
   factory FirebaseError.firebaseException(FirebaseAuthException error){
    switch(error.code){
      case 'user-not-found':
      return FirebaseError('No user found for that email');
       case 'user-disabled':
        return FirebaseError('The user corresponding to the given email has been disabled.');
      case 'wrong-password':
        return FirebaseError('The password is invalid for the given email.');
      case 'email-already-in-use':
        return FirebaseError('The email address is already in use by another account.');
      case 'operation-not-allowed':
        return FirebaseError('Email/password accounts are not enabled.');
      case 'weak-password':
        return FirebaseError('The password is too weak.');
      case 'too-many-requests':
        return FirebaseError('Too many requests. Please try again later.');
      default:
        return FirebaseError('An unexpected error occurred. Please try again.'); 
    }
   }
 
}