class Orders {
  final String Customer_Name;
  final String Order_ID;
  final String Invoice_ID;
  final String Rider_ID;
  final String Total_Amount;
  final String Status;
  final String Id;

  Orders({
    required this.Customer_Name,
    required this.Order_ID,
    required this.Invoice_ID,
    required this.Rider_ID,
    required this.Total_Amount,
    required this.Id,
    required this.Status,
  });
}

List<Orders> orders = [
  Orders(
      Customer_Name: "Kavya",
      Order_ID: "dfg",
      Invoice_ID: "sdfg",
      Rider_ID: "dfgh",
      Total_Amount: "1000",
      Id: "dfg",
      Status: "pending"),
  Orders(
      Customer_Name: "Kavya",
      Order_ID: "dfg",
      Invoice_ID: "sdfg",
      Rider_ID: "dfgh",
      Total_Amount: "1000",
      Id: "dfg",
      Status: "pending"),
  Orders(
      Customer_Name: "Kavya",
      Order_ID: "dfg",
      Invoice_ID: "sdfg",
      Rider_ID: "dfgh",
      Total_Amount: "1000",
      Id: "dfg",
      Status: "pending"),
  Orders(
      Customer_Name: "Kavya",
      Order_ID: "dfg",
      Invoice_ID: "sdfg",
      Rider_ID: "dfgh",
      Total_Amount: "1000",
      Id: "dfg",
      Status: "pending"),
];
