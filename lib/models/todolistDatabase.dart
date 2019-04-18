
class TodoData {
    int _id;
    String _task;


    TodoData(this._task);
    TodoData.withId(this._id,this._task);



    int get id => _id; 
    String get task => _task;

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
        return map;
    }

      TodoData.fromMapObject(Map<String, dynamic> map) {
        this._id = map['id'];
        this._task = map['task'];
    }
}