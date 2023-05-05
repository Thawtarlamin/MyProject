class SubCategoryModal {
   String? title;
  String? group;
  String? thumbSquare;
  String? mediaUrl;

  SubCategoryModal(
      {this.title,this.group,this.thumbSquare,this.mediaUrl});

  SubCategoryModal.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    group = json['group'];
    thumbSquare = json['thumb_square'];
    mediaUrl = json['media_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['group'] = this.group;
    data['thumb_square'] = this.thumbSquare;
    data['media_url'] = this.mediaUrl;
    return data;
  }
}
