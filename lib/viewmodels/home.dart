// 轮播图类型
class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  // 扩展一个工厂函数，从json转换为模型类
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(id: json['id'] ?? '', imgUrl: json['imgUrl'] ?? '');
  }

  @override
  String toString() => 'BannerItem(id: $id, imgUrl: $imgUrl)';
}

// 根据上面的json数据，定义一个分类模型类
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });
  // 扩展一个工厂函数，从json转换为模型类
  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'],
      name: json['name'],
      picture: json['picture'],
      children: (json['children'] as List?)
          ?.map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() =>
      'CategoryItem(id: $id, name: $name, picture: $picture, children: $children)';
}

// 特惠推荐 - 商品项模型类
class GoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;
  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });
  // 扩展一个工厂函数，从json转换为模型类
  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      desc: json['desc'],
      price: json['price'] ?? '0.00',
      picture: json['picture'] ?? '',
      orderNum: json['orderNum'] ?? 0,
    );
  }

  @override
  String toString() =>
      'GoodsItem(id: $id, name: $name, desc: $desc, price: $price, picture: $picture, orderNum: $orderNum)';
}

// 特惠推荐 - 商品分页列表模型类
class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;
  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  // 扩展一个工厂函数，从json转换为模型类
  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json['counts'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      pages: json['pages'] ?? 0,
      page: json['page'] ?? 1,
      items:
          (json['items'] as List?)
              ?.map((e) => GoodsItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  @override
  String toString() =>
      'GoodsItems(counts: $counts, pageSize: $pageSize, pages: $pages, page: $page, items: $items)';
}

// 特惠推荐 - 子类型模型类
class SubType {
  String id;
  String title;
  GoodsItems goodsItems;
  SubType({required this.id, required this.title, required this.goodsItems});
  // 扩展一个工厂函数，从json转换为模型类
  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      goodsItems: GoodsItems.fromJson(
        json['goodsItems'] as Map<String, dynamic>,
      ),
    );
  }

  @override
  String toString() =>
      'SubType(id: $id, title: $title, goodsItems: $goodsItems)';
}

// 特惠推荐模型类
class SpecialRecommend {
  String id;
  String title;
  List<SubType> subTypes;
  SpecialRecommend({
    required this.id,
    required this.title,
    required this.subTypes,
  });
  // 扩展一个工厂函数，从json转换为模型类，入参为接口返回的 result 字段
  factory SpecialRecommend.fromJson(Map<String, dynamic> json) {
    return SpecialRecommend(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subTypes:
          (json['subTypes'] as List?)
              ?.map((e) => SubType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  @override
  String toString() =>
      'SpecialRecommend(id: $id, title: $title, subTypes: $subTypes)';
}

// 推荐列表模型类
class GoodDetailItem extends GoodsItem {
  int payCount = 0;
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: '');
  // 扩展一个工厂函数，从json转换为模型类
  factory GoodDetailItem.fromJson(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      picture: json['picture']?.toString() ?? '',
      orderNum: int.tryParse(json['orderNum']?.toString() ?? '0') ?? 0,
      payCount: int.tryParse(json['payCount']?.toString() ?? '0') ?? 0,
    );
  }

  @override
  String toString() =>
      'GoodDetailItem(id: $id, name: $name, desc: $desc, price: $price, picture: $picture, orderNum: $orderNum, payCount: $payCount)';
}

class GoodsDetailsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodDetailItem> items;
  GoodsDetailsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  // 扩展一个工厂函数，从json转换为模型类
  factory GoodsDetailsItems.fromJson(Map<String, dynamic> json) {
    return GoodsDetailsItems(
      counts: json['counts'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      pages: json['pages'] ?? 0,
      page: json['page'] ?? 1,
      items:
          (json['items'] as List?)
              ?.map((e) => GoodDetailItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
