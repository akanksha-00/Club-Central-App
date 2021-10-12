import 'package:club_central/repositories/session_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'bloc/addpost_bloc.dart';
import 'clubadminscreen.dart';
import 'models/newpost.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _formKey = GlobalKey<FormState>();
  late NewPost newPost = NewPost(
      title: "",
      description: "",
      date: DateTime.now(),
      imageUrl: "",
      clubid:
          RepositoryProvider.of<DatabaseAuthRepository>(context).clubuser.id);

  DateTime _selectedDate = DateTime.now();
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
        newPost.date = pickedDate;
        print(newPost.date);
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Post")),
      body: BlocBuilder<AddpostBloc, AddPostState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: BlocListener<AddpostBloc, AddPostState>(
              listener: (context, state) {
                if (state.status is UploadSuccessful) {
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //   content: Text("Post Successfully Uploaded"),
                  //   duration: Duration(milliseconds: 400),
                  //   backgroundColor: Colors.green,
                  // ));
                  EasyLoading.showSuccess(
                    'Post Successfully Uploaded!',
                  );
                  pushNewScreen(
                    context,
                    screen: ClubAdminScreen(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.slideRight,
                  );
                } else if (state.status is UploadFailed) {}
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        onChanged: (value) {
                          newPost.title = value;
                          context
                              .read<AddpostBloc>()
                              .add(PostChanged(newPost: newPost));
                        },
                        validator: (value) =>
                            value!.length > 0 ? null : "Title can't be Empty",
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0.0),
                          labelText: 'Title',
                          hintText: 'Enter Title of the Post',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                          prefixIcon: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 100,
                        child: TextFormField(
                          onChanged: (value) {
                            newPost.description = value;
                            context
                                .read<AddpostBloc>()
                                .add(PostChanged(newPost: newPost));
                          },
                          validator: (value) => value!.length > 0
                              ? null
                              : "Description can't be Empty",
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            labelText: 'Description',
                            hintText: 'Enter Description',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                            prefixIcon: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 18,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 70,
                        child: Row(
                          
                        mainAxisAlignment:MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                _selectedDate == null
                                    ? 'No Date Chosen!'
                                    : 'Picked Date: ${DateFormat.yMMMMd().format(_selectedDate)}',
                              ),
                            ),
                            TextButton(
                                child: Row(
                                  children: [
                                    Text(
                                      'Choose Date',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(Icons.calendar_today)
                                  ],
                                ),
                                onPressed: () {
                                  _presentDatePicker();
                                  newPost.date = _selectedDate;
                                  context
                                      .read<AddpostBloc>()
                                      .add(PostChanged(newPost: newPost));
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                )),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(
                              top: 8,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            child: FittedBox(
                              child: newPost.imageUrl == ""
                                  ? Text("Enter Image Link")
                                  : Image.network(
                                      newPost.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Container(
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: Center(
                                child: TextFormField(
                                  onChanged: (value) {
                                    newPost.imageUrl = value;
                                    context
                                        .read<AddpostBloc>()
                                        .add(PostChanged(newPost: newPost));
                                  },
                                  validator: (value) => value!.length > 0
                                      ? null
                                      : "URl cannot be Empty",
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(0.0),
                                    labelText: 'Image URL',
                                    hintText: 'Enter URL Of Image',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.0,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.5),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print(newPost.title);
                            context
                                .read<AddpostBloc>()
                                .add(AddPostButtonClicked());
                          }
                        },
                        height: 45,
                        color: Colors.black,
                        child: Text(
                          "Add Post",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
