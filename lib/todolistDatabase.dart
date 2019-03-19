import 'dart:convert';

TodoData todoListFromJson(String str) {
    final jsonData = json.decode(str);
    return TodoData.fromMap(jsonData);
}

String todoListToJson(TodoData data) {
    final dyn = data.toMap();
    return json.encode(dyn);
}

class TodoData {
    int id;
    String task;
    bool checked;

    TodoData({
        this.id,
        this.task,
        this.checked
    });

    factory TodoData.fromMap(Map<String, dynamic> json) => new TodoData(
        id: json["id"],
        task: json["task"],
        checked: json["checked"] == 1,
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "task": task,
        "checked" : checked,
    };
}