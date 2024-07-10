import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feito/app/domain/model/task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:injectable/injectable.dart';

abstract class FirestoreRepository {
  Future<void> addUser(String userId, String email, String displayName);
  Future<void> changePassword(String newPassword);
  Future<void> addTask(Task task);
  Future<List<Task>> fetchTasks();
  Future<void> deleteTask(String taskId);
  Future<void> updateTask(String taskId, Map<String, dynamic> data);
  Future<Map<String, String>?> getUserDetails(String userId);
  Future<String?> getUserPhotoURL(String userId); // Novo método adicionado
  Future<void> uploadUserImage(String userId, File imageFile);
}

@Injectable(as: FirestoreRepository)
class FirestoreRepositoryImpl implements FirestoreRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  FirestoreRepositoryImpl(this.firestore, this.auth);

  @override
  Future<void> addUser(String userId, String email, String displayName) async {
    try {
      await firestore.collection('users').doc(userId).set({
        'email': email,
        'displayName': displayName,
        // Adicione outros campos de usuário conforme necessário
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> changePassword(String newPassword) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
      } else {
        throw FirebaseAuthException(
            code: 'user-not-logged-in', message: 'User is not logged in.');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addTask(Task task) async {
    try {
      await firestore.collection('tasks').add(task.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Task>> fetchTasks() async {
    try {
      final querySnapshot = await firestore.collection('tasks').get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Adicionar o ID do documento ao mapa de dados
        return Task.fromJson(data);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      await firestore.collection('tasks').doc(taskId).delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateTask(String taskId, Map<String, dynamic> data) async {
    try {
      await firestore.collection('tasks').doc(taskId).update(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, String>?> getUserDetails(String userId) async {
    try {
      final docSnapshot = await firestore.collection('users').doc(userId).get();
      if (docSnapshot.exists) {
        final userData = docSnapshot.data() as Map<String, dynamic>;
        String? photoURL = userData['photoURL'];

        // Se tiver uma URL de foto, retorne junto com outros detalhes
        return {
          'displayName': userData['displayName'],
          'email': userData['email'],
          'photoURL':
              photoURL ?? '', // Pode ser vazio se não houver URL de foto
        };
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> getUserPhotoURL(String userId) async {
    try {
      final docSnapshot = await firestore.collection('users').doc(userId).get();
      if (docSnapshot.exists) {
        final userData = docSnapshot.data() as Map<String, dynamic>;
        return userData['photoURL'];
      }
      return null;
    } catch (e) {
      print('Erro ao obter URL da foto do usuário: $e');
      return null;
    }
  }

  @override
  Future<void> uploadUserImage(String userId, File imageFile) async {
    try {
      // Crie um caminho personalizado com o ID do usuário
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('user_images/$userId.jpg');

      // Upload da imagem para o Firebase Storage
      await storageRef.putFile(imageFile);

      // Obtenha a URL de download da imagem
      final imageUrl = await storageRef.getDownloadURL();

      // Atualize a URL da foto no Firestore
      await firestore.collection('users').doc(userId).update({
        'photoURL': imageUrl,
      });
    } catch (e) {
      print('Erro ao fazer upload da imagem para o Firebase Storage: $e');
      rethrow;
    }
  }
}
