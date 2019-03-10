class Home {
  List<EBOOKAPP> eBOOKAPP;

  Home({this.eBOOKAPP});

  Home.fromJson(Map<String, dynamic> json) {
    if (json['EBOOK_APP'] != null) {
      eBOOKAPP = new List<EBOOKAPP>();
      json['EBOOK_APP'].forEach((v) {
        eBOOKAPP.add(new EBOOKAPP.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eBOOKAPP != null) {
      data['EBOOK_APP'] = this.eBOOKAPP.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EBOOKAPP {
  String id;
  String catId;
  String aid;
  String bookTitle;
  String bookDescription;
  String bookCoverImg;
  String bookBgImg;
  String bookFileType;
  String totalRate;
  String rateAvg;
  String bookViews;
  String authorId;
  String authorName;
  String cid;
  String categoryName;

  EBOOKAPP(
      {this.id,
        this.catId,
        this.aid,
        this.bookTitle,
        this.bookDescription,
        this.bookCoverImg,
        this.bookBgImg,
        this.bookFileType,
        this.totalRate,
        this.rateAvg,
        this.bookViews,
        this.authorId,
        this.authorName,
        this.cid,
        this.categoryName});

  EBOOKAPP.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    aid = json['aid'];
    bookTitle = json['book_title'];
    bookDescription = json['book_description'];
    bookCoverImg = json['book_cover_img'];
    bookBgImg = json['book_bg_img'];
    bookFileType = json['book_file_type'];
    totalRate = json['total_rate'];
    rateAvg = json['rate_avg'];
    bookViews = json['book_views'];
    authorId = json['author_id'];
    authorName = json['author_name'];
    cid = json['cid'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['aid'] = this.aid;
    data['book_title'] = this.bookTitle;
    data['book_description'] = this.bookDescription;
    data['book_cover_img'] = this.bookCoverImg;
    data['book_bg_img'] = this.bookBgImg;
    data['book_file_type'] = this.bookFileType;
    data['total_rate'] = this.totalRate;
    data['rate_avg'] = this.rateAvg;
    data['book_views'] = this.bookViews;
    data['author_id'] = this.authorId;
    data['author_name'] = this.authorName;
    data['cid'] = this.cid;
    data['category_name'] = this.categoryName;
    return data;
  }
}