import 'package:nuxyong_app/package/chewie/chewie.dart';
import 'package:nuxyong_app/package/chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuxyong_app/package/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';


class ChewieDemo extends StatefulWidget {
  ChewieDemo({this.title = 'Video Test'});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  //TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;
    String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType;
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    _videoPlayerController2 = VideoPlayerController.network(
        'https://www.sample-videos.com/video123/mp4/480/asdasdas.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:
      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }
    void _openFileExplorer() async {
    if (_pickingType != FileType.CUSTOM || _hasValidMime) {
      setState(() => _loadingPath = true);
      try {
        if (_multiPick) {
          _path = null;
          _paths = await FilePicker.getMultiFilePath(
              type: _pickingType, fileExtension: _extension);
        } else {
          _paths = null;
          _path = await FilePicker.getFilePath(
              type: _pickingType, fileExtension: _extension);
        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;
      setState(() {
        _loadingPath = false;
        _fileName = _path != null
            ? _path.split('/').last
            : _paths != null ? _paths.keys.toString() : '...';
      });
    }
  }


  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),

      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              _chewieController.enterFullScreen();
            },
            child: Text('Fullscreen'),
          ),
         /* Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _chewieController.dispose();
                      _videoPlayerController2.pause();
                      _videoPlayerController2.seekTo(Duration(seconds: 0));
                      _chewieController = ChewieController(
                        videoPlayerController: _videoPlayerController1,
                        aspectRatio: 3 / 2,
                        autoPlay: true,
                        looping: true,
                      );
                    });
                  },
                  child: Padding(
                    child: Text("Video 1"),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _chewieController.dispose();
                      _videoPlayerController1.pause();
                      _videoPlayerController1.seekTo(Duration(seconds: 0));
                      _chewieController = ChewieController(
                        videoPlayerController: _videoPlayerController2,
                        aspectRatio: 3 / 2,
                        autoPlay: true,
                        looping: true,
                      );
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("Error Video"),
                  ),
                ),
              )
            ],
          ),*/
          /*Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      //_platform = TargetPlatform.android;
                    });
                  },
                  child: Padding(
                    child: Text("Android controls"),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      //_platform = TargetPlatform.iOS;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("iOS controls"),
                  ),
                ),
              )
            ],
          ),*/
          Row(
            children: <Widget>[
              Expanded(
                child: new Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: new SingleChildScrollView(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: new DropdownButton(
                            hint: new Text('LOAD PATH FROM'),
                            value: _pickingType,
                            items: <DropdownMenuItem>[
                              // new DropdownMenuItem(
                              //   child: new Text('FROM AUDIO'),
                              //   value: FileType.AUDIO,
                              // ),
                              new DropdownMenuItem(
                                child: new Text('FROM IMAGE'),
                                value: FileType.IMAGE,
                              ),
                              new DropdownMenuItem(
                                child: new Text('FROM VIDEO'),
                                value: FileType.VIDEO,
                              ),
                              // new DropdownMenuItem(
                              //   child: new Text('FROM ANY'),
                              //   value: FileType.ANY,
                              // ),
                              // new DropdownMenuItem(
                              //   child: new Text('CUSTOM FORMAT'),
                              //   value: FileType.CUSTOM,
                              // ),
                            ],
                            onChanged: (value) => setState(() {
                                  _pickingType = value;
                                  if (_pickingType != FileType.CUSTOM) {
                                    _controller.text = _extension = '';
                                  }
                                })),
                      ),
                      new ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: 100.0),
                        child: _pickingType == FileType.CUSTOM
                            ? new TextFormField(
                                maxLength: 15,
                                autovalidate: true,
                                controller: _controller,
                                decoration:
                                    InputDecoration(labelText: 'File extension'),
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.none,
                                validator: (value) {
                                  RegExp reg = new RegExp(r'[^a-zA-Z0-9]');
                                  if (reg.hasMatch(value)) {
                                    _hasValidMime = false;
                                    return 'Invalid format';
                                  }
                                  _hasValidMime = true;
                                  return null;
                                },
                              )
                            : new Container(),
                      ),
                      // new ConstrainedBox(
                      //   constraints: BoxConstraints.tightFor(width: 200.0),
                      //   child: new SwitchListTile.adaptive(
                      //     title: new Text('Pick multiple files',
                      //         textAlign: TextAlign.right),
                      //     onChanged: (bool value) =>
                      //         setState(() => _multiPick = value),
                      //     value: _multiPick,
                      //   ),
                      // ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                        child: new RaisedButton(
                          onPressed: () => _openFileExplorer(),
                          child: new Text("Open file picker"),
                        ),
                      ),
                      new Builder(
                        builder: (BuildContext context) => _loadingPath
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: const CircularProgressIndicator())
                                : _path != null || _paths != null
                                ? new Container(
                                    padding: const EdgeInsets.only(bottom: 30.0),
                                    height: MediaQuery.of(context).size.height * 0.50,
                                    child: new Scrollbar(
                                        child: new ListView.separated(
                                      itemCount: _paths != null && _paths.isNotEmpty
                                          ? _paths.length
                                          : 1,
                                      itemBuilder: (BuildContext context, int index) {
                                        final bool isMultiPath =
                                            _paths != null && _paths.isNotEmpty;
                                        final String name = 'File $index: ' +
                                            (isMultiPath
                                                ? _paths.keys.toList()[index]
                                                : _fileName ?? '...');
                                        final path = isMultiPath
                                            ? _paths.values.toList()[index].toString()
                                            : _path;

                                        return new ListTile(
                                          title: new Text(
                                            name,
                                          ),
                                          subtitle: new Text(path),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              new Divider(),
                                    )),
                                  )
                                : new Container(),
                    ),
                  ],
                ),
              ),
              ),)
            ],
          )
        ],
      ),
    );
  }
}
