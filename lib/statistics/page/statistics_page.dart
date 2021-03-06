
import 'package:flutter/material.dart';
import 'package:flu-read/order/page/order_page.dart';
import 'package:flu-read/res/resources.dart';
import 'package:flu-read/routers/fluro_navigator.dart';
import 'package:flu-read/statistics/statistics_router.dart';
import 'package:flu-read/util/image_utils.dart';
import 'package:flu-read/util/theme_utils.dart';
import 'package:flu-read/widgets/load_image.dart';
import 'package:flu-read/widgets/my_card.dart';
import 'package:flu-read/widgets/my_flexible_space_bar.dart';


/// design/5统计/index.html
class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        key: const Key('statistic_list'),
        physics: ClampingScrollPhysics(),
        slivers: _sliverBuilder(),
      ),
    );
  }

  bool isDark = false;
  
  List<Widget> _sliverBuilder() {
    isDark = ThemeUtils.isDark(context);
    return <Widget>[
      SliverAppBar(
        brightness: Brightness.dark,
        leading: Gaps.empty,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        expandedHeight: 100.0,
        pinned: true,
        flexibleSpace: MyFlexibleSpaceBar(
          background: isDark ? Container(height: 115.0, color: Colours.dark_bg_color,) : const LoadAssetImage('statistic/statistic_bg',
            width: double.infinity,
            height: 115.0,
            fit: BoxFit.fill,
          ),
          centerTitle: true,
          titlePadding: const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
          collapseMode: CollapseMode.pin,
          title: Text('统计', style: TextStyle(color: ThemeUtils.getIconColor(context)),),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
            DecoratedBox(
              decoration: BoxDecoration(
                  color: isDark ? Colours.dark_bg_color : null,
                  image: isDark ? null : DecorationImage(
                      image: ImageUtils.getAssetImage('statistic/statistic_bg1'),
                      fit: BoxFit.fill
                  )
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                height: 120.0,
                child: MyCard(
                  child: Row(
                    children: <Widget>[
                      const _StatisticsTab('今日已读(页)', 'xdd', '80'),
                      const _StatisticsTab('今日读完(本)', 'dps', '1'),
                      const _StatisticsTab('阅读总计(本)', 'jrjye', '223'),
                    ],
                  ),
                ),
              ),
            )
            , 120.0
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Gaps.vGap16,
              Gaps.vGap16,
              const Text('数据走势', style: TextStyles.textBold18),
              Gaps.vGap16,
              const _StatisticsItem('书籍走势', 'sjzs', 1),
              Gaps.vGap8,
              const _StatisticsItem('已读页数统计', 'jyetj', 2),
              Gaps.vGap8,
              const _StatisticsItem('最爱书籍走势', 'sptj', 3),
            ],
          ),
        ),
      )
    ];
  }
  
}

class _StatisticsItem extends StatelessWidget {

  const _StatisticsItem(this.title, this.img, this.index, {Key key}): super(key: key);

  final String title;
  final String img;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.14,
      child: MyCard(
          child: MergeSemantics(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: GestureDetector(
                onTap: () {
                  if (index == 1 || index == 2) {
                    NavigatorUtils.push(context, '${StatisticsRouter.orderStatisticsPage}?index=$index');
                  } else {
                    NavigatorUtils.push(context, StatisticsRouter.goodsStatisticsPage);
                  }
                },
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(title, style: TextStyles.textBold14),
                          const LoadAssetImage('statistic/icon_selected', height: 16.0, width: 16.0)
                        ],
                      ),
                    ),
                    Expanded(child: LoadAssetImage('statistic/$img', fit: BoxFit.fill))
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}

class _StatisticsTab extends StatelessWidget {

  const _StatisticsTab(this.title, this.img, this.content);

  final String title;
  final String img;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MergeSemantics(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoadAssetImage('statistic/$img', width: 40.0, height: 40.0),
            Gaps.vGap4,
            Text(title, style: Theme.of(context).textTheme.subtitle),
            Gaps.vGap8,
            Text(content, style: const TextStyle(fontSize: Dimens.font_sp18)),
          ],
        ),
      ),
    );
  }
}