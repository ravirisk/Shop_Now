import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_now/model/order_model.dart';
import 'package:shop_now/repository/auth/auth_repo.dart';

class OrderRepo {
  var orderCollection = FirebaseFirestore.instance.collection("Orders");
  final uid = AuthRepo().user.uid;

  Future<List<OrderModel>> fetchOrders() async {
    print('method called');
    try {
      final list = await orderCollection
          .where("uid", isEqualTo: uid)
          .get()
          .then((snapshot) => snapshot.docs.map((doc) {
                var data = doc.data()!;
                print(data);
                return OrderModel.fromMap(data);
              }).toList());
      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<String?> createOrder(OrderModel newOrderModel) async {
    try {
      await orderCollection.doc(newOrderModel.id).set(newOrderModel.toMap());
      return null;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
