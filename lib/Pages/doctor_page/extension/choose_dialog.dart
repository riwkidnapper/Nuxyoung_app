import 'package:flutter/material.dart';
import 'package:flutter_thailand_provinces/dao/amphure_dao.dart';



class ChooseAmphreDialog extends StatefulWidget {
  final List<AmphureDao> listProvinces;
  final TextStyle styleTitle;
  final TextStyle styleSubTitle;
  final TextStyle styleTextNoData;
  final TextStyle styleTextSearch;
  final TextStyle styleTextSearchHint;
  final double borderRadius;
  final Color colorBackgroundSearch;
  final Color colorBackgroundHeader;
  final Color colorLine;
  final Color colorLineHeader;
  final Color colorBackgroundDialog;

  ChooseAmphreDialog(
      {this.listProvinces,
      this.styleTitle,
      this.styleSubTitle,
      this.styleTextNoData,
      this.styleTextSearch,
      this.styleTextSearchHint,
      this.colorBackgroundHeader,
      this.colorBackgroundSearch,
      this.colorBackgroundDialog,
      this.colorLine,
      this.colorLineHeader,
      this.borderRadius = 16});

  static show(BuildContext context,
      {@required List<AmphureDao> listProvinces,
      TextStyle styleTitle,
      TextStyle styleSubTitle,
      TextStyle styleTextNoData,
      TextStyle styleTextSearch,
      TextStyle styleTextSearchHint,
      Color colorBackgroundSearch,
      Color colorBackgroundHeader,
      Color colorBackgroundDialog,
      Color colorLine,
      Color colorLineHeader,
      double borderRadius = 16}) {
    return showDialog(
        context: context,
        builder: (context) {
          return ChooseAmphreDialog(
              listProvinces: listProvinces,
              styleTitle: styleTitle,
              styleSubTitle: styleSubTitle,
              styleTextNoData: styleTextNoData,
              styleTextSearch: styleTextSearch,
              colorBackgroundSearch: colorBackgroundSearch,
              colorBackgroundHeader: colorBackgroundHeader,
              colorBackgroundDialog: colorBackgroundDialog,
              colorLine: colorLine,
              colorLineHeader: colorLineHeader,
              borderRadius: borderRadius);
        });
  }

  @override
  _ChooseAmphreDialogState createState() => _ChooseAmphreDialogState();
}

class _ChooseAmphreDialogState extends State<ChooseAmphreDialog> {
  List<AmphureDao> listProvincesFilter;

  @override
  void initState() {
    listProvincesFilter = List.of(widget.listProvinces);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        color: widget.colorBackgroundDialog ?? Colors.black45.withOpacity(0.2),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
//          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
              width: 300,
              height: 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  buildSearchContainer(),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(widget.borderRadius))),
                      padding: EdgeInsets.all(8),
                      child: buildListView(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListView() {
    return Stack(
      children: <Widget>[
        ListView.builder(
            itemCount: listProvincesFilter.length,
            itemBuilder: (context, index) {
              return buildRowProvince(listProvincesFilter[index]);
            }),
        Center(
            child: Visibility(
                visible: listProvincesFilter.isEmpty,
                child: Text(
                  "ไม่มีข้อมูล",
                  style: widget.styleTextNoData ?? TextStyle(fontSize: 22),
                )))
      ],
    );
  }

  Widget buildRowProvince(AmphureDao province) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context, province);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    province.nameTh,
                    style: widget.styleTitle ?? TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: widget.colorLine ?? Colors.grey[200],
            )
          ],
        ));
  }

  Widget buildSearchContainer() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
      decoration: BoxDecoration(
          color: widget.colorBackgroundHeader ?? Colors.blueGrey,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(widget.borderRadius))),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          ),
        ],
      ),
    );
  }
}
