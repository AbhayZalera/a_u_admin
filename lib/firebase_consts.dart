import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance; //For Authentication
FirebaseFirestore fireStore = FirebaseFirestore.instance;//For Enter or Get DAta From the Firebase
User? currentUser = auth.currentUser;

//collection
const usersCollection = "users";
const productCollection = "products";
const cartCollection = "cart";
const chatsCollection = 'chats';
const messagesCollection = 'message';
const ordersCollection = 'orders';
const vendorsCollection = 'vendors';



