import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo_list/screen_home.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String imageUrl = '';
  final ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    super.initState();
    fetchUserProfileImage();
  }

  Future<void> fetchUserProfileImage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        setState(() {
          imageUrl = userSnapshot.data()?['profileImage'] ?? '';
        });
      } catch (e) {
        // print("Error fetching profile image: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB76E79),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: getImage(),
                ),
                Positioned(
                  right: 10,
                  bottom: 5,
                  child: Container(
                    width: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF8F3B48)),
                    child: Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: () async {
                          image = await picker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            image = image;
                          });
                          if (image != null) {
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child("Images");
                            String uniqueName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueName);
                            try {
                              await referenceImageToUpload
                                  .putFile(File(image!.path));
                              imageUrl =
                                  await referenceImageToUpload.getDownloadURL();
                            } catch (e) {
                              // print("Error uploading image: $e");
                            }
                          }
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              FirebaseAuth.instance.currentUser?.email ?? 'N/A',
              style: const TextStyle(
                fontSize: 19,
                color: Color(0xFFF0BBC3),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  // First, create the user document if it doesn't exist
                  try {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .set({
                      // Initialize other user properties
                      'email': user.email,
                      // ...
                    });
                  } catch (e) {
                    // print("Error creating user document: $e");
                  }

                  // Update the user's profile in Firestore with the image URL
                  try {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .update({
                      'profileImage': imageUrl,
                    });
                  } catch (e) {
                    // print("Error updating profile image: $e");
                  }
                }
              },
              child: const Text("UPDATE IMAGE"),
            ),
            // const SizedBox(
            //   height: 200,
            // ),
            Expanded(
              child: Container(), // Spacer to push items to the bottom
            ),
            logoutButton(),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider getImage() {
    if (imageUrl.isNotEmpty) {
      return NetworkImage(imageUrl); //image in firebasestore
    } else if (image != null) {
      return FileImage(File(image!.path)); // Display selected image
    } else {
      return const AssetImage(
          "assets/blank-profile-picture-973460_640.webp"); //image to be shown default
    }
  }

  Widget logoutButton() {
    return InkWell(
      onTap: () {
        signout(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 114, 44, 54)),
        child: const Center(
          child: Text(
            'LOGOUT',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
