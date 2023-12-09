import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Widget for retrieving and displaying user data from Firestore
class GetDataFromFirestore extends StatefulWidget {
  final String documentId;

  // Constructor with a required parameter, documentId
  const GetDataFromFirestore({super.key, required this.documentId});

  @override
  State<GetDataFromFirestore> createState() => _GetDataFromFirestoreState();
}

class _GetDataFromFirestoreState extends State<GetDataFromFirestore> {
  // Controller for the text field in the dialog
  final dialogUsernameController = TextEditingController();

  // Current user's authentication credentials
  final credential = FirebaseAuth.instance.currentUser;

  // Reference to the 'userSSS' collection in Firestore
  CollectionReference users = FirebaseFirestore.instance.collection('userSSS');

  // Function to display a dialog for editing a specific value
  myDialog(Map data, dynamic mykey) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          child: Container(
            padding: const EdgeInsets.all(22),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: dialogUsernameController,
                  maxLength: 20,
                  decoration: InputDecoration(hintText: "  ${data[mykey]}    "),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Update the value in Firestore
                        users
                            .doc(credential!.uid)
                            .update({mykey: dialogUsernameController.text});

                        // Refresh the UI and close the dialog
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: const Text(
                        "Edit",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Cancel the edit and close the dialog
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Reference to the 'userSSS' collection in Firestore
    CollectionReference users =
        FirebaseFirestore.instance.collection('userSSS');

    // Use FutureBuilder to handle the loading states of data from Firestore
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          // Display an error message if something goes wrong
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          // Display a message if the document does not exist
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          // Retrieve data from the Firestore document
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          // Build the UI with the retrieved data
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 9,
              ),
              // Section to display and edit the username
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Username: ${data['username']}",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    children: [
                      // Button to delete the username
                      IconButton(
                        onPressed: () {
                          setState(() {
                            // Delete the value in Firestore
                            users
                                .doc(credential!.uid)
                                .update({"username": FieldValue.delete()});
                          });
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      // Button to edit the username
                      IconButton(
                          onPressed: () {
                            myDialog(data, 'username');
                          },
                          icon: const Icon(Icons.edit)),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email: ${data['email']}",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        myDialog(data, 'email');
                      },
                      icon: const Icon(Icons.edit))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Password: ${data['pass']}",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        myDialog(data, 'pass');
                      },
                      icon: const Icon(Icons.edit))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Age: ${data['age']} years old",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        myDialog(data, 'age');
                      },
                      icon: const Icon(Icons.edit))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Title: ${data['title']} ",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        myDialog(data, 'title');
                      },
                      icon: const Icon(Icons.edit))
                ],
              ),
            ],
          );
        }
        // Affiche un message de chargement pendant que les données sont récupérées

        return const Text("loading");
      },
    );
  }
}
