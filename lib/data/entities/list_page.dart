class ListPage<ItemType> {
  ListPage({
    required this.totalPages,
    required this.itemList,
  });

  final int totalPages;
  List<ItemType> itemList;

  bool isLastPage(int previouslyFetchedItemsCount) {
    final newItemsCount = itemList.length;
    final totalFetchedItemsCount = previouslyFetchedItemsCount + newItemsCount;
    return totalFetchedItemsCount == totalPages;
  }

  ListPage<ItemType> copy({required List<ItemType> newPage}) {
    var result = this.itemList;
    result.addAll(newPage);
    return ListPage(totalPages: this.totalPages, itemList: result);
  }
}

//
// class AdvertisementListPage {
//   AdvertisementListPage({
//     required this.totalPages,
//     required this.advertisementList,
//   });
//
//   final int totalPages;
//   AdvertisementListResponse advertisementList;
//
//   bool isLastPage(int previouslyFetchedItemsCount) {
//     final newItemsCount = advertisementList.advertisements.length;
//     final totalFetchedItemsCount = previouslyFetchedItemsCount + newItemsCount;
//     return totalFetchedItemsCount == totalPages;
//   }
//
//   AdvertisementListPage addMore({required List<Advertisement> nextPage}) {
//     var updatedList = this.advertisementList;
//     updatedList.advertisements.addAll(nextPage);
//     return AdvertisementListPage(
//         totalPages: this.totalPages,
//         advertisementList: this
//             .advertisementList
//             .copyWith(advertisements: updatedList.advertisements));
//   }
// }
