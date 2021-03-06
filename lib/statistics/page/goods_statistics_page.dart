
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flu-read/common/common.dart';
import 'package:flu-read/res/resources.dart';
import 'package:flu-read/util/date_utils.dart';
import 'package:flu-read/util/image_utils.dart';
import 'package:flu-read/util/theme_utils.dart';
import 'package:flu-read/widgets/app_bar.dart';
import 'package:flu-read/widgets/load_image.dart';
import 'package:flu-read/widgets/my_card.dart';
import 'package:flu-read/widgets/pie_chart/pie_chart.dart';
import 'package:flu-read/widgets/pie_chart/pie_data.dart';
import 'package:flu-read/widgets/selected_text.dart';

/// design/5统计/index.html#artboard11
class GoodsStatisticsPage extends StatefulWidget {

  @override
  _GoodsStatisticsPageState createState() => _GoodsStatisticsPageState();
}

class _GoodsStatisticsPageState extends State<GoodsStatisticsPage> {

  DateTime _initialDay;
  int _selectedIndex = 2;
  /// false 书名维度 true 标签维度
  bool _type = false;
  
  @override
  void initState() {
    super.initState();
    _initialDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        actionName: _type ? '书名维度' : '标签维度',
        onPressed: () {
          setState(() {
            _type = !_type;
          });
        },
      ),
      body: SingleChildScrollView(
        key: const Key('goods_statistics_list'),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Gaps.vGap4,
                Text(_type ? '标签维度' : '书名维度', style: TextStyles.textBold24),
                Gaps.vGap16,
                Gaps.vGap16,
                Row(
                  children: <Widget>[
                    _buildSelectedText(_initialDay.year.toString(), 0),
                    Gaps.hGap12,
                    Gaps.vLine,
                    Gaps.hGap12,
                    _buildSelectedText('${_initialDay.month.toString()}月', 1),
                    Gaps.hGap12,
                    Gaps.vLine,
                    Gaps.hGap12,
                    _buildSelectedText(_type ? '${DateUtils.previousWeek(_initialDay)} -${DateUtils.apiDayFormat(_initialDay)}' : '${_initialDay.day.toString()}日', 2),
                  ],
                ),
                Gaps.vGap8,
                _buildChart(),
                const Text('最爱书籍排行', style: TextStyles.textBold18),
                ListView.builder(
                  physics: ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemExtent: 76.0,
                  itemBuilder: (context, index) => _buildItem(index),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  _buildChart() {
    return AspectRatio(
      aspectRatio: 1.30,
      // 百分比布局
      child: FractionallySizedBox(
        heightFactor: 0.8,
        child: PieChart(
          name: _type ? '标签维度' : '书名维度',
          data: _getRandomData(),
        ),
      ),
    );
  }

  List<PieData> data = [];
  List<PieData> data1 = [];

  // 数据为前十名数据与剩余数量
  _getRandomData() {
    if (data.isEmpty) {
      for (int i = 0; i < 9; i++) {
        PieData pieData = PieData();
        pieData.name = '商品$i';
        pieData.number = Random.secure().nextInt(1000);
        data.add(pieData);
      }
      for (int i = 0; i < 11; i++) {
        PieData pieData = PieData();
        if (i == 10) {
          pieData.name = '其他';
          pieData.number = Random.secure().nextInt(1000);
          pieData.color = Colours.text_gray_c;
        } else {
          pieData.name = '商品$i';
          pieData.number = Random.secure().nextInt(1000);
        }
        data1.add(pieData);
      }
    }

    if (_type) {
      return data;
    } else {
      return data1;
    }
  }
  
  _buildItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: MyCard(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 16.0, 16.0, 16.0),
          child: Row(
            children: <Widget>[
              index <= 2 ?
              LoadAssetImage('statistic/${index == 0 ? 'champion' : index == 1 ? 'runnerup' : 'thirdplace'}', width: 40.0,) :
              Container(
                alignment: Alignment.center,
                width: 18.0, height: 18.0,
                margin: const EdgeInsets.symmetric(horizontal: 11.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Constant.colorList[index]
                ),
                child: Text('${index + 1}', style: TextStyle(color: Colors.white, fontSize: Dimens.font_sp12, fontWeight: FontWeight.bold)),
              ),
              Gaps.hGap4,
              Container(
                height: 36.0, width: 36.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: const Color(0xFFF7F8FA), width: 0.6),
                    image: DecorationImage(
                      image: ImageUtils.getAssetImage('order/icon_goods'),
                      fit: BoxFit.fitWidth
                    )
                ),
              ),
              Gaps.hGap8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('数学之美', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimens.font_sp12)),
                    Text('250页', style: Theme.of(context).textTheme.subtitle),
                  ],
                ),
              ),
              Gaps.hGap8,
              Offstage(
                offstage: _type,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('100页', style: Theme.of(context).textTheme.subtitle),
                    Text('未读', style: Theme.of(context).textTheme.subtitle),
                  ],
                ),
              ),
              Gaps.hGap16,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: _type ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('400页', style: Theme.of(context).textTheme.subtitle),
                  Offstage(offstage: _type, child: Text('已读', style: Theme.of(context).textTheme.subtitle)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
 
  _buildSelectedText(String text, int index) {
    Color unSelectedTextColor = ThemeUtils.isDark(context) ? Colors.white : Colours.dark_text_gray;
    return SelectedText(
      text,
      fontSize: Dimens.font_sp15,
      selected: _type && _selectedIndex == index,
      unSelectedTextColor: unSelectedTextColor,
      onTap: _type ? () {
        setState(() {
          _selectedIndex = index;
        });
      } : null,
    );
  }
}
