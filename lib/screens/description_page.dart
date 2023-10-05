import 'package:blog_explorer/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DescriptionPage extends StatelessWidget {
   DescriptionPage({
    super.key,
    required this.title,
    required this.id,
    required this.image,
  });
  
  final String title;
  final String id;
  final String image;

  @override
  Widget build(BuildContext context) {
          final provider = Provider.of<FavoriteProvider>(context);
        return MultiProvider(
          providers: [ChangeNotifierProvider<FavoriteProvider>(create: (BuildContext context) {
            return FavoriteProvider();
          }),],
          child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("Description"),
            actions: [
              IconButton(
                onPressed: (){
                  provider.toggleFavorite(title);
                }, 
                icon: provider.isExist(title) 
                ? const Icon(Icons.favorite,size: 27,color: Colors.red,) : const Icon(Icons.favorite_border_outlined,size:27)
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 5,),
                  Container(
                    height: 25.h,
                    width: double.infinity,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(image,fit: BoxFit.fill,)) ,
                  ),
                  Container(
                  margin: EdgeInsets.all(4.w),
                  
                    child: Text(title, style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
          ),
        ));
      }
  
  }
