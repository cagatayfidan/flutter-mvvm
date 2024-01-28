import 'package:flutter/material.dart';

class TodoForm extends StatefulWidget {
  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Form"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                validator: (value) {
                  if (value?.length == 0)
                    return "İsim alanı en az 3 karakter olmalıdır";
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "I want",
                    hintText: "to do",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
