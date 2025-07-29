class CardModel {
 final String? id;
 final String?  userId;
 final String cardHolderName;
 final String cardNumber;
 final String expiryDate;
 final String cvv;
 final bool primaryCard;
 final String? createdAt;

 CardModel ({
  this.id,
  this.userId,
  required this.cardHolderName,
  required this.cardNumber,
  required this.expiryDate,
  required this.cvv,
  required this.primaryCard,
  this.createdAt
 });

 Map<String,dynamic> toJson() => {
  "cardHolderName":cardHolderName,
  "cardNumber":cardNumber,
  "expiryDate":expiryDate,
  "cvv":cvv,
  "primaryCard":primaryCard
 };

 factory CardModel.fromJson(Map<String,dynamic> json){
  return CardModel(
      id: json["id"],
      userId: json["userId"],
      cardHolderName: json["cardHolderName"],
      cardNumber: json["cardNumber"],
      expiryDate: json["expiryDate"],
      cvv: json["cvv"],
      primaryCard: json["primaryCard"]
  );
 }

}