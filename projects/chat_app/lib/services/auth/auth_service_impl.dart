import 'dart:async';
import 'dart:io';

import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthServiceImpl implements AuthService {
  static ChatUser? _currentUser;
  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();

    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);
      controller.add(_currentUser);
    }
  });

  @override
  ChatUser? get getCurrentUser => _currentUser;

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signup(
    String email,
    String password,
    String name,
    File? image,
  ) async {
    final auth = FirebaseAuth.instance;

    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) return;

    final imageName = '${credential.user!.uid}.jpg';
    final imageUrl = await _uploadImage(image, imageName);

    await credential.user?.updateDisplayName(name);
    await credential.user?.updatePhotoURL(imageUrl);

    await _saveChatUser(_toChatUser(credential.user!, imageUrl));
  }

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  static ChatUser _toChatUser(User user, [String? image]) {
    return ChatUser(
      id: user.uid,
      name: user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      image: image ?? user.photoURL ?? 'assets/images/avatar.png',
    );
  }

  Future<String?> _uploadImage(File? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_image').child(imageName);

    await imageRef.putFile(image).whenComplete(() {});

    return await imageRef.getDownloadURL();
  }

  Future<void> _saveChatUser(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    await docRef.set({
      'name': user.name,
      'email': user.email,
      'image': user.image,
    });
  }
}
