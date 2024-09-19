import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_second/models/task_model.dart';

class FirebaseManager{

  static FirebaseManager? instance;

  static FirebaseManager getInstance()
  {
    instance ??= FirebaseManager();
    return instance!;
  }

  late FirebaseFirestore firestore;

  FirebaseManager()
  {
    firestore = FirebaseFirestore.instance;
  }

  Future<List<Task>> getTasks() async
  {
    CollectionReference tasks = firestore.collection('tasks');
    var d = await tasks.get();


    return List<Task>.from(d.docs.map((doc) => Task.fromJson(doc.data() as Map<String, dynamic>)));
  }

  void addTask(Task task)
  {
    firestore.collection('tasks').doc(task.id).set(task.toJson());
  }

  void updateTask(Task task)
  {
    firestore.collection('tasks').doc(task.id).update(task.toJson());
  }

  void deleteTask(Task task)
  {
    firestore.collection('tasks').doc(task.id).delete();
  }
}