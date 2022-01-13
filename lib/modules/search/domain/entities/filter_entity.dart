class FilterEntity {
  String titleTxt;
  bool isSelected;

  FilterEntity({
    this.titleTxt = '',
    this.isSelected = false,
  });

  static List<FilterEntity> popularFList = [
    FilterEntity(
      titleTxt: 'Free Breakfast',
      isSelected: false,
    ),
    FilterEntity(
      titleTxt: 'Free Parking',
      isSelected: false,
    ),
    FilterEntity(
      titleTxt: 'Pool',
      isSelected: true,
    ),
    FilterEntity(
      titleTxt: 'Pet Friendly',
      isSelected: false,
    ),
    FilterEntity(
      titleTxt: 'Free wifi',
      isSelected: false,
    ),
  ];

  static List<FilterEntity> accomodationList = [
    FilterEntity(
      titleTxt: 'All',
      isSelected: false,
    ),
    FilterEntity(
      titleTxt: 'Apartment',
      isSelected: false,
    ),
    FilterEntity(
      titleTxt: 'Home',
      isSelected: true,
    ),
    FilterEntity(
      titleTxt: 'Villa',
      isSelected: false,
    ),
    FilterEntity(
      titleTxt: 'Hotel',
      isSelected: false,
    ),
    FilterEntity(
      titleTxt: 'Resort',
      isSelected: false,
    ),
  ];
}
