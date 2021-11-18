import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todolist_cubit.dart';
import 'package:todo_app/screens/screens.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BlocProvider(
      create: (context) => TodolistCubit(),
      child:  HomeScreen(),
    ),
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xffffffff),
        iconTheme: IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle.dark
      )
    ),

  ));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xffffffff),
  ));
}

