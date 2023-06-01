// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:advocatus/datalayer/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:advocatus/home/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:advocatus/login/login.dart';
import 'package:flutter/services.dart';
import 'package:advocatus/datalayer/auth_shipper_methods.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  VoidCallback showLoginPage;
  SignUpPage({super.key, required this.showLoginPage});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _ConfirmPassword = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _emailAddress = '';
  bool isChecked = false;
  String _password = '';
  String _fullName = '';
  late String url;
  late int _phoneNumber;
  File? _pickedImage;
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.green;
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  // submit button here
  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    var date = DateTime.now().toString();
    var dateparse = DateTime.parse(date);
    var formattedDate =
        "${dateparse.day} - ${dateparse.month}- ${dateparse.year}";
    if (isValid) {
      _formKey.currentState!.save();
      try {
        if (_pickedImage == null) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Please Pick an Image'),
              );
            },
          );
        } else {
          setState(() {
            _isLoading = true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child('userimages')
              .child('$_fullName.jpg');
          await ref.putFile(_pickedImage!);
          url = await ref.getDownloadURL();
          await _auth.createUserWithEmailAndPassword(
              email: _emailAddress.toLowerCase().trim(),
              password: _password.trim());
          final User? user = _auth.currentUser;
          final _uid = user!.uid;

          user.updatePhotoURL(url);
          user.updateDisplayName(_fullName);
          user.reload();

          await FirebaseFirestore.instance.collection('users').doc(_uid).set({
            'id': _uid,
            'name': _fullName,
            'lawyer': isChecked,
            'email': _emailAddress,
            'phone': _phoneNumber,
            'imageUrl': url,
            'joinedAt': formattedDate,
            'createdAt': Timestamp.now(),
          });
          Navigator.canPop(context) ? Navigator.pop(context) : null;
        }
      } catch (error) {
        print('Error occured ${error}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _remove() {
    setState(() {
      _pickedImage = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Signup',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        WidgetSpan(
                          child: SizedBox(
                            width: 5,
                          ),
                        ),
                        WidgetSpan(
                          child: Image.asset('assets/user.png'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('hello, Sign up to access the legal associate Program'),
                ],
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: CircleAvatar(
                      radius: 71,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.orange[700],
                        backgroundImage: _pickedImage == null
                            ? null
                            : FileImage(_pickedImage!),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 120,
                      left: 110,
                      child: RawMaterialButton(
                        elevation: 10,
                        fillColor: Colors.grey,
                        child: Icon(Icons.add_a_photo),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Choose option',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        InkWell(
                                          onTap: _pickImageCamera,
                                          splashColor: Colors.purpleAccent,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.camera,
                                                  color: Colors.purpleAccent,
                                                ),
                                              ),
                                              Text(
                                                'Camera',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: _pickImageGallery,
                                          splashColor: Colors.purpleAccent,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.image,
                                                  color: Colors.purpleAccent,
                                                ),
                                              ),
                                              Text(
                                                'Gallery',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: _remove,
                                          splashColor: Colors.purpleAccent,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Text(
                                                'Remove',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.red),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ))
                ],
              ),
              Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Text(
                                'Name',
                                textAlign: TextAlign.start,
                              ),
                            ),
                            TextFormField(
                              key: ValueKey('name'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'name should not be empty';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_emailFocusNode),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Enter your full names',
                              ),
                              onSaved: (value) {
                                _fullName = value!;
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Text(
                                'Email',
                                textAlign: TextAlign.start,
                              ),
                            ),
                            TextFormField(
                              key: ValueKey('email'),
                              focusNode: _emailFocusNode,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'Enter your email Address',
                              ),
                              onSaved: (value) {
                                _emailAddress = value!;
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 19,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Text(
                                'Phone Number',
                                textAlign: TextAlign.start,
                              ),
                            ),
                            TextFormField(
                              key: ValueKey('phone number'),
                              focusNode: _phoneNumberFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textInputAction: TextInputAction.next,
                              onEditingComplete: _submitForm,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone_android),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'Enter your phone number',
                              ),
                              onSaved: (value) {
                                _phoneNumber = int.parse(value!);
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Text(
                                'Password',
                                textAlign: TextAlign.start,
                              ),
                            ),
                            TextFormField(
                              key: ValueKey('Password'),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 7) {
                                  return 'Please enter a valid Password';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              focusNode: _passwordFocusNode,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                labelText: 'Password',
                              ),
                              onSaved: (value) {
                                _password = value!;
                              },
                              obscureText: _obscureText,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_phoneNumberFocusNode),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 19,
                        ),
                        TextFormField(
                          key: ValueKey('Password'),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'Please enter a valid Password';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          focusNode: _ConfirmPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            labelText: 'Confirm password',
                          ),
                          obscureText: _obscureText,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_phoneNumberFocusNode),
                        ),
                        SizedBox(
                          height: 19,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(children: [
                            Column(
                              children: [
                                Text(
                                  'User Type',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                Row(
                                  children: [
                                    Text('Lawyer'),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              getColor),
                                      value: isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isChecked = value!;
                                        });
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Text(
                                    'Tick the checkbox if you are a Lawyer')),
                          ]),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            _isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                          color: Color(0xFFBD905A),
                                        ),
                                      ),
                                    )),
                                    onPressed: _submitForm,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Sign up',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    )),
                            SizedBox(width: 20),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account ?',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: widget.showLoginPage,
                              // () {
                              //   Navigator.of(context).push(MaterialPageRoute(
                              //       builder: ((context) => LoginPage(
                              //             showSignUpPage: () {},
                              //           ))));
                              // },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}


































// class SignUpPage extends StatefulWidget {
//   VoidCallback showLoginPage;
//   SignUpPage({super.key, required this.showLoginPage});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   bool isChecked = false;
//   bool _obscureText = true;
//   bool _isLoading = false;
//   String? errorMessage = '';
//   String _emailAddress = '';
//   String _password = '';
//   String _fullName = '';
//   late String url;
//   late int _phoneNumber;
//   File? _pickedImage;

//   final FocusNode _passwordFocusNode = FocusNode();
//   final FocusNode _emailFocusNode = FocusNode();
//   final FocusNode _phoneNumberFocusNode = FocusNode();
//   final _formKey = GlobalKey<FormState>();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   //text controllers
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmpasswordController =
//       TextEditingController();
//   final TextEditingController _checkboxController = TextEditingController();

//   @override
//   Color getColor(Set<MaterialState> states) {
//     const Set<MaterialState> interactiveStates = <MaterialState>{
//       MaterialState.pressed,
//       MaterialState.hovered,
//       MaterialState.focused,
//     };
//     if (states.any(interactiveStates.contains)) {
//       return Colors.blue;
//     }
//     return Colors.green;
//   }

//   // @override
//   // void dispose() {
//   //   _emailController.dispose();
//   //   _passwordController.dispose();
//   //   _phoneController.dispose();
//   //   _usernameController.dispose();
//   //   _confirmpasswordController.dispose();
//   // }

//   @override
//   void dispose() {
//     _passwordFocusNode.dispose();
//     _emailFocusNode.dispose();
//     _phoneNumberFocusNode.dispose();
//     super.dispose();
//   }

//   // submit button here
//   void _submitForm() async {
//     final isValid = _formKey.currentState!.validate();
//     FocusScope.of(context).unfocus();
//     var date = DateTime.now().toString();
//     var dateparse = DateTime.parse(date);
//     var formattedDate =
//         "${dateparse.day} - ${dateparse.month}- ${dateparse.year}";
//     if (isValid) {
//       _formKey.currentState!.save();
//       try {
//         if (_pickedImage == null) {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 content: Text('Please Pick an Image'),
//               );
//             },
//           );
//         } else {
//           setState(() {
//             _isLoading = true;
//           });
//           final ref = FirebaseStorage.instance
//               .ref()
//               .child('userimages')
//               .child('$_fullName.jpg');
//           await ref.putFile(_pickedImage!);
//           url = await ref.getDownloadURL();
//           await _auth.createUserWithEmailAndPassword(
//               email: _emailAddress.toLowerCase().trim(),
//               password: _password.trim());
//           final User? user = _auth.currentUser;
//           final _uid = user!.uid;

//           user.updatePhotoURL(url);
//           user.updateDisplayName(_fullName);
//           user.reload();

//           await FirebaseFirestore.instance.collection('users').doc(_uid).set({
//             'id': _uid,
//             'name': _fullName,
//             'email': _emailAddress,
//             'phone': _phoneNumber,
//             'imageUrl': url,
//             'joinedAt': formattedDate,
//             'createdAt': Timestamp.now(),
//           });
//           Navigator.canPop(context) ? Navigator.pop(context) : null;
//         }
//       } catch (error) {
//         print('Error occured ${error}');
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   // void registerShipperUser() async {
//   //   setState(() {
//   //     _isLoading = true;
//   //   });
//   //   String res = await AuthShipperMethods().registerShipperUser(
//   //     userName: _usernameController.text,
//   //     phoneNumber: _phoneController.text,
//   //     email: _emailController.text,
//   //     password: _passwordController.text,
//   //     lawyer: isChecked,
//   //   );

//   //   setState(() {
//   //     _isLoading = false;
//   //   });
//   //   if (res != "successfully") {
//   //     if (!mounted) {
//   //       return;
//   //     }
//   //     showSnackBar(res, context);
//   //   } else {
//   //     if (!mounted) {
//   //       return;
//   //     }
//   //     Navigator.of(context).pushReplacementNamed(
//   //       HomePage.id,
//   //     );
//   //   }
//   // }

//   // Future signUp() async {
//   //   showDialog(
//   //       context: context,
//   //       builder: (context) {
//   //         return Center(
//   //           child: CircularProgressIndicator(
//   //             color: Color(0xFFBD905A),
//   //           ),
//   //         );
//   //       });
//   //   if (passwordconfirmed()) {
//   //     try {
//   //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//   //           email: _emailController.text.trim(),
//   //           password: _passwordController.text.trim());
//   //     } on FirebaseAuthException catch (e) {
//   //       setState(() {
//   //         errorMessage = e.message;
//   //       });
//   //     }
//   //     addUserDetails(
//   //       _usernameController.text.trim(),
//   //       _emailController.text.trim(),
//   //       int.parse(_phoneController.text.trim()),
//   //       _passwordController.text.trim(),
//   //       _checkboxController.text.trim(),
//   //     );
//   //   }
//   //   Navigator.of(context).pop();
//   // }

//   // Future addUserDetails(String username, String email, int phone,
//   //     String password, String lawyer) async {
//   //   await FirebaseFirestore.instance.collection('users').add({
//   //     'username': username,
//   //     'email': email,
//   //     'phone': phone,
//   //     'password': password,
//   //     'lawyer': isChecked,
//   //   });
//   // }

//   // bool passwordconfirmed() {
//   //   if (_passwordController.text.trim() ==
//   //       _confirmpasswordController.text.trim()) {
//   //     return true;
//   //   } else {
//   //     return false;
//   //   }
//   // }

//   Widget _errorMessage() {
//     return Container(
//       padding: EdgeInsets.only(left: 30, top: 10, right: 20),
//       child: Text(
//         errorMessage == '' ? '' : 'Humm ? $errorMessage',
//         style: TextStyle(color: Colors.red),
//       ),
//     );
//   }

//   void _pickImageCamera() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.camera);
//     final pickedImageFile = File(pickedImage!.path);
//     setState(() {
//       _pickedImage = pickedImageFile;
//     });
//     Navigator.pop(context);
//   }

//   void _pickImageGallery() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//     final pickedImageFile = File(pickedImage!.path);
//     setState(() {
//       _pickedImage = pickedImageFile;
//     });
//     Navigator.pop(context);
//   }

//   void _remove() {
//     setState(() {
//       _pickedImage = null;
//     });
//     Navigator.pop(context);
//   }

//   Widget _submitButton() {
//     return GestureDetector(
//       onTap: _submitForm,
//       child: Container(
//         padding: const EdgeInsets.all(25),
//         margin: const EdgeInsets.symmetric(horizontal: 25),
//         decoration: BoxDecoration(
//           color: Colors.black,
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: const Center(
//           child: Text(
//             'SignUp',
//             style: TextStyle(
//               color: Color(0xFFBD905A),
//               fontWeight: FontWeight.bold,
//               fontSize: 17,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Column(
//                   children: [
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(
//                             text: 'Signup',
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           WidgetSpan(
//                             child: SizedBox(
//                               width: 5,
//                             ),
//                           ),
//                           WidgetSpan(
//                             child: Image.asset('assets/user.png'),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                         'hello, Sign up to access the legal associate Program'),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Stack(
//                   children: [
//                     Container(
//                       margin:
//                           EdgeInsets.symmetric(vertical: 30, horizontal: 30),
//                       child: CircleAvatar(
//                         radius: 71,
//                         backgroundColor: Colors.grey,
//                         child: CircleAvatar(
//                           radius: 65,
//                           backgroundColor: Colors.red,
//                           backgroundImage: _pickedImage == null
//                               ? null
//                               : FileImage(_pickedImage!),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                         top: 120,
//                         left: 110,
//                         child: RawMaterialButton(
//                           elevation: 10,
//                           fillColor: Colors.grey,
//                           child: Icon(Icons.add_a_photo),
//                           padding: EdgeInsets.all(15.0),
//                           shape: CircleBorder(),
//                           onPressed: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: Text(
//                                       'Choose option',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                     content: SingleChildScrollView(
//                                       child: ListBody(
//                                         children: [
//                                           InkWell(
//                                             onTap: _pickImageCamera,
//                                             splashColor: Colors.purpleAccent,
//                                             child: Row(
//                                               children: [
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8.0),
//                                                   child: Icon(
//                                                     Icons.camera,
//                                                     color: Colors.purpleAccent,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   'Camera',
//                                                   style: TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.w500,
//                                                     color: Colors.grey,
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                           InkWell(
//                                             onTap: _pickImageGallery,
//                                             splashColor: Colors.purpleAccent,
//                                             child: Row(
//                                               children: [
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8.0),
//                                                   child: Icon(
//                                                     Icons.image,
//                                                     color: Colors.purpleAccent,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   'Gallery',
//                                                   style: TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.w500,
//                                                     color: Colors.grey,
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                           InkWell(
//                                             onTap: _remove,
//                                             splashColor: Colors.purpleAccent,
//                                             child: Row(
//                                               children: [
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8.0),
//                                                   child: Icon(
//                                                     Icons.remove_circle,
//                                                     color: Colors.red,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   'Remove',
//                                                   style: TextStyle(
//                                                       fontSize: 18,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       color: Colors.red),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 });
//                           },
//                         ))
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 10, horizontal: 38),
//                       child: Text(
//                         'Name',
//                         textAlign: TextAlign.start,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 25,
//                       ),
//                       child: TextFormField(
//                         key: ValueKey('name'),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'name should not be empty';
//                           }
//                           return null;
//                         },
//                         textInputAction: TextInputAction.next,
//                         onEditingComplete: () => FocusScope.of(context)
//                             .requestFocus(_emailFocusNode),
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.person),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           hintText: 'Enter your full names',
//                         ),
//                         onSaved: (value) {
//                           _fullName = value!;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 7,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 10, horizontal: 38),
//                       child: Text(
//                         'Email',
//                         textAlign: TextAlign.start,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 25,
//                       ),
//                       child: TextFormField(
//                         key: ValueKey('email'),
//                         focusNode: _emailFocusNode,
//                         validator: (value) {
//                           if (value!.isEmpty || !value.contains('@')) {
//                             return 'Please enter a valid email address';
//                           }
//                           return null;
//                         },
//                         textInputAction: TextInputAction.next,
//                         onEditingComplete: () => FocusScope.of(context)
//                             .requestFocus(_passwordFocusNode),
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.email),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           hintText: 'Enter your email Address',
//                         ),
//                         onSaved: (value) {
//                           _emailAddress = value!;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 7,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 10, horizontal: 38),
//                       child: Text(
//                         'Phone',
//                         textAlign: TextAlign.start,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 25,
//                       ),
//                       child: TextFormField(
//                         key: ValueKey('phone number'),
//                         focusNode: _phoneNumberFocusNode,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter a valid phone number';
//                           }
//                           return null;
//                         },
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly
//                         ],
//                         textInputAction: TextInputAction.next,
//                         onEditingComplete: _submitForm,
//                         keyboardType: TextInputType.phone,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.phone_android),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           hintText: 'Enter your phone number',
//                         ),
//                         onSaved: (value) {
//                           _phoneNumber = int.parse(value!);
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 7,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 10, horizontal: 38),
//                       child: Text(
//                         'Password',
//                         textAlign: TextAlign.start,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 25,
//                       ),
//                       child: TextFormField(
//                         key: ValueKey('Password'),
//                         validator: (value) {
//                           if (value!.isEmpty || value.length < 7) {
//                             return 'Please enter a valid Password';
//                           }
//                           return null;
//                         },
//                         keyboardType: TextInputType.emailAddress,
//                         focusNode: _passwordFocusNode,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           prefixIcon: Icon(Icons.lock),
//                           suffixIcon: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 _obscureText = !_obscureText;
//                               });
//                             },
//                             child: Icon(_obscureText
//                                 ? Icons.visibility
//                                 : Icons.visibility_off),
//                           ),
//                           labelText: 'Password',
//                         ),
//                         onSaved: (value) {
//                           _password = value!;
//                         },
//                         obscureText: _obscureText,
//                         onEditingComplete: () => FocusScope.of(context)
//                             .requestFocus(_phoneNumberFocusNode),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 7,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//                       child: TextFormField(
//                         obscureText: true,
//                         controller: _confirmpasswordController,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.confirmation_num),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           hintText: 'Confirm the password',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 30),
//                   child: Row(children: [
//                     Column(
//                       children: [
//                         Text(
//                           'User Type',
//                           style: TextStyle(color: Colors.grey[700]),
//                         ),
//                         Row(
//                           children: [
//                             Text('Lawyer'),
//                             Checkbox(
//                               checkColor: Colors.white,
//                               fillColor:
//                                   MaterialStateProperty.resolveWith(getColor),
//                               value: isChecked,
//                               onChanged: (bool? value) {
//                                 setState(() {
//                                   isChecked = value!;
//                                 });
//                               },
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Expanded(
//                         child: Text('Tick the checkbox if you are a Lawyer')),
//                   ]),
//                 ),
//                 _errorMessage(),
//                 SizedBox(
//                   height: 9,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(width: 10),
//                     _isLoading
//                         ? CircularProgressIndicator()
//                         : ElevatedButton(
//                             style: ButtonStyle(
//                                 shape: MaterialStateProperty.all<
//                                     RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30.0),
//                                 side: BorderSide(color: Colors.blue),
//                               ),
//                             )),
//                             onPressed: _submitForm,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Sign up',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 17),
//                                 ),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 Icon(
//                                   Icons.person,
//                                   size: 18,
//                                 )
//                               ],
//                             )),
//                     SizedBox(width: 20),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Already have an account ?',
//                       style: TextStyle(color: Colors.grey[700]),
//                     ),
//                     const SizedBox(width: 10),
//                     InkWell(
//                       onTap: widget.showLoginPage,
//                       // () {
//                       //   Navigator.of(context).push(MaterialPageRoute(
//                       //       builder: ((context) => LoginPage(
//                       //             showSignUpPage: () {},
//                       //           ))));
//                       // },
//                       child: const Text(
//                         'Login',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 40,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
