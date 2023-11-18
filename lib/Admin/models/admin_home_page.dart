class AdminHomePageModel {
  double? totalBalance;
  double? bookings;
  double? paymentBookingAmount;
  double? adsAmount;
  double? users;
  double? compnaiesRecruitment;
  double? compnaiesCleaning;
  List<BookingsCountGraph>? bookingsCountGraph;
  List<BookingPaymentsGraph>? bookingPaymentsGraph;
  List<AdsPaymentsGraph>? adsPaymentsGraph;

  AdminHomePageModel(
      {this.bookings,
      this.totalBalance,
      this.paymentBookingAmount,
      this.adsAmount,
      this.users,
      this.compnaiesRecruitment,
      this.compnaiesCleaning,
      this.bookingsCountGraph,
      this.bookingPaymentsGraph,
      this.adsPaymentsGraph});

  AdminHomePageModel.fromJson(Map<String, dynamic> json) {
    bookings = json['bookings'].toDouble();
    totalBalance = json['Total_balance'].toDouble();
    paymentBookingAmount = json['payment_booking_amount'].toDouble();
    adsAmount = json['ads_amount'].toDouble();
    users = json['users'].toDouble();
    compnaiesRecruitment = json['compnaies_recruitment'].toDouble();
    compnaiesCleaning = json['compnaies_cleaning'].toDouble();
    if (json['bookings_count_graph'] != null) {
      bookingsCountGraph = <BookingsCountGraph>[];
      json['bookings_count_graph'].forEach((v) {
        bookingsCountGraph!.add(BookingsCountGraph.fromJson(v));
      });
    }
    if (json['booking_payments_graph'] != null) {
      bookingPaymentsGraph = <BookingPaymentsGraph>[];
      json['booking_payments_graph'].forEach((v) {
        bookingPaymentsGraph!.add(BookingPaymentsGraph.fromJson(v));
      });
    }
    if (json['ads_payments_graph'] != null) {
      adsPaymentsGraph = <AdsPaymentsGraph>[];
      json['ads_payments_graph'].forEach((v) {
        adsPaymentsGraph!.add(AdsPaymentsGraph.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookings'] = bookings;
    data['Total_balance'] = totalBalance;
    data['payment_booking_amount'] = paymentBookingAmount;
    data['ads_amount'] = adsAmount;
    data['users'] = users;
    data['compnaies_recruitment'] = compnaiesRecruitment;
    data['compnaies_cleaning'] = compnaiesCleaning;
    if (bookingsCountGraph != null) {
      data['bookings_count_graph'] =
          bookingsCountGraph!.map((v) => v.toJson()).toList();
    }
    if (bookingPaymentsGraph != null) {
      data['booking_payments_graph'] =
          bookingPaymentsGraph!.map((v) => v.toJson()).toList();
    }
    if (adsPaymentsGraph != null) {
      data['ads_payments_graph'] =
          adsPaymentsGraph!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingsCountGraph {
  double? bookingCount;
  String? month;

  BookingsCountGraph({this.bookingCount, this.month});

  BookingsCountGraph.fromJson(Map<String, dynamic> json) {
    bookingCount = json['bookingCount'].toDouble();
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookingCount'] = bookingCount;
    data['month'] = month;
    return data;
  }
}

class BookingPaymentsGraph {
  double? bookingAmount;
  String? month;

  BookingPaymentsGraph({this.bookingAmount, this.month});

  BookingPaymentsGraph.fromJson(Map<String, dynamic> json) {
    bookingAmount = json['bookingAmount'].toDouble();
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookingAmount'] = bookingAmount;
    data['month'] = month;
    return data;
  }
}

class AdsPaymentsGraph {
  double? adsAmount;
  String? month;

  AdsPaymentsGraph({this.adsAmount, this.month});

  AdsPaymentsGraph.fromJson(Map<String, dynamic> json) {
    adsAmount = json['adsAmount'].toDouble();

    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adsAmount'] = adsAmount;
    data['month'] = month;
    return data;
  }
}
