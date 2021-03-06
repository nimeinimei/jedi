import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// 自定义的热销项目类，包含自定义的热销榜单组件需要的数据。
class HotItem {
  /// 商品ID。
  final int itemId;

  /// 商品图片地址。
  final String picturl;

  /// 商品短名称。
  final String shortTitle;

  /// 优惠券面额。
  final String couponAmount;

  /// 折扣前价格。
  final String zkFinalPrice;

  /// 优惠券总量。
  final int couponTotalCount;

  /// 优惠券剩余量。
  final int couponRemainCount;

  /// 商品标题。
  final String title;

  /// 卖家类型。
  final int userType;

  /// 店铺名称。
  final String shopTitle;

  /// 商品图片。
  final List smallImages;

  /// 是否自平台商品。
  final String isselfupport;

  /// 二合一页面链接。
  final String couponShareUrl;

  HotItem({
    this.itemId,
    this.picturl,
    this.shortTitle,
    this.couponAmount,
    this.zkFinalPrice,
    this.couponRemainCount,
    this.couponTotalCount,
    this.title,
    this.userType,
    this.shopTitle,
    this.smallImages,
    this.isselfupport,
    this.couponShareUrl,
  });
}

/// 自定义的热销榜单组件。
class HotList extends StatelessWidget {
  /// 从服务器获取的热销榜单数据。
  final List<HotItem> hotData;

  HotList({
    this.hotData,
  });

  /// 构建用于显示单个热销产品信息的卡片（`Card`）组件。
  Widget _buildCard(HotItem hotItem) {
    // 卡片（`Card`）组件，有圆角和阴影的卡片。
    // 通常用于表示一些相关信息的一张卡片，例如相册、地理位置、用餐、联系方式等。
    return Card(
      child: Container(
        width: 109.0,
        height: 148.0,
        child: Column(
          children: <Widget>[
            // 用来显示商品图片的容器（`Container`）组件。
            Container(
              width: double.infinity,
              height: 70.0,
              child: CachedNetworkImage(
                imageUrl: hotItem.picturl,
                height: 70.0,
                fit: BoxFit.cover,
              ),
            ),
            // 用来显示优惠劵简介的容器（`Container`）组件。
            Container(
              height: 21.0,
              width: 109.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/home_roll_backplane.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(
                child: Text(
                  // 字符串为固定（`toStringAsFixed`）方法，返回保留几位小数的字符串。
                  (hotItem.couponTotalCount - hotItem.couponRemainCount)
                          .toStringAsFixed(0) +
                      '人已领 | ${hotItem.couponAmount} 元劵',
                  style: TextStyle(
                    color: Color(0xffFFFFFF),
                    fontFamily: 'PingFangRegular',
                    fontSize: 11.0,
                  ),
                ),
              ),
            ),
            // 用来显示销售商品名称的容器（`Container`）组件。
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                right: 4.0,
                left: 4.0,
                top: 4.0,
              ),
              child: Text(
                hotItem.shortTitle,
                // 溢出的文本以省略号（`...`）显示。
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xff333333),
                  fontFamily: 'PingFangBold',
                  fontSize: 14.0,
                ),
              ),
            ),
            // 用来显示商品折扣情况的填充（`Padding`）组件。
            Padding(
              padding: EdgeInsets.only(
                right: 4.0,
                left: 4.0,
                top: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // 用来显示商品折扣价的文本（`Text`）组件。
                  Text.rich(
                    TextSpan(
                      text: '¥',
                      children: [
                        TextSpan(
                          // 字符串为固定（`toStringAsFixed`）方法，返回保留几位小数的字符串。
                          text: (double.parse(hotItem.zkFinalPrice) -
                                  double.parse(hotItem.couponAmount))
                              .toStringAsFixed(1)
                              .toString(),
                          style: TextStyle(
                            // 字母间距（`letterSpacing`）属性，每个字母之间添加的空间量。
                            // 以逻辑像素为单位，可以使用负值来使字母更接近。
                            letterSpacing: 0.0,
                          ),
                        ),
                      ],
                      style: TextStyle(
                        color: Color(0xffFF4964),
                        fontFamily: 'PingFangBold',
                        fontSize: 14.0,
                        letterSpacing: 4.0,
                      ),
                    ),
                  ),
                  // 用来显示商品成本价的文本（`Text`）组件。
                  Text.rich(
                    TextSpan(
                      text: '¥',
                      children: [
                        TextSpan(
                          text: hotItem.zkFinalPrice,
                          style: TextStyle(
                            // 字母间距（`letterSpacing`）属性，每个字母之间添加的空间量。
                            // 以逻辑像素为单位，可以使用负值来使字母更接近。
                            letterSpacing: 0.0,
                          ),
                        ),
                      ],
                      style: TextStyle(
                        color: Color(0xff999999),
                        fontFamily: 'PingFangRegular',
                        fontSize: 12.0,
                        letterSpacing: 4.0,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Color(0xffFFFFFF),
          padding: EdgeInsets.symmetric(
            vertical: 17.0,
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 14.0,
                  right: 4.0,
                ),
                child: Image.asset(
                  'assets/hot_list_sign.png',
                  width: 13.0,
                  height: 17.0,
                ),
              ),
              Text(
                '热销榜单',
                style: TextStyle(
                  color: Color(0xff333333),
                  fontFamily: 'PingFangBold',
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Color(0xffFFFFFF),
          // 单个组件滚动视图（`SingleChildScrollView`）组件。
          // 可以滚动单个组件的框，当有一个完全可见的单个框时，此组件非常有用。
          // 例如时间选择器中的时钟面，但如果容器在一个轴上太小，则需要确保它可以滚动。
          child: SingleChildScrollView(
            // 滚动方向（`scrollDirection`）属性，滚动视图滚动的轴方向。
            scrollDirection: Axis.horizontal,
            // 填充（`padding`）属性，插入子组件的空间量。
            padding: EdgeInsets.symmetric(
              horizontal: 11.0,
            ),
            child: Row(
              children: hotData.map((HotItem hotItem) {
                return GestureDetector(
                    onTap: () {
                      // 使用命名路由导航到第二个屏幕。
                      Navigator.pushNamed(
                        context,
                        '/category/details',
                        arguments: {
                          'itemId': hotItem.itemId,
                          'title': hotItem.title,
                          'zkFinalPrice': hotItem.zkFinalPrice,
                          'userType': hotItem.userType,
                          'volume': hotItem.couponTotalCount -
                              hotItem.couponRemainCount,
                          'shopTitle': hotItem.shopTitle,
                          'smallImages': hotItem.smallImages,
                          'isselfupport': hotItem.isselfupport,
                          'zkfinalprices': double.parse(hotItem.zkFinalPrice) -
                              double.parse(hotItem.couponAmount),
                          'couponAmount': hotItem.couponAmount,
                          'couponShareUrl': hotItem.couponShareUrl,
                        },
                      );
                    },
                    child: _buildCard(hotItem));
              }).toList(),
            ),
          ),
        ),
        // 用大小框���`SizedBox`）组件来占一块空间。
        SizedBox(
          height: 11.0,
        ),
      ],
    );
  }
}
