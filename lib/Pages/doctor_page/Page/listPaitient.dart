import 'package:flutter/material.dart';
import 'package:nuxyoung/package/chewie/src/chewie_player.dart';
import 'package:nuxyoung/package/video_player.dart';

class ListPaitient extends StatefulWidget {
  final String paitientName;
  final timetoheal;
  final symptoms;
  final video;
  final address;
  final amphures;
  final district;
  final provinces;
  final zipcode;
  final treatment;
  final gender;
  final idnumber;
  final diagnosis;
  final birthday;
  final reason;

  const ListPaitient(
      {Key key,
      @required this.paitientName,
      @required this.timetoheal,
      @required this.symptoms,
      @required this.video,
      @required this.address,
      @required this.amphures,
      @required this.district,
      @required this.provinces,
      @required this.zipcode,
      @required this.treatment,
      @required this.gender,
      @required this.idnumber,
      @required this.diagnosis,
      @required this.birthday,
      @required this.reason})
      : super(key: key);
  @override
  _ListPaitientState createState() => _ListPaitientState(
      paitientName,
      address,
      amphures,
      birthday,
      diagnosis,
      district,
      gender,
      idnumber,
      reason,
      provinces,
      symptoms,
      timetoheal,
      treatment,
      video,
      zipcode);
}

class _ListPaitientState extends State<ListPaitient> {
  final String paitientName;
  final timetoheal;
  final symptoms;
  final video;
  final address;
  final amphures;
  final district;
  final provinces;
  final zipcode;
  final treatment;
  final gender;
  final idnumber;
  final diagnosis;
  final birthday;
  final reason;
  ChewieController _chewieController;
  VideoPlayerController _videoPlayerController1;
  _ListPaitientState(
      this.paitientName,
      this.address,
      this.amphures,
      this.birthday,
      this.diagnosis,
      this.district,
      this.gender,
      this.idnumber,
      this.provinces,
      this.reason,
      this.symptoms,
      this.timetoheal,
      this.treatment,
      this.video,
      this.zipcode);
  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(video);

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: false,
      looping: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    //timelist = times.split("., ").join("\n\n");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "รายละเอียดของ $paitientName",
          style: TextStyle(
            color: Colors.blueGrey[800],
            fontSize: 18.0,
          ),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(11.0),
                  padding: EdgeInsets.all(15.0),
                  height: 700,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0, 1),
                          blurRadius: 1)
                    ],
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ListView(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Chewie(
                              controller: _chewieController,
                            ),
                          ),SizedBox(
                            height: 10,
                          ),
                          Text(
                            paitientName,
                            style: TextStyle(fontSize: 18.0),
                          ),SizedBox(
                            height: 10,
                          ),
                          Text(idnumber, style: TextStyle(fontSize: 18.0),),SizedBox(
                            height: 10,
                          ),
                         SizedBox(
                            height: 10,
                          ),
                          Text(gender, style: TextStyle(fontSize: 18.0)),SizedBox(
                            height: 10,
                          ),
                          Text(address, style: TextStyle(fontSize: 18.0)),SizedBox(
                            height: 10,
                          ),
                          Text(district, style: TextStyle(fontSize: 18.0)),SizedBox(
                            height: 10,
                          ),
                          Text(amphures, style: TextStyle(fontSize: 18.0)),SizedBox(
                            height: 10,
                          ),
                          Text(provinces, style: TextStyle(fontSize: 18.0)),SizedBox(
                            height: 10,
                          ),
                          Text(zipcode, style: TextStyle(fontSize: 18.0)),SizedBox(
                            height: 10,
                          ),
                          Text(symptoms, style: TextStyle(fontSize: 18.0)),SizedBox(
                            height: 10,
                          ),
                          Text(treatment, style: TextStyle(fontSize: 18.0)),SizedBox(
                            height: 10,
                          ),
                          Text(timetoheal.toString()),SizedBox(
                            height: 10,
                          ),
                          Text(diagnosis, style: TextStyle(fontSize: 18.0)),SizedBox(
                            height: 10,
                          ),
                          Text(reason, style: TextStyle(fontSize: 18.0)),SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
