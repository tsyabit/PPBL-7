class Layanan {
  final String nama, bidang, deskripsi;
  const Layanan(this.nama, this.bidang, this.deskripsi);
}

const daftarLayanan = [
  Layanan(
    'Izin Usaha Mikro',
    'Perizinan',
    'Pengajuan izin usaha mikro. Siapkan NIK dan alamat usaha.',
  ),
  Layanan(
    'Izin Bangunan',
    'Perizinan',
    'Konsultasi persyaratan bangunan dan dokumen kepemilikan.',
  ),
  Layanan(
    'Pendaftaran Puskesmas',
    'Kesehatan',
    'Pendaftaran kunjungan layanan kesehatan warga.',
  ),
  Layanan(
    'Konsultasi Gizi',
    'Kesehatan',
    'Permohonan jadwal konsultasi gizi keluarga.',
  ),
  Layanan(
    'Kartu Transportasi',
    'Transportasi',
    'Pengajuan kartu transportasi warga.',
  ),
  Layanan(
    'Pengaduan Angkutan',
    'Transportasi',
    'Pengaduan pelayanan angkutan umum.',
  ),
];
