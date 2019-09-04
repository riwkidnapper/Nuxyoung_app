import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import './data.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FormBuilder Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHisToRy(),
    );
  }
}

class MyHisToRy extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHisToRy> {
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormFieldState> _specifyTextFieldKey =
      GlobalKey<FormFieldState>();

  ValueChanged _onChanged = (val) => print(val);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form"),
        backgroundColor: Colors.blueGrey[500],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                // context,
                key: _fbKey,
                autovalidate: true,
                initialValue: {
                  'movie_rating': 5,
                },
                // readonly: true,
                child: Column(
                  children: <Widget>[
                    // Name input *****************************************************************************************************
                    Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width*0.95,
                          child: FormBuilderChipsInput(
                            decoration: InputDecoration(labelText: "Names"),
                            attribute: 'chips_test',
                            // readonly: true,
                            onChanged: _onChanged,
                            // valueTransformer: (val) => val.length > 0 ? val[0] : null,
                            initialValue: [
                              Contact('Andrew', 'stock@man.com',
                                  'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
                            ],
                            maxChips: 5,
                            findSuggestions: (String query) {
                              if (query.length != 0) {
                                var lowercaseQuery = query.toLowerCase();
                                return mockResults.where((profile) {
                                  return profile.name
                                          .toLowerCase()
                                          .contains(query.toLowerCase()) ||
                                      profile.email
                                          .toLowerCase()
                                          .contains(query.toLowerCase());
                                }).toList(growable: false)
                                  ..sort((a, b) => a.name
                                      .toLowerCase()
                                      .indexOf(lowercaseQuery)
                                      .compareTo(b.name
                                          .toLowerCase()
                                          .indexOf(lowercaseQuery)));
                              } else {
                                return const <Contact>[];
                              }
                            },
                            chipBuilder: (context, state, profile) {
                              return InputChip(
                                key: ObjectKey(profile),
                                label: Text(profile.name),
                                avatar: CircleAvatar(
                                  backgroundImage: NetworkImage(profile.imageUrl),
                                ),
                                onDeleted: () => state.deleteChip(profile),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              );
                            },
                            suggestionBuilder: (context, state, profile) {
                              return ListTile(
                                key: ObjectKey(profile),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(profile.imageUrl),
                                ),
                                title: Text(profile.name),
                                subtitle: Text(profile.email),
                                onTap: () => state.selectSuggestion(profile),
                              );
                            },
                          ),
                        ),
                        /*Container(
                          width: MediaQuery.of(context).size.width*0.5,
                          child: FormBuilderChipsInput(
                            decoration: InputDecoration(labelText: "Names"),
                            attribute: 'chips_test',
                            // readonly: true,
                            onChanged: _onChanged,
                            // valueTransformer: (val) => val.length > 0 ? val[0] : null,
                            initialValue: [
                              Contact('Andrew', 'stock@man.com',
                                  'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
                            ],
                            maxChips: 5,
                            findSuggestions: (String query) {
                              if (query.length != 0) {
                                var lowercaseQuery = query.toLowerCase();
                                return mockResults.where((profile) {
                                  return profile.name
                                          .toLowerCase()
                                          .contains(query.toLowerCase()) ||
                                      profile.email
                                          .toLowerCase()
                                          .contains(query.toLowerCase());
                                }).toList(growable: false)
                                  ..sort((a, b) => a.name
                                      .toLowerCase()
                                      .indexOf(lowercaseQuery)
                                      .compareTo(b.name
                                          .toLowerCase()
                                          .indexOf(lowercaseQuery)));
                              } else {
                                return const <Contact>[];
                              }
                            },
                            chipBuilder: (context, state, profile) {
                              return InputChip(
                                key: ObjectKey(profile),
                                label: Text(profile.name),
                                avatar: CircleAvatar(
                                  backgroundImage: NetworkImage(profile.imageUrl),
                                ),
                                onDeleted: () => state.deleteChip(profile),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              );
                            },
                            suggestionBuilder: (context, state, profile) {
                              return ListTile(
                                key: ObjectKey(profile),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(profile.imageUrl),
                                ),
                                title: Text(profile.name),
                                subtitle: Text(profile.email),
                                onTap: () => state.selectSuggestion(profile),
                              );
                            },
                          ),
                        ),*/
                      ],
                    ),
                    // Name input *****************************************************************************************************
                    //-----------------------------------------------------------------------------------------------------------------
                    // Identification Number ******************************************************************************************
                     FormBuilderTextField(
                      attribute: "Identification Number",
                      decoration: InputDecoration(
                        labelText: "Identification Number",
                        /*border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),*/
                      ),
                      onChanged: _onChanged,
                      valueTransformer: (text) => num.tryParse(text),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(9999999999999999),
                      ],
                    ),
                    // Identification Number ******************************************************************************************
                    //-----------------------------------------------------------------------------------------------------------------
                    // Date ***********************************************************************************************************
                    FormBuilderDateTimePicker(
                      attribute: "date",
                      onChanged: _onChanged,
                      inputType: InputType.date,
                      format: DateFormat("yyyy-MM-dd"),
                      initialValue: DateTime.now(),
                      decoration:
                          InputDecoration(labelText: "Appointment Time"),
                      // readonly: true,
                    ),
                    // Date ***********************************************************************************************************
                    //-----------------------------------------------------------------------------------------------------------------
                    // Gender *********************************************************************************************************
                    FormBuilderDropdown(
                      attribute: "gender",
                      decoration: InputDecoration(
                        labelText: "Gender",
                        /*border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),*/
                      ),
                      // readOnly: true,
                      initialValue: 'Male',
                      hint: Text('Select Gender'),
                      validators: [FormBuilderValidators.required()],
                      items: ['Male', 'Female']
                          .map((gender) => DropdownMenuItem(
                                value: gender,
                                child: Text('$gender'),
                              ))
                          .toList(),
                    ),
                    // Gender *********************************************************************************************************
                    //-----------------------------------------------------------------------------------------------------------------
                    // Age ************************************************************************************************************
                    FormBuilderTextField(
                      attribute: "age",
                      decoration: InputDecoration(
                        labelText: "Age",
                        /*border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),*/
                      ),
                      onChanged: _onChanged,
                      valueTransformer: (text) => num.tryParse(text),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(70),
                      ],
                    ),
                    // Age ************************************************************************************************************
                    //-----------------------------------------------------------------------------------------------------------------
                    // Address ********************************************************************************************************
                    FormBuilderTypeAhead(
                      // initialValue: "Canada",
                      decoration: InputDecoration(
                        labelText: "Country",
                        /*border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),*/
                      ),
                      attribute: 'country',
                      onChanged: _onChanged,
                      itemBuilder: (context, country) {
                        return ListTile(
                          title: Text(country),
                        );
                      },
                      suggestionsCallback: (query) {
                        if (query.length != 0) {
                          var lowercaseQuery = query.toLowerCase();
                          return allCountries.where((country) {
                            return country
                                .toLowerCase()
                                .contains(lowercaseQuery);
                          }).toList(growable: false)
                            ..sort((a, b) => a
                                .toLowerCase()
                                .indexOf(lowercaseQuery)
                                .compareTo(
                                    b.toLowerCase().indexOf(lowercaseQuery)));
                        } else {
                          return allCountries;
                        }
                      },
                    ),
                    // Address ********************************************************************************************************
                    //-----------------------------------------------------------------------------------------------------------------
                    FormBuilderRadio(
                      decoration:
                          InputDecoration(labelText: 'My chosen language'),
                      attribute: "best_language",
                      leadingInput: true,
                      onChanged: _onChanged,
                      validators: [FormBuilderValidators.required()],
                      options: [
                        "Dart",
                        "Kotlin",
                        "Java",
                        "Swift",
                        "Objective-C"
                      ]
                          .map((lang) => FormBuilderFieldOption(value: lang))
                          .toList(growable: false),
                    ),
                    FormBuilderSegmentedControl(
                      decoration:
                          InputDecoration(labelText: "Movie Rating (Archer)"),
                      attribute: "movie_rating",
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                      options: List.generate(5, (i) => i + 1)
                          .map(
                              (number) => FormBuilderFieldOption(value: number, child: Text("$number", style: TextStyle(fontWeight: FontWeight.bold),),))
                          .toList(),
                      onChanged: _onChanged,
                    ),
                    FormBuilderSwitch(
                      label: Text('I Accept the tems and conditions'),
                      attribute: "accept_terms_switch",
                      initialValue: true,
                      onChanged: _onChanged,
                    ),
                    FormBuilderStepper(
                      decoration: InputDecoration(labelText: "Stepper"),
                      attribute: "stepper",
                      initialValue: 10,
                      step: 1,
                      onChanged: (data) {
                        //_fbKey.currentState.fields['age'].currentState.didChange("$data");
                        //_fbKey.currentState.setAttributeValue("age", "$data");
                      },
                      validators: [
                        (val) {
                          if (!_fbKey.currentState.fields["accept_terms_switch"]
                                  .currentState.value &&
                              val >= 10) {
                            return "You can only put more than 10 if you've accepted terms";
                          }
                          return null;
                        }
                      ],
                    ),
                    FormBuilderRate(
                      decoration: InputDecoration(labelText: "Rate this form"),
                      attribute: "rate",
                      iconSize: 32.0,
                      initialValue: 1,
                      max: 5,
                      onChanged: _onChanged,
                    ),
                    FormBuilderCheckboxList(
                      decoration: InputDecoration(
                          labelText: "The language of my people"),
                      attribute: "languages",
                      initialValue: ["Dart"],
                      leadingInput: true,
                      options: [
                        FormBuilderFieldOption(value: "Dart"),
                        FormBuilderFieldOption(value: "Kotlin"),
                        FormBuilderFieldOption(value: "Java"),
                        FormBuilderFieldOption(value: "Swift"),
                        FormBuilderFieldOption(value: "Objective-C"),
                      ],
                      onChanged: _onChanged,
                    ),
                    FormBuilderCustomField(
                      attribute: 'custom',
                      valueTransformer: (val) {
                        if (val == "Other")
                          return _specifyTextFieldKey.currentState.value;
                        return val;
                      },
                      formField: FormField(
                        builder: (FormFieldState<String> field) {
                          var languages = [
                            "English",
                            "Spanish",
                            "Somali",
                            "Other"
                          ];
                          return InputDecorator(
                            decoration: InputDecoration(
                                labelText: "What's your preferred language?"),
                            child: Column(
                              children: languages
                                  .map(
                                    (lang) => Row(
                                      children: <Widget>[
                                        Radio<dynamic>(
                                          value: lang,
                                          groupValue: field.value,
                                          onChanged: (dynamic value) {
                                            field.didChange(lang);
                                          },
                                        ),
                                        lang != "Other"
                                            ? Text(lang)
                                            : Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      lang,
                                                    ),
                                                    SizedBox(width: 20),
                                                    Expanded(
                                                      child: TextFormField(
                                                        key:
                                                            _specifyTextFieldKey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                  )
                                  .toList(growable: false),
                            ),
                          );
                        },
                      ),
                    ),
                    FormBuilderSignaturePad(
                      decoration: InputDecoration(labelText: "Signature"),
                      attribute: "signature",
                      // height: 250,
                      clearButtonText: "Start Over",
                      onChanged: _onChanged,
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _fbKey.currentState.save();
                        if (_fbKey.currentState.validate()) {
                          print(_fbKey.currentState.value);
                        } else {
                          print(_fbKey.currentState.value);
                          print("validation failed");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _fbKey.currentState.reset();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}