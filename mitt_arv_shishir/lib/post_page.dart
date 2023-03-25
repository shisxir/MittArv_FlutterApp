import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:mitt_arv_shishir/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late Map<String, dynamic> _user = {};
  final _formKey = GlobalKey<FormState>();
  final _contentController = quill.QuillController.basic();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userId = prefs.getInt('userId') ?? 0;
    if (userId != 0) {
      final user = await DBHelper.getUserById(userId);
      if (user != null) {
        setState(() {
          _user = user;
        });
      }
    }
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/postlogo.png',
                  width: 300,
                  height: 305,
                  scale: 1,
                ),
                Expanded(
                  child: quill.QuillEditor(
                    
                    controller: _contentController,
                    scrollController: ScrollController(),
                    readOnly: false,
                    expands: true,
                    padding: const EdgeInsets.all(10),
                    scrollable: true,
                    focusNode: FocusNode(),
                    autoFocus: true,
                    minHeight: 500,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final content = _contentController.document.toPlainText();
                      final Map<String,dynamic> post = {
                        'id': 0,
                        'content': content,
                      };

                      /*SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    await prefs.remove('userId');*/

                      int result = await DBHelper.addPost(post);

                      /*ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Post added successfully'),
                        ),
                      );*/

                      if (result != -1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${_user['Name']}Post added successfully'),
                          ),

                        );
                        Navigator.pushNamed(context, 'profile');
                      }
                      else{
                        Navigator.pushNamed(context, 'login');
                      }
                    }
                  },
                  child: const Text('POST'),
                ),
                ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: (){

                  Navigator.pushNamed(context, 'profile');
                }, child: const Text('BACK'))
              ],
            ),
          ),
        ),
      );
    }
  }



/*
class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<Map<String, dynamic>> _posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() async {
    final posts = await DBHelper.getAllPosts();
    setState(() {
      _posts = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (BuildContext context, int index) {
          final post = _posts[index];
          return ListTile(
            title: Text(post['content']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'post');
        },
        tooltip: 'Add Post',
        child: const Icon(Icons.add),
      ),
    );
  }
}
*/
