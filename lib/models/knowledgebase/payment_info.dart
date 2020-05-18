class PaymentInfo{
  String paymentId;
  String amountPaid;

  PaymentInfo({
    this.paymentId,
    this.amountPaid
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
      return PaymentInfo(
        paymentId: json["id"],
        amountPaid: json["amount_paid"].toStringAsFixed(0),
    );
    } 
}