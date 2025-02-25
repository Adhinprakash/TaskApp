
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:taskapp/controllers/task_controller.dart';
import 'package:taskapp/model/task_model.dart';
import 'package:taskapp/view/widgets/card_widget.dart';

class TaskListScreen extends StatelessWidget {
 final TaskController taskController = Get.put(TaskController());

   TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[300],
        title: const Text("Tasks",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
      
      ),
      body: Obx((){
        if(taskController.isloading.value){
        return  const Center(child: CircularProgressIndicator(color: Colors.white,),);
        }

// added a check here if the tasklist is empty then show the below texts
        if(taskController.tasks.isEmpty){
          return Center(
            child:Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
               

                SizedBox(
                        height: 100,
                        child: Lottie.asset(
                          'assets/animations/Animation - 1740474057338.json',
                          fit: BoxFit.contain,
                        ),
                      ),
                  const SizedBox(height: 6),
                  const Text(
                    'Your task list is empty!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Time to start organizing your day. Tap the + button below to create your first task and begin your journey to productivity!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          );
        }


// added a refreshindicator so to fetch the tasks by refresing


  return RefreshIndicator(child: Padding(padding: EdgeInsets.all(16),child:   ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];
            return Padding(padding:EdgeInsets.all(14) ,child:  CardWidget(title: task.title, description: task.description, onPressed: ()=>updatetask(context,task)),);
          },
        ),)
  , onRefresh: ()async{
await taskController.fetchTaskList();
  });
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){
_addTask(context);
      },
      child: const Icon(Icons.add,color: Colors.white,size: 26,),
      backgroundColor: Colors.blue[500],
      ),
    );
  }


// this is a function that responsible for the poppup dialoag for creatin task

  void _addTask(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    Get.defaultDialog(
      
          backgroundColor: Colors.blue.shade300,
  title: "Create task",
  titleStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.white),
      content: Column(
        children: [
          TextField(controller: titleController, decoration: InputDecoration(labelText: "Title",)),
          TextField(controller: descriptionController, decoration: InputDecoration(labelText: "Description")),
        ],
      ),
      confirm: ElevatedButton(
        
        onPressed: ()async {
      await    taskController.createTask(titleController.value.text, descriptionController.value.text);
          Get.back();
        },
        child: Text("create task"),
         style:ElevatedButton.styleFrom(
          
          backgroundColor: Colors.blue.shade400,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5,
        ),
      ),
    );
  }



// this is for updating poppu
void updatetask(BuildContext context,Task task){
  TextEditingController titletextcontroller=TextEditingController(text:task.title );
    TextEditingController descriptiontextcontroller=TextEditingController(text:task.description );

    Get.defaultDialog(
      
      backgroundColor: Colors.blue.shade300,

  title: "Update your task",
  titleStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.white),
      content: Column(
        children: [
          TextField(controller: titletextcontroller, decoration: const InputDecoration(labelText: "Title",)),
          TextField(controller: descriptiontextcontroller, decoration: const InputDecoration(labelText: "Description")),
        ],
      ),
      confirm: ElevatedButton(
        style:ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade400,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5,
        ),
        onPressed: ()async {
        await taskController.updatetask(titletextcontroller.text, descriptiontextcontroller.text, task.id) ; 
        },
        child: Text("Update"),
      ),

    );

}


}

