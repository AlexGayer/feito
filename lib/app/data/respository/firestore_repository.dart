import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feito/app/domain/model/task.dart';
import 'package:injectable/injectable.dart';

abstract class FirestoreRepository {
  Future<void> addTask(Task task);
  Future<List<Task>> fetchTasks();
  Future<void> deleteTask(String taskId);
  Future<void> updateTask(String taskId, Map<String, dynamic> data);
}

@Injectable(as: FirestoreRepository)
class FirestoreRepositoryImpl implements FirestoreRepository {
  final FirebaseFirestore firestore;

  FirestoreRepositoryImpl(this.firestore);

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
}
