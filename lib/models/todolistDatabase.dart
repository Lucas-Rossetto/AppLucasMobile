import 'dart:convert';

// TodoData todoListFromJson(String str) {
//     final jsonData = json.decode(str);
//     return TodoData.fromMap(jsonData);
// }

// String todoListToJson(TodoData data) {
//     final dyn = data.toMap();
//     return json.encode(dyn);
// }

class TodoData {
    int _id;
    String _task;
    bool _checked;

    TodoData(this._id,this._task,this._checked);

    int get id => id; 
    String get task => _task;
    bool get checked => _checked;

    set task(String newTask) {

        if(newTask.length <= 480) {
          this._task = newTask;
        }
    }



    Map<String, dynamic> toMap(){
      var map = Map<String, dynamic>();
        if(id != null) {
          map['id'] = _id;
        }
        if(task != null) {
        map['task'] = _task;
        }
        if(checked != null) {
        map['checked'] = _checked;
        }
        return map;
    }

      TodoData.fromMapObject(Map<String, dynamic> map) {
        this._id = map['id'];
        this._task = map['task'];
        this._checked = map['checked'];
    }
}