import 'dart:developer';

import 'package:blog_explorer/screens/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_explorer/models/blogs.dart';
import 'package:blog_explorer/provider/blog_provider.dart';
import 'package:blog_explorer/screens/description_page.dart';
import 'package:sizer/sizer.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  @override
  void initState() {
    final provider = Provider.of<blog_provider>(context, listen: false);
    provider.fetchBlogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('build called');
    final provider = Provider.of<blog_provider>(context);
    return Scaffold(
      drawer: _drawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Blog Explorer'),
        actions:[
          GestureDetector(
            onTap: (() {
              //this will show the notifications received on app
            }),
            child: Icon(Icons.notifications))
        ]
      ),
      body: provider.isloading
          ? getLoadingUI()
          : provider.error.isNotEmpty
              ? getErrorUI(provider.error)
              : bodyui(),

    );
  }
 
  Widget getLoadingUI() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
       children: [
          // SpinKitFadingCircle(
          //   color: Colors.blue,
          //   size: 80,
          // ),
          Text(
            'Loading...',
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget getErrorUI(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 22),
      ),
    );
  }

  // Widget getBodyUI() {
  //   final provider = Provider.of<blog_provider>(context, listen: false);
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: TextField(
  //           onChanged: (value) {
  //             provider.search(value);
  //           },
  //           decoration: InputDecoration(
  //             hintText: 'Search',
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             suffixIcon: const Icon(Icons.search),
  //           ),
  //         ),
  //       ),
  //       Expanded(
  //         child: Consumer(
  //           builder: (context, blog_provider petsProvider, child) =>
  //               ListView.builder(
  //             itemCount: petsProvider.serachedPets.blogs.length,
  //             itemBuilder: (context, index) => ListTile(
  //               leading: CircleAvatar(
  //                 radius: 22,
  //                 backgroundImage: NetworkImage(
  //                     petsProvider.serachedPets.blogs[1].imageUrl),
  //                 backgroundColor: Colors.white,
  //               ),
  //               title: Text(petsProvider.serachedPets.blogs[index].title!),
  //               // trailing: petsProvider.serachedPets.blogs[index].id!
  //               //     ? const SizedBox()
  //               //     : const Icon(
  //               //         Icons.pets,
  //               //         color: Colors.red,
  //               //       ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget bodyui(){
    final provider = Provider.of<blog_provider>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            
            onChanged: (value) {
              provider.search(value);
            },
            decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
              hintText: "Search Blog's",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon: const Icon(Icons.search,size: 30,color: Colors.black,),
            ),
          ),
        ),
        Expanded(
          child: Consumer(
            builder: (context, blog_provider petsProvider, child) =>
                ListView.builder(
              itemCount: petsProvider.serachedPets.blogs.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: (() {
                  print("pressed");
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return  DescriptionPage(
                        id: petsProvider.serachedPets.blogs[index].id,
                        title: petsProvider.serachedPets.blogs[index].title!,
                        image: petsProvider.serachedPets.blogs[index].imageUrl,
                      );
                    },
                  ),
                );
                }),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration : BoxDecoration(
                     borderRadius: BorderRadius.zero,
                     color: Colors.white,
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: Colors.black12,
                    //     spreadRadius: 2,
                    //     blurRadius: 2,
                    //     offset: Offset(2, 2),
                    //   ),
                    // ],
                  ),
                  //  CircleAvatar(
                  //   radius: 22,
                  //   backgroundImage: NetworkImage(
                  //       petsProvider.serachedPets.blogs[1].imageUrl),
                  //   backgroundColor: Colors.white,
                  // ),
                  child : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                       Container(
                        padding: EdgeInsets.only(bottom:5),
                        //margin: EdgeInsets.only(bottom: 10),
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        )  ,
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.network(petsProvider.serachedPets.blogs[index].imageUrl,fit: BoxFit.fill,height: 25.h,width: 40.w,)) ,
                        ),
                        Container(
                          height: 3.5.h,
                          margin: EdgeInsets.only(left: 3.w),
                          child: Text(petsProvider.serachedPets.blogs[index].title!,style: TextStyle(fontSize: 2.7.h,fontWeight: FontWeight.bold),)),
                    ],
                  )
                   
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  _drawer() {
    return Drawer(
      child: ListView(
        children: [
          Container(
      color: Colors.black,
      width: double.infinity,
      height: 25.h,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 10.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage("https://sm.askmen.com/t/askmen_in/article/f/facebook-p/facebook-profile-picture-affects-chances-of-gettin_fr3n.1200.jpg"),
              ),
            ),
          ),
          SizedBox(height: 5,),
          Text("Vishal Gosavi", style: TextStyle(color: Colors.white, fontSize: 20)),
          SizedBox(height: 5,),
          Text(
            "Vishal@gmail.com",
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
          
        ],
      ),),
    
          GestureDetector(
            onTap: (() {
              //we can display the profile page of user
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return  Home();
                    },
                  ));
            }),
            child: ListTile(
              leading: Icon(Icons.home_filled,color: Colors.black,),
              title: Text("Home",style: TextStyle(color: Colors.black,fontSize: 15.sp),),
                ),
          ),
          GestureDetector(
            onTap: (() {
              //we can display the Favourite blogs from app
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return  FavoritePage();
                    },
                  ));
            }),
            child: ListTile(
              leading: Icon(Icons.favorite,color: Colors.black,),
              title: Text("Favorites",style: TextStyle(color: Colors.black,fontSize: 15.sp),),
                
            ),
          ),
          GestureDetector(
            onTap: (() {
              //we can display the information about app
            }),
            child: ListTile(
              leading: Icon(Icons.accessibility_new_outlined,color: Colors.black,),
              title: Text("About Us",style: TextStyle(color: Colors.black,fontSize: 15.sp),),
                
            ),
          ),
          GestureDetector(
            onTap: (() {
              //we can change the settings of the app through this page
            }),
            child: ListTile(
              leading: Icon(Icons.settings,color: Colors.black,),
              title: Text("Settings",style: TextStyle(color: Colors.black,fontSize: 15.sp),),
                
            ),
          ),
          GestureDetector(
            onTap: (() {
              //we can Log out from the app
            }),
            child: ListTile(
              leading: Icon(Icons.logout,color: Colors.black,),
              title: Text("Log Out",style: TextStyle(color: Colors.black,fontSize: 15.sp),),
                
            ),
          ),
        ],
      ),
    );
  }
}