// Padding(
//         padding: EdgeInsets.all(10),
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               FormBuilder(
//                 // context,
//                 key: _fbKey,
//                 autovalidate: true,

//                 // readonly: true,
//                 child: Column(
//                   children: <Widget>[
//                     // Name input *****************************************************************************************************
//                     FormBuilderTextField(
//                       decoration: InputDecoration(labelText: "ชื่อ-นามสกุล"),
//                       attribute: 'name',
//                       // readonly: true,
//                       onChanged: _onChanged,
//                       // valueTransformer: (val) => val.length > 0 ? val[0] : null,
//                     ),

//                     /*Container(
//                           width: MediaQuery.of(context).size.width*0.5,
//                           child: FormBuilderChipsInput(
//                             decoration: InputDecoration(labelText: "Names"),
//                             attribute: 'chips_test',
//                             // readonly: true,
//                             onChanged: _onChanged,
//                             // valueTransformer: (val) => val.length > 0 ? val[0] : null,
//                             initialValue: [
//                               Contact('Andrew', 'stock@man.com',
//                                   'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
//                             ],
//                             maxChips: 5,
//                             findSuggestions: (String query) {
//                               if (query.length != 0) {
//                                 var lowercaseQuery = query.toLowerCase();
//                                 return mockResults.where((profile) {
//                                   return profile.name
//                                           .toLowerCase()
//                                           .contains(query.toLowerCase()) ||
//                                       profile.email
//                                           .toLowerCase()
//                                           .contains(query.toLowerCase());
//                                 }).toList(growable: false)
//                                   ..sort((a, b) => a.name
//                                       .toLowerCase()
//                                       .indexOf(lowercaseQuery)
//                                       .compareTo(b.name
//                                           .toLowerCase()
//                                           .indexOf(lowercaseQuery)));
//                               } else {
//                                 return const <Contact>[];
//                               }
//                             },
//                             chipBuilder: (context, state, profile) {
//                               return InputChip(
//                                 key: ObjectKey(profile),
//                                 label: Text(profile.name),
//                                 avatar: CircleAvatar(
//                                   backgroundImage: NetworkImage(profile.imageUrl),
//                                 ),
//                                 onDeleted: () => state.deleteChip(profile),
//                                 materialTapTargetSize:
//                                     MaterialTapTargetSize.shrinkWrap,
//                               );
//                             },
//                             suggestionBuilder: (context, state, profile) {
//                               return ListTile(
//                                 key: ObjectKey(profile),
//                                 leading: CircleAvatar(
//                                   backgroundImage: NetworkImage(profile.imageUrl),
//                                 ),
//                                 title: Text(profile.name),
//                                 subtitle: Text(profile.email),
//                                 onTap: () => state.selectSuggestion(profile),
//                               );
//                             },
//                           ),
//                         ),*/

//                     // Name input *****************************************************************************************************
//                     //-----------------------------------------------------------------------------------------------------------------
//                     // Identification Number ******************************************************************************************
//                     FormBuilderTextField(
//                       keyboardType: TextInputType.number,
//                       attribute: "identification number",
//                       decoration: InputDecoration(
//                         labelText: "เลขบัตรประจำตัวประชาชน",
//                         /*border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.red),
//                         ),*/
//                       ),
//                       onChanged: _onChanged,
//                       //valueTransformer: (text) => num.tryParse(text),
//                       validators: [
//                         FormBuilderValidators.numeric(),
//                         FormBuilderValidators.max(9999999999999999),
//                       ],
//                     ),
//                     FormBuilderTextField(
//                       keyboardType: TextInputType.number,
//                       attribute: "age",
//                       decoration: InputDecoration(
//                         labelText: "อายุ",
//                         /*border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.red),
//                         ),*/
//                       ),
//                       onChanged: _onChanged,
//                       //valueTransformer: (text) => num.tryParse(text),
//                       validators: [
//                         FormBuilderValidators.numeric(),
//                         FormBuilderValidators.max(70),
//                       ],
//                     ),
//                     // Identification Number ******************************************************************************************
//                     //-----------------------------------------------------------------------------------------------------------------
//                     // Date ***********************************************************************************************************

//                     // Date ***********************************************************************************************************
//                     //-----------------------------------------------------------------------------------------------------------------
//                     // Gender *********************************************************************************************************
//                     FormBuilderDropdown(
//                       attribute: "gender",
//                       decoration: InputDecoration(
//                         labelText: "ระบุเพศ",
//                         /*border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.red),
//                         ),*/
//                       ),
//                       // readOnly: true,
//                       initialValue: 'ชาย',
//                       items: [
//                         'ชาย',
//                         'หญิง',
//                       ].map((String value) {
//                         return DropdownMenuItem(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                     ),
//                     // Gender *********************************************************************************************************
//                     //-----------------------------------------------------------------------------------------------------------------
//                     // Age ************************************************************************************************************

//                     // Age ************************************************************************************************************
//                     //-----------------------------------------------------------------------------------------------------------------
//                     // Address ********************************************************************************************************

//                     FormBuilderTextField(
//                       decoration: InputDecoration(labelText: "ที่อยู่"),
//                       attribute: 'addres',
//                       // readonly: true,
//                       onChanged: _onChanged,
//                       // valueTransformer: (val) => val.length > 0 ? val[0] : null,
//                     ),
//                     FormBuilderTypeAhead(
//                       decoration: InputDecoration(
//                         labelText: "จังหวัด",
//                       ),
//                       attribute: 'country',
//                       onChanged: _onChanged,
//                       itemBuilder: (context, country) {
//                         return ListTile(
//                           title: Text(country),
//                         );
//                       },
//                       suggestionsCallback: (query) {
//                         if (query.length != 0) {
//                           var lowercaseQuery = query.toLowerCase();
//                           return allCountries.where((country) {
//                             return country
//                                 .toLowerCase()
//                                 .contains(lowercaseQuery);
//                           }).toList(growable: false)
//                             ..sort((a, b) => a
//                                 .toLowerCase()
//                                 .indexOf(lowercaseQuery)
//                                 .compareTo(
//                                     b.toLowerCase().indexOf(lowercaseQuery)));
//                         } else {
//                           return allCountries;
//                         }
//                       },
//                     ),
//                     new FormBuilderTextField(
//                       attribute: 'district',
//                       decoration: InputDecoration(
//                           labelText: "เขต/อำเภอ", hintText: null),
//                       keyboardType: TextInputType.multiline,
//                       onChanged: _onChanged,
//                       maxLines: 1,
//                     ),

//                     new FormBuilderTextField(
//                       attribute: 'subdistrict',
//                       decoration: InputDecoration(
//                           labelText: "แขวง/ตำบล", hintText: null),
//                       keyboardType: TextInputType.multiline,
//                       onChanged: _onChanged,
//                       maxLines: 1,
//                     ),

//                     new FormBuilderTextField(
//                       attribute: 'postcode',
//                       decoration: InputDecoration(
//                           labelText: "รหัสไปรษณีย์", hintText: null),
//                       keyboardType: TextInputType.number,
//                       onChanged: _onChanged,
//                       maxLines: 1,
//                     ),
//                     // Address ********************************************************************************************************
//                     //-----------------------------------------------------------------------------------------------------------------
//                     /*FormBuilderRadio(
//                       decoration:
//                           InputDecoration(labelText: 'My chosen language'),
//                       attribute: "best_language",
//                       leadingInput: true,
//                       onChanged: _onChanged,
//                       validators: [FormBuilderValidators.required()],
//                       options: [
//                         "Dart",
//                         "Kotlin",
//                         "Java",
//                         "Swift",
//                         "Objective-C"
//                       ]
//                           .map((lang) => FormBuilderFieldOption(value: lang))
//                           .toList(growable: false),
//                     ),*/
//                     /* TextField(
//                       decoration: InputDecoration(
//                         labelText: "History",
//                         labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic),
//                         hintText: 'เครื่องปลาสะระอึที่มีอายุไข 80 ปีเซอไอแซ็คมาโนจ'
//                       ),
//                       onChanged: _onChanged,
//                       maxLines: 10,
//                     ),*/
//                     /********************************************************************************************************* */

//                     /*FormBuilderSegmentedControl(
//                       decoration:
//                           InputDecoration(labelText: "Movie Rating (Archer)"),
//                       attribute: "movie_rating",
//                       textStyle: TextStyle(fontWeight: FontWeight.bold),
//                       options: List.generate(5, (i) => i + 1)
//                           .map(
//                               (number) => FormBuilderFieldOption(value: number, child: Text("$number", style: TextStyle(fontWeight: FontWeight.bold),),))
//                           .toList(),
//                       onChanged: _onChanged,
//                     ),*/
//                     /* FormBuilderStepper(
//                       decoration: InputDecoration(labelText: "Stepper"),
//                       attribute: "stepper",
//                       initialValue: 10,
//                       step: 1,
//                       onChanged: (data) {
//                         //_fbKey.currentState.fields['age'].currentState.didChange("$data");
//                         //_fbKey.currentState.setAttributeValue("age", "$data");
//                       },
//                       validators: [
//                         (val) {
//                           if (!_fbKey.currentState.fields["accept_terms_switch"]
//                                   .currentState.value &&
//                               val >= 10) {
//                             return "You can only put more than 10 if you've accepted terms";
//                           }
//                           return null;
//                         }
//                       ],
//                     ),*/
//                     /*FormBuilderRate(
//                       decoration: InputDecoration(labelText: "Rate this form"),
//                       attribute: "rate",
//                       iconSize: 32.0,
//                       initialValue: 1,
//                       max: 5,
//                       onChanged: _onChanged,
//                     ),
//                     FormBuilderCheckboxList(
//                       decoration: InputDecoration(
//                           labelText: "The language of my people"),
//                       attribute: "languages",
//                       initialValue: ["Dart"],
//                       leadingInput: true,
//                       options: [
//                         FormBuilderFieldOption(value: "Dart"),
//                         FormBuilderFieldOption(value: "Kotlin"),
//                         FormBuilderFieldOption(value: "Java"),
//                         FormBuilderFieldOption(value: "Swift"),
//                         FormBuilderFieldOption(value: "Objective-C"),
//                       ],
//                       onChanged: _onChanged,
//                     ),
//                     FormBuilderCustomField(
//                       attribute: 'custom',
//                       valueTransformer: (val) {
//                         if (val == "Other")
//                           return _specifyTextFieldKey.currentState.value;
//                         return val;
//                       },
//                       formField: FormField(
//                         builder: (FormFieldState<String> field) {
//                           var languages = [
//                             "English",
//                             "Spanish",
//                             "Somali",
//                             "Other"
//                           ];
//                           return InputDecorator(
//                             decoration: InputDecoration(
//                                 labelText: "What's your preferred language?"),
//                             child: Column(
//                               children: languages
//                                   .map(
//                                     (lang) => Row(
//                                       children: <Widget>[
//                                         Radio<dynamic>(
//                                           value: lang,
//                                           groupValue: field.value,
//                                           onChanged: (dynamic value) {
//                                             field.didChange(lang);
//                                           },
//                                         ),
//                                         lang != "Other"
//                                             ? Text(lang)
//                                             : Expanded(
//                                                 child: Row(
//                                                   children: <Widget>[
//                                                     Text(
//                                                       lang,
//                                                     ),
//                                                     SizedBox(width: 20),
//                                                     Expanded(
//                                                       child: TextFormField(
//                                                         key:
//                                                             _specifyTextFieldKey,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                       ],
//                                     ),
//                                   )
//                                   .toList(growable: false),
//                             ),
//                           );
//                         },
//                       ),
//                     ),*/
//                   ],
//                 ),
//               ),
//               Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: MaterialButton(
//                         color: Colors.blueGrey[300],
//                         child: Text(
//                           "ยืนยัน",
//                           style: TextStyle(
//                             color: Colors.blueGrey[900],
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         onPressed: () {}

//                         // async {
//                         //   _fbKey.currentState.save();
//                         //   if (_fbKey.currentState.validate()) {
//                         //     var values = _fbKey.currentState.value;
//                         //     print(values);
//                         //     var data = <String, dynamic>{};
//                         //     data["name"] = values["name"];
//                         //     data["identification number"] =
//                         //         values["identification number"];
//                         //     data["date"] = values["date"];
//                         //     data["gender"] = values["gender"];
//                         //     data["age"] = values["age"];
//                         //     data["postcode"] = values["postcode"];
//                         //     data["country"] = values["country"];
//                         //     data["district"] = values["district"];
//                         //     data["subdistrict"] = values["subdistrict"];
//                         //     data["history"] = values["history"];
//                         //     data["logic"] = values["logic"];
//                         //     //data["signature"] = values["signature"];
//                         //     await store
//                         //         .collection("form")
//                         //         .add(data)
//                         //         .then((value) {
//                         //       print(value.documentID);
//                         //     }).catchError((err) {
//                         //       print(err);
//                         //     });
//                         //   } else {
//                         //     print(_fbKey.currentState.value);
//                         //     print("validation failed");
//                         //   }
//                         // },
//                         ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Expanded(
//                     child: MaterialButton(
//                       color: Colors.blueGrey[300],
//                       child: Text(
//                         "ล้างทั้งหมด",
//                         style: TextStyle(
//                           color: Colors.blueGrey[900],
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       onPressed: () {
//                         _fbKey.currentState.fields.clear();
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Medicalrec()));
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),