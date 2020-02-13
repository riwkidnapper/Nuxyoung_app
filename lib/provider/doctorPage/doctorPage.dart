library doctorpage;

import 'package:chewie/chewie.dart';
import 'package:nuxyoung/Pages/doctor_page/extension/timedialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nuxyoung/provider/medical.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuxyoung/provider/auth.dart';
import 'package:nuxyoung/package/image_picker.dart';
import 'package:flutter/foundation.dart';



// import 'package:path/path.dart';


part '../../Pages/doctor_page/symptoms.dart';
part '../../Pages/doctor_page/register.dart';
part '../../Pages/doctor_page/register_medical.dart';
