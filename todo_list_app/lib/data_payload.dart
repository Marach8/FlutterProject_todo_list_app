import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@immutable 
class UserPayload extends MapView<String, String>{
  UserPayload({
    required String username, 
    required String email, 
    required String password,
    required  String uid
  }): super(
    {
      'username': username,
      'email': email,
      'password': password,
      'user-uid': uid,
      'datetime-of-registration': DateFormat('yyyy-MM-dd hh:mm a')
        .format(DateTime.now()),
    }
  );
}


@immutable 
class TodoPayload extends MapView<String, String>{
  TodoPayload({
    required String title,
    required String dueDateTime,
    required String content,
    required String uid
  }):super(
    {
      'title': title,
      'due-datetime': dueDateTime,
      'content': content,
      'user-uid': uid,
      'datetime-of-creation': DateFormat('yyyy-MM-dd hh:mm a')
        .format(DateTime.now())
    }
  );
}