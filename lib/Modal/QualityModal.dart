class QualityModal {
  final String quality, link;

  QualityModal({required this.quality, required this.link});
  factory QualityModal.from(dynamic data) {
    return QualityModal(quality: data['name'], link: data['link']);
  }
}
