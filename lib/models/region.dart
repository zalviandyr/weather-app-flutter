class Region {
  final String id;
  final String provinsi;
  final String kota;
  final String kecamatan;

  Region({
    required this.id,
    required this.provinsi,
    required this.kota,
    required this.kecamatan,
  });

  static List<Region> toList(dynamic json) {
    List<Region> regions = [];

    for (var item in json) {
      regions.add(
        Region(
          id: item['id'],
          provinsi: item['propinsi'],
          kota: item['kota'],
          kecamatan: item['kecamatan'],
        ),
      );
    }

    return regions;
  }
}
