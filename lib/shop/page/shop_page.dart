
import 'package:flutter/material.dart';
import 'package:flu-read/account/account_router.dart';
import 'package:flu-read/mvp/base_page_state.dart';
import 'package:flu-read/res/resources.dart';
import 'package:flu-read/routers/fluro_navigator.dart';
import 'package:flu-read/setting/setting_router.dart';
import 'package:flu-read/shop/models/user_entity.dart';
import 'package:flu-read/shop/presenter/shop_presenter.dart';
import 'package:flu-read/shop/provider/user_provider.dart';
import 'package:flu-read/shop/shop_router.dart';
import 'package:flu-read/util/image_utils.dart';
import 'package:flu-read/util/theme_utils.dart';
import 'package:flu-read/widgets/load_image.dart';
import 'package:provider/provider.dart';

/// design/6店铺-账户/index.html#artboard0
class ShopPage extends StatefulWidget {
  @override
  ShopPageState createState() => ShopPageState();
}

class ShopPageState extends BasePageState<ShopPage, ShopPagePresenter> with AutomaticKeepAliveClientMixin<ShopPage>{
  
  var menuTitle = ['阅读记录', '精神食粮'];
  var menuImage = ['zhls', 'zjgl', 'txzh'];
  var menuDarkImage = ['dark_zhls', 'dark_zjgl', 'dark_txzh'];


  UserProvider provider = UserProvider();
  void setUser(UserEntity user) {
    provider.setUser(user);
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Color _iconColor = ThemeUtils.getIconColor(context);

    return ChangeNotifierProvider<UserProvider>(
      create: (_) => provider,
      child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                tooltip: '消息',
                onPressed: () {
                  NavigatorUtils.push(context, ShopRouter.messagePage);
                },
                icon: LoadAssetImage(
                  'shop/message',
                  key: const Key('message'),
                  width: 24.0,
                  height: 24.0,
                  color: _iconColor,
                ),
              ),
              IconButton(
                tooltip: '设置',
                onPressed: () {
                  NavigatorUtils.push(context, SettingRouter.settingPage);
                },
                icon: LoadAssetImage(
                  'shop/setting',
                  key: const Key('setting'),
                  width: 24.0,
                  height: 24.0,
                  color: _iconColor,
                ),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Gaps.vGap12,
              Consumer<UserProvider>(
                builder: (_, provider, __) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: MergeSemantics(
                      child: Stack(
                        children: <Widget>[
                          const SizedBox(width: double.infinity, height: 56.0),
                          const Text(
                            'JimersyLee',
                            style: TextStyles.textBold24,
                          ),
                          Positioned(
                              right: 0.0,
                              child: CircleAvatar(
                                radius: 28.0,
                                backgroundColor: Colors.transparent,
                                backgroundImage: ImageUtils.getImageProvider(provider.user?.avatarUrl, holderImg: 'shop/tx')
                              )
                          ),
                          Positioned(
                            top: 38.0,
                            left: 0.0,
                            child: Row(
                              children: <Widget>[
                                const LoadAssetImage('shop/zybq', width: 40.0, height: 16.0,),
                                Gaps.hGap8,
                                const Text('用户id:10086', style: TextStyles.textSize12)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Gaps.vGap12,
              Gaps.vGap12,
              Container(height: 0.6, width: double.infinity, margin: const EdgeInsets.only(left: 16.0), child: Gaps.line,),
              Gaps.vGap12,
              Gaps.vGap12,
              const MergeSemantics(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    '账户',
                    style: TextStyles.textBold18,
                  ),
                ),
              ),
              Flexible(
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 12.0),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.18
                  ),
                  itemCount: menuTitle.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          LoadAssetImage(ThemeUtils.isDark(context) ? 'shop/${menuDarkImage[index]}' : 'shop/${menuImage[index]}', width: 32.0),
                          Gaps.vGap4,
                          Text(
                            menuTitle[index],
                            style: TextStyles.textSize12,
                          )
                        ],
                      ),
                      onTap: () {
                        if (index == 0) {
                          NavigatorUtils.push(context, AccountRouter.accountRecordListPage);
                        } else if (index == 1) {
                          NavigatorUtils.push(context, AccountRouter.accountPage);
                        } else if (index == 2) {
                          NavigatorUtils.push(context, AccountRouter.withdrawalAccountPage);
                        }
                      },
                    );
                  },
                ),
              ),
              Container(height: 0.6, width: double.infinity, margin: const EdgeInsets.only(left: 16.0), child: Gaps.line,),
              Gaps.vGap12,
              Gaps.vGap12,
              const MergeSemantics(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    '系统',
                    style: TextStyles.textBold18,
                  ),
                ),
              ),
              Flexible(
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 12.0),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.18
                  ),
                  itemCount: 1,
                  itemBuilder: (_, index) {
                    return InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          LoadAssetImage(ThemeUtils.isDark(context) ? 'shop/dark_dpsz' : 'shop/dpsz', width: 32.0),
                          Gaps.vGap4,
                          const Text(
                            '系统设置',
                            style: TextStyles.textSize12,
                          )
                        ],
                      ),
                      onTap: () => NavigatorUtils.push(context, ShopRouter.shopSettingPage),
                    );
                  },
                ),
              ),
            ],
          )
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  ShopPagePresenter createPresenter() {
    return ShopPagePresenter();
  }
}
