import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_list_second/firebase_options.dart';
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

  static Future init() async{
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
    //FirebaseManager m = FirebaseManager();
  }

  Future<List<Task>> getTasks() async
  {
    CollectionReference tasks = firestore.collection('tasks');
    var d = await tasks.get();


    return List<Task>.from(d.docs.map((doc) => Task.fromJson(doc.data() as Map<String, dynamic>)));
  }

  Future<void> addTask(Task task) async
  {
    await firestore.collection('tasks').add(task.toJson()).
    then((value) =>
        {
          print('task added'),
          task.id = value.id,
          updateTask(task),
        }
    );
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