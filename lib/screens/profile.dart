import 'dart:io';

import 'package:fasa7ny/screens/profile_provider.dart';
import 'package:fasa7ny/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import '../utils/colors_utils.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImageAndUpdateProfile(
      ProfileProvider profileProvider) async {
    if (_formKey.currentState!.validate()) {
      final newName = _nameController.text;
      final newBio = _bioController.text;

      // Upload the image to Firebase Storage
      if (_image != null) {
        final storageRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
        final uploadTask = storageRef.putFile(_image!);
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadURL = await snapshot.ref.getDownloadURL();

        // Update the profile info with the uploaded image URL
        profileProvider.updateProfile(newName, newBio, downloadURL);
      } else {
        // Update the profile info without changing the image
        profileProvider.updateProfile(
            newName, newBio, ''); // Pass an empty string
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final userName = profileProvider.userName;
    final userBio = profileProvider.userBio;
    final profilePictureUrl = profileProvider.profilePictureUrl;

    final color1 = hexStringToColor("E59400");
    final color2 = hexStringToColor("C37F00");
    final color3 = hexStringToColor("FFE5B4");
    final backgroundColor = Color.lerp(
      Color.lerp(color1, color2, 0.8),
      color3,
      0.5,
    );
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        actions: [
          IconButton(
            onPressed: _logout,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 15),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? Icon(Icons.account_circle, size: 96)
                      : null,
                ),
              ),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        controller: _nameController..text = userName,
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        controller: _bioController..text = userBio,
                        decoration: InputDecoration(labelText: 'Bio'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your bio';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () =>
                          _uploadImageAndUpdateProfile(profileProvider),
                      child: Text('Update Profile'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                userName,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                userBio,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text("2"),
                      Text("Posts"),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("assets/pyramid1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("assets/pyramid1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Redirect or navigate to the login screen and clear the navigation stack
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
        (route) => false,
      );
    } catch (e) {
      print('Failed to logout: $e');
    }
  }
}
