import 'package:appbanhang/model/category.dart';
import 'package:appbanhang/pages/listproductcategory.dart';
import 'package:appbanhang/provider/productprovider.dart';
import 'package:appbanhang/widgets/style/widget_support.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchCategory extends SearchDelegate<void> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    // Ensure searchList is initialized with data
    if (productProvider.searchList.isEmpty) {
      return Center(child: Text('Không có dữ liệu'));
    }

    List<Category> searchCategory = productProvider.searchCategoryList(query);
    return GridView.count(
        childAspectRatio: 0.76,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: searchCategory
            .map((e) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (ctx) =>
                            ListProductCategory(category: e.name)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(
                            e.image,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                            child: Text(
                          e.name,
                          style: AppWidget.semiBoolTextFeildStyle(),
                        )),
                      ],
                    ),
                  ),
                ))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    // Ensure searchList is initialized with data
    if (productProvider.searchList.isEmpty) {
      return Center(child: Text('Không có dữ liệu'));
    }

    List<Category> searchCategory = productProvider.searchCategoryList(query);
    return GridView.count(
        childAspectRatio: 0.87,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: searchCategory
            .map((e) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (ctx) =>
                            ListProductCategory(category: e.name)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(
                            e.image,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                            child: Text(
                          e.name,
                          style: AppWidget.semiBoolTextFeildStyle(),
                        )),
                      ],
                    ),
                  ),
                ))
            .toList());
  }
}
