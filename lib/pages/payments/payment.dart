import 'package:badges/badges.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_care/models/knowledgebase/payment_info.dart';
import 'package:patient_care/pages/kb/kb_topics.dart';
import 'package:patient_care/services/kb-api.dart';
import 'package:patient_care/services/payment-api.dart';
import 'package:patient_care/utilities/utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:shimmer/shimmer.dart';
import 'package:status_alert/status_alert.dart';

import '../modules_menu.dart';

class Payments extends StatefulWidget {
  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  EncryptedSharedPreferences pref;
  String username;
  String appId, locationId;
  double amount;
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    pref = EncryptedSharedPreferences();
    String user = await pref.getString('user_id');
    if (user != null) {
      setState(() {
        username = user;
      });
    }

    fetchSquareInfo().then((value) {
      setState(() {
        appId = value[0];
        locationId = value[1];
      });
    });

    fetchAmount().then((value) {
      setState(() {
        amount = value;
      });
    });
  }

  void _pay() {
    InAppPayments.setSquareApplicationId(appId);
    InAppPayments.startCardEntryFlow(
      onCardNonceRequestSuccess: _cardNonceRequestSuccess,
      onCardEntryCancel: _cardEntryCancel,
    );
  }

  void _cardNonceRequestSuccess(CardDetails result) {
    processPayment(result.nonce, amount, username, locationId).then((value) {
      String status;
      value == 'INVALID_EXPIRATION'
          ? status = 'Invalid Expiry Date'
          : value == 'CVV_FAILURE'
              ? status = 'Invalid CVV'
              : value == 'ADDRESS_VERIFICATION_FAILURE'
                  ? status = 'Invalid Postal Code'
                  : value == 'GENERIC_DECLINE'
                      ? status = 'Card Number Declined'
                      : status = 'Success';
      if (status != 'Success') {
        InAppPayments.showCardNonceProcessingError(status);
      } else {
        InAppPayments.completeCardEntry(
          onCardEntryComplete: _cardEntryComplete,
        );
      }
    });
  }

  void _cardEntryComplete() {
    //Successfully Charged
    setState(() {});
    markPremiumUser();
    StatusAlert.show(
      context,
      duration: Duration(seconds: 2),
      title: 'Subscribed',
      configuration: IconConfiguration(icon: Icons.done),
    );
  }

  void _cardEntryCancel() {
    //Cancelled Card Entry
    showAlert(context, "Payment Cancelled", "Subscription Cancelled");
  }

  @override
  Widget build(BuildContext context) {
    List<PaymentInfo> paymentInfo = [];

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.teal,
            title: Text('Payment',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => KBTopics()));
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ModulesMenu()));
                },
              ),
              // action button
            ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: FutureBuilder(
                future: fetchPayment(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    if (snapshot.hasError) {
                      showAlert(context, "Connection Failed", snapshot.data);
                    }
                    paymentInfo = snapshot.data;
                    if (paymentInfo.isNotEmpty) {
                      return subscribedWidget(paymentInfo);
                    } else {
                      return priceWidget(amount);
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
        floatingActionButton: paymentInfo.length > 0
            ? FloatingActionButton(
                onPressed: _pay,
                tooltip: 'Payment',
                child: Icon(Icons.payment),
              )
            : Container());
  }

  Container priceWidget(amount) {
    return Container(
      child: CupertinoButton(
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.teal.shade100,
              Colors.teal.shade200,
              Colors.teal.shade300
            ]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Text(
                    '\$' + amount.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 46,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Column(
                    children: [
                      Text(
                        'Knowledgebase',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Premium Subscription',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Colors.yellow,
                      child: GestureDetector(
                        onTap: _pay,
                        child: Text(
                          'Subscribe Now',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
        onPressed: () {},
      ),
    );
  }

  Container subscribedWidget(List<PaymentInfo> paymentInfo) {
    return Container(
      child: CupertinoButton(
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.teal.shade100,
              Colors.teal.shade200,
              Colors.teal.shade300
            ]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Text(
                    '\$${paymentInfo[0].amountPaid}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 46,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Column(
                    children: [
                      Text(
                        'Knowledgebase',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Premium Subscription',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Colors.yellow,
                      child: Text(
                        'Subscription Paid',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.w600),
                      )),
                )
              ],
            ),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
