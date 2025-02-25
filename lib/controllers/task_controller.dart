import 'dart:convert';

import 'package:get/get.dart';
import 'package:taskapp/model/task_model.dart';
import 'package:taskapp/utils/api_endpoints.dart';
import 'package:http/http.dart'as http;
class TaskController extends GetxController{
var tasks =<Task>[].obs;
RxBool isloading=false.obs;


// this function will call when the taskController created
@override
  void onInit() {
    super.onInit();
    fetchTaskList();
  }

// fetch all the tasks
Future<void>fetchTaskList()async{
final url =buildBaseUrl('/tasks');
isloading.value=true;
try {
  final response= await http.get(url);

  if(response.statusCode==200){
    var jsondata=jsonDecode(response.body);
var tasklist=(jsondata['tasks']as List).map((task)=>Task.fromJson(task)).toList();
tasks.addAll(tasklist);

  }else{
     Get.snackbar("Error", "Failed to fetch tasks");

  }
} catch (e) {
        Get.snackbar("Error", "Something went wrong: $e");

}
isloading.value=false;
}


 Future<void> createTask(String title, String description) async {
  final url =buildBaseUrl('/task');
    try {
      final response = await http.post(url,
        headers: {'Content-Type': 'application/json',"Accept": "application/json",},
        body: jsonEncode({
          "title": title,
          "description": description,
          "isCompleted": false
        }),
      );

      if (response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        Task newTask = Task.fromJson(jsonData['task']);
        tasks.add(newTask);
        Get.back();
        Get.snackbar("Success", "Task created successfully");
      } else {
        Get.snackbar("Error", "Failed to create task");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }



// update the existing tasks

 Future<void> updatetask(String title, String description,String id) async {
  final url =buildBaseUrl('/task');
  print(id);
    try {
      final response = await http.put(url,
        headers: {'Content-Type': 'application/json',"Accept": "application/json",},
        body: jsonEncode({
          'id':id,
          "title": title,
          "description": description,
          "isCompleted": true
        }),
      );

      if (response.statusCode == 200) {
        int index = tasks.indexWhere((task) => task.id == id);
        if (index != -1) {
          tasks[index].title = title;
          tasks[index].description = description;
          tasks.refresh();
          Get.back();
        }
        Get.snackbar("Success", "Task updated successfully");
      } else {
        Get.snackbar("Error", "Failed to update task");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }




}