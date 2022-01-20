// import 'package:flutter/material.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// class CharacterListView extends StatefulWidget {
//   @override
//   _CharacterListViewState createState() => _CharacterListViewState();
// }

// class _CharacterListViewState extends State<CharacterListView> {
//   static const _pageSize = 20;

//   final PagingController<int, CharacterSummary> _pagingController =
//       PagingController(firstPageKey: 0);

//   @override
//   void initState() {
//     _pagingController.addPageRequestListener((pageKey) {
//       _fetchPage(pageKey);
//     });
//     super.initState();
//   }

//   Future<void> _fetchPage(int pageKey) async {
//     try {
//       final newItems = await RemoteApi.getCharacterList(pageKey, _pageSize);
//       final isLastPage = newItems.length < _pageSize;
//       if (isLastPage) {
//         _pagingController.appendLastPage(newItems);
//       } else {
//         final nextPageKey = pageKey + newItems.length;
//         _pagingController.appendPage(newItems, nextPageKey);
//       }
//     } catch (error) {
//       _pagingController.error = error;
//     }
//   }

//   @override
//   Widget build(BuildContext context) => 
//       // Don't worry about displaying progress or error indicators on screen; the 
//       // package takes care of that. If you want to customize them, use the 
//       // [PagedChildBuilderDelegate] properties.
//       PagedListView<int, CharacterSummary>(
//         pagingController: _pagingController,
//         builderDelegate: PagedChildBuilderDelegate<CharacterSummary>(
//           itemBuilder: (context, item, index) => CharacterListItem(
//             character: item,
//           ),
//         ),
//       );

//   @override
//   void dispose() {
//     _pagingController.dispose();
//     super.dispose();
//   }
// }