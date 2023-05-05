class CategoryModal {
  final String title, thumb, m3u_link;

  CategoryModal(
      {required this.title, required this.thumb, required this.m3u_link});
  factory CategoryModal.from(dynamic data) {
    return CategoryModal(
        title: data['title'], thumb: data['thumb'], m3u_link: data['m3u_link']);
  }
}
