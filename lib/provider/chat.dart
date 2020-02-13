library chat;

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuxyoung/provider/medical.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:io';
import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nuxyoung/provider/Tool.dart';
import 'package:nuxyoung/provider/tabbar.dart';
// import 'package:firebase_storage/firebase_storage.dart';

part '../Pages/chat/chat_screen.dart';
part '../Pages/chat/realtimeChat.dart';