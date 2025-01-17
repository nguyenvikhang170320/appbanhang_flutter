class UnboardingContent {
  String image;
  String title;
  String description;

  UnboardingContent(
      {required this.title, required this.image, required this.description});
}

List<UnboardingContent> contents = [
  UnboardingContent(
      title: 'Chọn món ăn từ menu',
      image: 'images/screen1.png',
      description: 'Chọn món ăn từ thực đơn của chúng tôi, và đặt đồ ăn!!'),
  UnboardingContent(
      title: 'Thanh toán dễ dàng và trực tuyến',
      image: 'images/screen2.png',
      description:
          'Bạn có thể thanh toán bằng tiền mặt khi giao hàng và thanh toán bằng thẻ'),
  UnboardingContent(
      title: 'Giao hàng tận nhà',
      image: 'images/screen3.png',
      description: 'Shipper sẽ giao đồ ăn tận nhà cho bạn'),
];
