--
-- Table structure for table `data_catatan_rfk_unit`
--

CREATE TABLE `data_catatan_rfk_unit` (
  `id` int(11) NOT NULL,
  `bulan` tinyint(2) NOT NULL,
  `catatan_ka_adbang` text NOT NULL,
  `id_skpd` int(11) NOT NULL,
  `tahun_anggaran` year(4) NOT NULL,
  `created_by` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` text NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for table `data_catatan_rfk_unit`
--
ALTER TABLE `data_catatan_rfk_unit`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `data_catatan_rfk_unit`
--
ALTER TABLE `data_catatan_rfk_unit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;
COMMIT;

--
-- Table structure for table `data_unit`
--
CREATE TABLE `data_unit` (
  `id` int(11) NOT NULL,
  `id_setup_unit` int(11) DEFAULT NULL,
  `id_unit` int(11) DEFAULT NULL,
  `is_skpd` tinyint(4) DEFAULT NULL,
  `kode_skpd` varchar(50) DEFAULT NULL,
  `kunci_skpd` int(11) DEFAULT NULL,
  `nama_skpd` text DEFAULT NULL,
  `posisi` varchar(30) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `id_skpd` int(11) DEFAULT NULL,
  `bidur_1` smallint(6) DEFAULT NULL,
  `bidur_2` smallint(6) DEFAULT NULL,
  `bidur_3` smallint(6) DEFAULT NULL,
  `idinduk` int(11) DEFAULT NULL,
  `ispendapatan` tinyint(4) DEFAULT NULL,
  `isskpd` tinyint(4) DEFAULT NULL,
  `kode_skpd_1` varchar(10) DEFAULT NULL,
  `kode_skpd_2` varchar(10) DEFAULT NULL,
  `kodeunit` varchar(30) DEFAULT NULL,
  `komisi` int(11) DEFAULT NULL,
  `namabendahara` text,
  `namakepala` text DEFAULT NULL,
  `namaunit` text DEFAULT NULL,
  `nipbendahara` varchar(30) DEFAULT NULL,
  `nipkepala` varchar(30) DEFAULT NULL,
  `pangkatkepala` varchar(50) DEFAULT NULL,
  `setupunit` int(11) DEFAULT NULL,
  `statuskepala` varchar(20) DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `tahun_anggaran` year(4) NOT NULL DEFAULT '2021',
  `active` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- 
--
-- Table structure for table `data_akun`
--
CREATE TABLE `data_akun` (
  `id` int(11) NOT NULL,
  `belanja` varchar(10) DEFAULT NULL,
  `id_akun` int(11) DEFAULT NULL,
  `is_bagi_hasil` tinyint(4) DEFAULT NULL,
  `is_bankeu_khusus` tinyint(4) DEFAULT NULL,
  `is_bankeu_umum` tinyint(4) DEFAULT NULL,
  `is_barjas` tinyint(4) DEFAULT NULL,
  `is_bl` tinyint(4) DEFAULT NULL,
  `is_bos` tinyint(4) DEFAULT NULL,
  `is_btt` tinyint(4) DEFAULT NULL,
  `is_bunga` tinyint(4) DEFAULT NULL,
  `is_gaji_asn` tinyint(4) DEFAULT NULL,
  `is_hibah_brg` tinyint(4) DEFAULT NULL,
  `is_hibah_uang` tinyint(4) DEFAULT NULL,
  `is_locked` tinyint(4) DEFAULT NULL,
  `is_modal_tanah` tinyint(4) DEFAULT NULL,
  `is_pembiayaan` tinyint(4) DEFAULT NULL,
  `is_pendapatan` tinyint(4) DEFAULT NULL,
  `is_sosial_brg` tinyint(4) DEFAULT NULL,
  `is_sosial_uang` tinyint(4) DEFAULT NULL,
  `is_subsidi` tinyint(4) DEFAULT NULL,
  `kode_akun` varchar(50) DEFAULT NULL,
  `nama_akun` text DEFAULT NULL,
  `set_input` tinyint(4) DEFAULT NULL,
  `set_lokus` tinyint(4) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `tahun_anggaran` year(4) NOT NULL DEFAULT '2021'
) ENGINE = InnoDB DEFAULT CHARSET = latin1;
-- 
--
-- Table structure for table `data_rka`
--
CREATE TABLE `data_rka` (
  `id` int(11) NOT NULL,
  `created_user` int(11) DEFAULT NULL,
  `createddate` varchar(10) DEFAULT NULL,
  `createdtime` varchar(10) DEFAULT NULL,
  `harga_satuan` double(20, 0) DEFAULT NULL,
  `harga_satuan_murni` double(20, 0) DEFAULT NULL,
  `id_daerah` int(11) DEFAULT NULL,
  `id_rinci_sub_bl` int(11) DEFAULT NULL,
  `id_standar_nfs` tinyint(4) DEFAULT NULL,
  `is_locked` tinyint(4) DEFAULT NULL,
  `jenis_bl` varchar(50) DEFAULT NULL,
  `ket_bl_teks` text DEFAULT NULL,
  `kode_akun` varchar(50) DEFAULT NULL,
  `koefisien` text DEFAULT NULL,
  `koefisien_murni` text DEFAULT NULL,
  `lokus_akun_teks` text DEFAULT NULL,
  `nama_akun` text DEFAULT NULL,
  `nama_komponen` text DEFAULT NULL,
  `spek_komponen` text DEFAULT NULL,
  `satuan` varchar(50) DEFAULT NULL,
  `spek` text DEFAULT NULL,
  `sat1` text DEFAULT NULL,
  `sat2` text DEFAULT NULL,
  `sat3` text DEFAULT NULL,
  `sat4` text DEFAULT NULL,
  `volum1` text DEFAULT NULL,
  `volum2` text DEFAULT NULL,
  `volum3` text DEFAULT NULL,
  `volum4` text DEFAULT NULL,
  `volume` text DEFAULT NULL,
  `volume_murni` text DEFAULT NULL,
  `subs_bl_teks` text DEFAULT NULL,
  `total_harga` double(20, 0) DEFAULT NULL,
  `rincian` double(20, 0) DEFAULT NULL,
  `rincian_murni` double(20, 0) DEFAULT NULL,
  `totalpajak` double(20, 0) DEFAULT NULL,
  `pajak` double(20, 0) DEFAULT NULL,
  `pajak_murni` double(20, 0) DEFAULT NULL,
  `updated_user` int(11) DEFAULT NULL,
  `updateddate` varchar(20) DEFAULT NULL,
  `updatedtime` varchar(20) DEFAULT NULL,
  `user1` text DEFAULT NULL,
  `user2` text DEFAULT NULL,
  `active` tinyint(4) DEFAULT 1,
  `update_at` datetime DEFAULT NULL,
  `tahun_anggaran` year(4) NOT NULL DEFAULT '2021',
  `idbl` int(11) DEFAULT NULL,
  `idsubbl` int(11) DEFAULT NULL,
  `kode_bl` varchar(50) NOT NULL,
  `kode_sbl` varchar(50) NOT NULL,
  `id_prop_penerima` int(11) DEFAULT NULL,
  `id_camat_penerima` int(11) DEFAULT NULL,
  `id_kokab_penerima` int(11) DEFAULT NULL,
  `id_lurah_penerima` int(11) DEFAULT NULL,
  `id_penerima` int(11) DEFAULT NULL,
  `idkomponen` double(20, 0) DEFAULT NULL,
  `idketerangan` int(11) DEFAULT NULL,
  `idsubtitle` int(11) DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = latin1;
--
-- Table structure for table `data_capaian_prog_sub_keg`
--
CREATE TABLE `data_capaian_prog_sub_keg` (
  `id` int(11) NOT NULL,
  `satuancapaian` varchar(50) DEFAULT NULL,
  `targetcapaianteks` varchar(50) DEFAULT NULL,
  `capaianteks` text,
  `targetcapaian` int(11) DEFAULT NULL,
  `kode_sbl` varchar(50) DEFAULT NULL,
  `idsubbl` int(11) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1',
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Table structure for table `data_dana_sub_keg`
--
CREATE TABLE `data_dana_sub_keg` (
  `id` int(11) NOT NULL,
  `namadana` text DEFAULT NULL,
  `kodedana` varchar(50) DEFAULT NULL,
  `iddana` int(11) DEFAULT NULL,
  `iddanasubbl` int(11) DEFAULT NULL,
  `pagudana` double(20, 0) DEFAULT NULL,
  `kode_sbl` varchar(50) DEFAULT NULL,
  `idsubbl` int(11) DEFAULT NULL,
  `active` tinyint(4) DEFAULT 1,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Table structure for table `data_output_giat_sub_keg`
--
CREATE TABLE `data_output_giat_sub_keg` (
  `id` int(11) NOT NULL,
  `outputteks` text,
  `satuanoutput` varchar(50) DEFAULT NULL,
  `targetoutput` int(11) DEFAULT NULL,
  `targetoutputteks` varchar(50) DEFAULT NULL,
  `kode_sbl` varchar(50) DEFAULT NULL,
  `idsubbl` int(11) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1',
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `data_keg_indikator_hasil`
--

CREATE TABLE `data_keg_indikator_hasil` (
  `id` int(11) NOT NULL,
  `hasilteks` text,
  `satuanhasil` varchar(50) DEFAULT NULL,
  `targethasil` varchar(50) DEFAULT NULL,
  `targethasilteks` varchar(50) DEFAULT NULL,
  `kode_sbl` varchar(50) DEFAULT NULL,
  `idsubbl` varchar(50) DEFAULT NULL,
  `active` tinyint(4) DEFAULT 1,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- 
--
-- Table structure for table `data_ssh`
--
CREATE TABLE `data_ssh` (
  `id` int(11) NOT NULL,
  `id_standar_harga` int(11) DEFAULT NULL,
  `kode_standar_harga` varchar(30) DEFAULT NULL,
  `nama_standar_harga` text DEFAULT NULL,
  `satuan` text DEFAULT NULL,
  `spek` text DEFAULT NULL,
  `ket_teks` text DEFAULT NULL,
  `created_at` VARCHAR(25) DEFAULT NULL,
  `created_user` int(11) DEFAULT NULL,
  `updated_user` int(11) DEFAULT NULL,
  `is_deleted` tinyint(4) DEFAULT NULL,
  `is_locked` tinyint(4) DEFAULT NULL,
  `kelompok` tinyint(4) DEFAULT NULL,
  `harga` double(20, 0) DEFAULT NULL,
  `harga_2` double(20, 0) DEFAULT NULL,
  `harga_3` double(20, 0) DEFAULT NULL,
  `kode_kel_standar_harga` varchar(30) DEFAULT NULL,
  `nama_kel_standar_harga` text DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `tahun_anggaran` year(4) NOT NULL DEFAULT '2020'
) ENGINE = InnoDB DEFAULT CHARSET = latin1;
-- 
--
-- Table structure for table `data_ssh_rek_belanja`
--
CREATE TABLE `data_ssh_rek_belanja` (
  `id` int(11) NOT NULL,
  `id_akun` int(11) NOT NULL,
  `kode_akun` varchar(50) NOT NULL,
  `nama_akun` text NOT NULL,
  `id_standar_harga` int(11) NOT NULL,
  `tahun_anggaran` year(4) NOT NULL DEFAULT '2021'
) ENGINE = InnoDB DEFAULT CHARSET = latin1;
-- 
--
-- Table structure for table `data_sub_keg_indikator`
--
CREATE TABLE `data_sub_keg_indikator` (
  `id` int(11) NOT NULL,
  `outputteks` text NOT NULL,
  `targetoutput` int(11) NOT NULL,
  `satuanoutput` text NOT NULL,
  `idoutputbl` int(11) NOT NULL,
  `targetoutputteks` text NOT NULL,
  `kode_sbl` varchar(50) NOT NULL,
  `idsubbl` int(11) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1',
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = latin1;
-- 
--
-- Table structure for table `data_unit_pagu`
--
CREATE TABLE `data_unit_pagu` (
  `id` int(11) NOT NULL,
  `batasanpagu` double(20, 0) DEFAULT NULL,
  `id_daerah` int(11) DEFAULT NULL,
  `id_level` int(11) DEFAULT NULL,
  `id_skpd` int(11) DEFAULT NULL,
  `id_unit` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `is_anggaran` tinyint(4) DEFAULT NULL,
  `is_deleted` tinyint(4) DEFAULT NULL,
  `is_komponen` tinyint(4) DEFAULT NULL,
  `is_locked` smallint(6) DEFAULT NULL,
  `is_skpd` tinyint(4) DEFAULT NULL,
  `kode_skpd` varchar(50) DEFAULT NULL,
  `kunci_bl` tinyint(4) DEFAULT NULL,
  `kunci_bl_rinci` tinyint(4) DEFAULT NULL,
  `kuncibl` tinyint(4) DEFAULT NULL,
  `kunciblrinci` tinyint(4) DEFAULT NULL,
  `nilaipagu` double(20, 0) DEFAULT NULL,
  `nilaipagumurni` double(20, 0) DEFAULT NULL,
  `nilairincian` double(20, 0) DEFAULT NULL,
  `pagu_giat` double(20, 0) DEFAULT NULL,
  `realisasi` double(20, 0) DEFAULT NULL,
  `rinci_giat` double(20, 0) DEFAULT NULL,
  `set_pagu_giat` double(20, 0) DEFAULT NULL,
  `set_pagu_skpd` double(20, 0) DEFAULT NULL,
  `tahun` year(4) DEFAULT NULL,
  `total_giat` double(20, 0) DEFAULT NULL,
  `totalgiat` double(20, 0) DEFAULT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = latin1;
-- 
--
-- Table structure for table `data_prog_keg`
--
CREATE TABLE `data_prog_keg` (
  `id` int(11) NOT NULL,
  `id_bidang_urusan` int(11) NOT NULL,
  `id_program` int(11) NOT NULL,
  `id_sub_giat` int(11) NOT NULL,
  `id_urusan` int(11) NOT NULL,
  `is_locked` int(11) NOT NULL,
  `kode_bidang_urusan` varchar(50) NOT NULL,
  `kode_giat` varchar(50) NOT NULL,
  `kode_program` varchar(50) NOT NULL,
  `kode_sub_giat` varchar(50) NOT NULL,
  `kode_urusan` varchar(50) NOT NULL,
  `nama_bidang_urusan` text NOT NULL,
  `nama_giat` text NOT NULL,
  `nama_program` text NOT NULL,
  `nama_sub_giat` text NOT NULL,
  `nama_urusan` text NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL DEFAULT '2021'
) ENGINE = InnoDB DEFAULT CHARSET = latin1;
-- 
--
-- Table structure for table `data_rpjmd`
--
CREATE TABLE `data_rpjmd` (
  `id` int(11) NOT NULL,
  `id_bidang_urusan` int(11) NOT NULL,
  `id_program` int(11) NOT NULL,
  `id_rpjmd` int(11) NOT NULL,
  `indikator` text NOT NULL,
  `kebijakan_teks` text NOT NULL,
  `kode_bidang_urusan` varchar(50) NOT NULL,
  `kode_program` varchar(50) NOT NULL,
  `kode_skpd` varchar(50),
  `misi_teks` text NOT NULL,
  `nama_bidang_urusan` varchar(100) NOT NULL,
  `nama_program` text NOT NULL,
  `nama_skpd` text NOT NULL,
  `pagu_1` varchar(50) NOT NULL,
  `pagu_2` varchar(50) NOT NULL,
  `pagu_3` varchar(50) NOT NULL,
  `pagu_4` varchar(50) NOT NULL,
  `pagu_5` varchar(50) NOT NULL,
  `sasaran_teks` text NOT NULL,
  `satuan` varchar(50) NOT NULL,
  `strategi_teks` text NOT NULL,
  `target_1` varchar(50) NOT NULL,
  `target_2` varchar(50) NOT NULL,
  `target_3` varchar(50) NOT NULL,
  `target_4` varchar(50) NOT NULL,
  `target_5` varchar(50) NOT NULL,
  `tujuan_teks` text NOT NULL,
  `visi_teks` text NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL DEFAULT '2021'
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

-- Table structure for table `data_alamat` --

CREATE TABLE `data_alamat` (
  `id` int(11) NOT NULL,
  `id_alamat` int(11) NOT NULL,
  `nama` text NOT NULL,
  `id_prov` int(11) NOT NULL,
  `id_kab` int(11) NOT NULL,
  `id_kec` int(11) NOT NULL,
  `is_prov` tinyint(4) NOT NULL,
  `is_kab` tinyint(4) NOT NULL,
  `is_kec` tinyint(4) NOT NULL,
  `is_kel` tinyint(4) NOT NULL,
  `updated_at` datetime NOT NULL,
  `tahun` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Table structure for table `data_profile_penerima_bantuan`--

CREATE TABLE `data_profile_penerima_bantuan` (
  `id` int(11) NOT NULL,
  `id_profil` int(11) NOT NULL,
  `nama_teks` text NOT NULL,
  `alamat_teks` text NOT NULL,
  `jenis_penerima` text NOT NULL,
  `updated_at` datetime NOT NULL,
  `tahun` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1; 

-- Table structure for table `data_desa_kelurahan`--

CREATE TABLE `data_desa_kelurahan` (
  `id` int(11) NOT NULL,
  `camat_teks` varchar(50) DEFAULT NULL,
  `id_camat` int(11) DEFAULT NULL,
  `id_daerah` int(11) DEFAULT NULL,
  `id_level` varchar(50) DEFAULT NULL,
  `id_lurah` int(11) DEFAULT NULL,
  `id_profil` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `is_desa` tinyint(4) DEFAULT NULL,
  `is_locked` tinyint(4) DEFAULT NULL,
  `jabatan` varchar(50) DEFAULT NULL,
  `jenis` int(11) DEFAULT NULL,
  `kab_kota` varchar(50) DEFAULT NULL,
  `kode_lurah` varchar(50) DEFAULT NULL,
  `login_name` varchar(50) DEFAULT NULL,
  `lurah_teks` varchar(50) DEFAULT NULL,
  `nama_daerah` varchar(50) DEFAULT NULL,
  `nama_user` varchar(50) DEFAULT NULL,
  `accasmas` tinyint(4) DEFAULT NULL,
  `accbankeu` tinyint(4) DEFAULT NULL,
  `accdisposisi` tinyint(4) DEFAULT NULL,
  `accgiat` tinyint(4) DEFAULT NULL,
  `acchibah` tinyint(4) DEFAULT NULL,
  `accinput` tinyint(4) DEFAULT NULL,
  `accjadwal` tinyint(4) DEFAULT NULL,
  `acckunci` tinyint(4) DEFAULT NULL,
  `accmaster` tinyint(4) DEFAULT NULL,
  `accspv` tinyint(4) DEFAULT NULL,
  `accunit` tinyint(4) DEFAULT NULL,
  `accusulan` tinyint(4) DEFAULT NULL,
  `alamatteks` text,
  `camatteks` varchar(50) DEFAULT NULL,
  `daerahpengusul` varchar(50) DEFAULT NULL,
  `dapil` varchar(50) DEFAULT NULL,
  `emailteks` varchar(50) DEFAULT NULL,
  `fraksi` varchar(50) DEFAULT NULL,
  `idcamat` int(11) DEFAULT NULL,
  `iddaerahpengusul` int(11) DEFAULT NULL,
  `idkabkota` int(11) DEFAULT NULL,
  `idlevel` int(11) DEFAULT NULL,
  `idlokasidesa` int(11) DEFAULT NULL,
  `idlurah` int(11) DEFAULT NULL,
  `idlurahpengusul` int(11) DEFAULT NULL,
  `idprofil` int(11) DEFAULT NULL,
  `iduser` int(11) DEFAULT NULL,
  `loginname` varchar(50) DEFAULT NULL,
  `lokasidesateks` varchar(50) DEFAULT NULL,
  `lurahteks` varchar(50) DEFAULT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `namapengusul` varchar(50) DEFAULT NULL,
  `nik` varchar(50) DEFAULT NULL,
  `nip` varchar(50) DEFAULT NULL,
  `notelp` varchar(50) DEFAULT NULL,
  `npwp` varchar(50) DEFAULT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Table structure for table `data_dewan`--

CREATE TABLE `data_dewan` (
  `id` int(11) NOT NULL,
  `jabatan` varchar(50) DEFAULT NULL,
  `accasmas` tinyint(4) DEFAULT NULL,
  `accbankeu` tinyint(4) DEFAULT NULL,
  `accdisposisi` tinyint(4) DEFAULT NULL,
  `accgiat` tinyint(4) DEFAULT NULL,
  `acchibah` tinyint(4) DEFAULT NULL,
  `accinput` tinyint(4) DEFAULT NULL,
  `accjadwal` tinyint(4) DEFAULT NULL,
  `acckunci` tinyint(4) DEFAULT NULL,
  `accmaster` tinyint(4) DEFAULT NULL,
  `accspv` tinyint(4) DEFAULT NULL,
  `accunit` tinyint(4) DEFAULT NULL,
  `accusulan` tinyint(4) DEFAULT NULL,
  `alamatteks` text,
  `camatteks` varchar(50) DEFAULT NULL,
  `daerahpengusul` varchar(50) DEFAULT NULL,
  `dapil` varchar(50) DEFAULT NULL,
  `emailteks` varchar(50) DEFAULT NULL,
  `fraksi` varchar(50) DEFAULT NULL,
  `idcamat` int(11) DEFAULT NULL,
  `iddaerahpengusul` int(11) DEFAULT NULL,
  `idkabkota` int(11) DEFAULT NULL,
  `idlevel` int(11) DEFAULT NULL,
  `idlokasidesa` int(11) DEFAULT NULL,
  `idlurah` int(11) DEFAULT NULL,
  `idlurahpengusul` int(11) DEFAULT NULL,
  `idprofil` int(11) DEFAULT NULL,
  `iduser` int(11) DEFAULT NULL,
  `loginname` varchar(50) DEFAULT NULL,
  `lokasidesateks` varchar(50) DEFAULT NULL,
  `lurahteks` varchar(50) DEFAULT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `namapengusul` varchar(50) DEFAULT NULL,
  `nik` varchar(50) DEFAULT NULL,
  `nip` varchar(50) DEFAULT NULL,
  `notelp` varchar(50) DEFAULT NULL,
  `npwp` varchar(50) DEFAULT NULL,
  `id_sub_skpd` int(11) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1',
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `data_tag_sub_keg`
--

CREATE TABLE `data_tag_sub_keg` (
  `id` int(11) NOT NULL,
  `idlabelgiat` int(11) DEFAULT NULL,
  `namalabel` varchar(50) DEFAULT NULL,
  `idtagbl` int(11) DEFAULT NULL,
  `kode_sbl` varchar(50) DEFAULT NULL,
  `idsubbl` int(11) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1',
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `data_tag_sub_keg`
--

CREATE TABLE `data_pengaturan_sipd` (
  `id` int(11) NOT NULL,
  `daerah` text DEFAULT NULL,
  `kepala_daerah` text DEFAULT NULL,
  `wakil_kepala_daerah` text DEFAULT NULL,
  `awal_rpjmd` year(4) DEFAULT NULL,
  `akhir_rpjmd` year(4) DEFAULT NULL,
  `pelaksana_rkpd` tinyint(4) DEFAULT NULL,
  `pelaksana_kua` tinyint(4) DEFAULT NULL,
  `pelaksana_apbd` tinyint(4) DEFAULT NULL,
  `set_kpa_sekda` tinyint(4) DEFAULT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `data_sumber_dana`
--

CREATE TABLE `data_sumber_dana` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_user` int(11) NOT NULL,
  `id_daerah` int(11) NOT NULL,
  `id_dana` int(11) NOT NULL,
  `id_unik` text NOT NULL,
  `is_locked` int(11) NOT NULL,
  `kode_dana` varchar(50) NOT NULL,
  `nama_dana` text NOT NULL,
  `set_input` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `tahun` year(4) NOT NULL DEFAULT '2021',
  `updated_at` datetime DEFAULT NULL,
  `updated_user` int(11) NOT NULL DEFAULT '0',
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `data_user_penatausahaan`
--

CREATE TABLE `data_user_penatausahaan` (
  `id` int(11) NOT NULL,
  `idSkpd` int(11) DEFAULT NULL,
  `namaSkpd` text DEFAULT NULL,
  `kodeSkpd` int(50) DEFAULT NULL,
  `idDaerah` int(11) DEFAULT NULL,
  `userName` text DEFAULT NULL,
  `nip` varchar(50) DEFAULT NULL,
  `fullName` text DEFAULT NULL,
  `nomorHp` text DEFAULT NULL,
  `rank` varchar(50) DEFAULT NULL,
  `npwp` varchar(50) DEFAULT NULL,
  `idJabatan` int(11) DEFAULT NULL,
  `namaJabatan` varchar(50) DEFAULT NULL,
  `idRole` int(11) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `kpa` varchar(50) DEFAULT NULL,
  `bank` text DEFAULT NULL,
  `group` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `konfirmasiPassword` varchar(50) DEFAULT NULL,
  `kodeBank` text DEFAULT NULL,
  `nama_rekening` text DEFAULT NULL,
  `nomorRekening` text DEFAULT NULL,
  `pangkatGolongan` text DEFAULT NULL,
  `tahunPegawai` year(4) DEFAULT NULL,
  `kodeDaerah` int(11) DEFAULT NULL,
  `is_from_sipd` int(11) DEFAULT NULL,
  `is_from_generate` int(11) DEFAULT NULL,
  `is_from_external` int(11) DEFAULT NULL,
  `idSubUnit` int(11) DEFAULT NULL,
  `idUser` int(11) DEFAULT NULL,
  `idPegawai` int(11) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `tahun` year(4) NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `data_renstra`
--

CREATE TABLE `data_renstra` (
  `id` int(11) NOT NULL,
  `id_bidang_urusan` int(11) DEFAULT NULL,
  `id_giat` int(11) DEFAULT NULL,
  `id_program` int(11) DEFAULT NULL,
  `id_renstra` int(11) DEFAULT NULL,
  `id_rpjmd` int(11) DEFAULT NULL,
  `id_sub_giat` int(11) DEFAULT NULL,
  `id_unit` int(11) DEFAULT NULL,
  `indikator` text,
  `indikator_sub` text,
  `is_locked` tinyint(4) DEFAULT NULL,
  `kebijakan_teks` text,
  `kode_bidang_urusan` varchar(50) DEFAULT NULL,
  `kode_giat` varchar(50) DEFAULT NULL,
  `kode_program` varchar(50) DEFAULT NULL,
  `kode_skpd` varchar(50) DEFAULT NULL,
  `kode_sub_giat` varchar(50) DEFAULT NULL,
  `misi_teks` text,
  `nama_bidang_urusan` text,
  `nama_giat` text,
  `nama_program` text,
  `nama_skpd` text,
  `nama_sub_giat` text,
  `outcome` text,
  `pagu_1` double DEFAULT NULL,
  `pagu_2` double DEFAULT NULL,
  `pagu_3` double DEFAULT NULL,
  `pagu_4` double DEFAULT NULL,
  `pagu_5` double DEFAULT NULL,
  `pagu_sub_1` double DEFAULT NULL,
  `pagu_sub_2` double DEFAULT NULL,
  `pagu_sub_3` double DEFAULT NULL,
  `pagu_sub_4` double DEFAULT NULL,
  `pagu_sub_5` double DEFAULT NULL,
  `sasaran_teks` text,
  `satuan` varchar(50) DEFAULT NULL,
  `satuan_sub` varchar(50) DEFAULT NULL,
  `strategi_teks` text,
  `target_1` text,
  `target_2` text,
  `target_3` text,
  `target_4` text,
  `target_5` text,
  `target_sub_1` text,
  `target_sub_2` text,
  `target_sub_3` text,
  `target_sub_4` text,
  `target_sub_5` text,
  `tujuan_teks` text,
  `visi_teks` text,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `data_lokasi_sub_keg`
--

CREATE TABLE `data_lokasi_sub_keg` (
  `id` int(11) NOT NULL,
  `camatteks` text,
  `daerahteks` text,
  `idcamat` int(11) DEFAULT NULL,
  `iddetillokasi` double DEFAULT NULL,
  `idkabkota` int(11) DEFAULT NULL,
  `idlurah` int(11) DEFAULT NULL,
  `lurahteks` text,
  `kode_sbl` varchar(50) DEFAULT NULL,
  `idsubbl` int(11) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `data_anggaran_kas`
--

CREATE TABLE `data_anggaran_kas` (
  `id` int(11) NOT NULL,
  `bulan_1` double DEFAULT NULL,
  `bulan_2` double DEFAULT NULL,
  `bulan_3` double DEFAULT NULL,
  `bulan_4` double DEFAULT NULL,
  `bulan_5` double DEFAULT NULL,
  `bulan_6` double DEFAULT NULL,
  `bulan_7` double DEFAULT NULL,
  `bulan_8` double DEFAULT NULL,
  `bulan_9` double DEFAULT NULL,
  `bulan_10` double DEFAULT NULL,
  `bulan_11` double DEFAULT NULL,
  `bulan_12` double DEFAULT NULL,
  `id_akun` int(11) DEFAULT NULL,
  `id_bidang_urusan` int(11) DEFAULT NULL,
  `id_daerah` int(11) DEFAULT NULL,
  `id_giat` int(11) DEFAULT NULL,
  `id_program` int(11) DEFAULT NULL,
  `id_skpd` int(11) DEFAULT NULL,
  `id_sub_giat` int(11) DEFAULT NULL,
  `id_sub_skpd` int(11) DEFAULT NULL,
  `id_unit` int(11) DEFAULT NULL,
  `kode_akun` varchar(50) DEFAULT NULL,
  `nama_akun` text,
  `selisih` double DEFAULT NULL,
  `tahun` year(4) DEFAULT NULL,
  `total_akb` double DEFAULT NULL,
  `total_rincian` double DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `kode_sbl` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `tahun_anggaran` year(4) NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `data_pembiayaan`
--

CREATE TABLE `data_pembiayaan` (
  `id` int(11) NOT NULL,
  `created_user` int(11) DEFAULT NULL,
  `createddate` varchar(50) DEFAULT NULL,
  `createdtime` varchar(50) DEFAULT NULL,
  `id_pembiayaan` int(11) DEFAULT NULL,
  `keterangan` varchar(50) DEFAULT NULL,
  `kode_akun` varchar(50) DEFAULT NULL,
  `nama_akun` text,
  `nilaimurni` double DEFAULT NULL,
  `program_koordinator` int(11) DEFAULT NULL,
  `rekening` text,
  `skpd_koordinator` int(11) DEFAULT NULL,
  `total` double DEFAULT NULL,
  `updated_user` int(11) DEFAULT NULL,
  `updateddate` varchar(50) DEFAULT NULL,
  `updatedtime` varchar(50) DEFAULT NULL,
  `uraian` text,
  `urusan_koordinator` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `user1`text DEFAULT NULL,
  `user2`text DEFAULT NULL,
  `id_skpd` int(11) DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `data_pendapatan`
--

CREATE TABLE `data_pendapatan` (
  `id` int(11) NOT NULL,
  `created_user` int(11) DEFAULT NULL,
  `createddate` varchar(50) DEFAULT NULL,
  `createdtime` varchar(50) DEFAULT NULL,
  `id_pendapatan` int(11) DEFAULT NULL,
  `keterangan` text,
  `kode_akun` varchar(50) DEFAULT NULL,
  `nama_akun` text,
  `nilaimurni` double DEFAULT NULL,
  `program_koordinator` int(11) DEFAULT NULL,
  `rekening` text,
  `skpd_koordinator` int(11) DEFAULT NULL,
  `total` double DEFAULT NULL,
  `updated_user` int(11) DEFAULT NULL,
  `updateddate` varchar(50) DEFAULT NULL,
  `updatedtime` varchar(50) DEFAULT NULL,
  `uraian` text,
  `urusan_koordinator` int(11) DEFAULT NULL,
  `user1` text DEFAULT NULL,
  `user2` text DEFAULT NULL,
  `id_skpd` int(11) DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `data_asmas`
--

CREATE TABLE `data_asmas` (
  `id` int(11) NOT NULL,
  `alamat_teks` text DEFAULT NULL,
  `anggaran` double DEFAULT NULL,
  `batal_teks` text DEFAULT NULL,
  `bidang_urusan` text DEFAULT NULL,
  `created_date` varchar(50) DEFAULT NULL,
  `created_user` int(11) DEFAULT NULL,
  `file_foto` text DEFAULT NULL,
  `file_pengantar` text DEFAULT NULL,
  `file_proposal` text DEFAULT NULL,
  `file_rab` text DEFAULT NULL,
  `giat_teks` text DEFAULT NULL,
  `id_bidang_urusan` int(11) DEFAULT NULL,
  `id_daerah` int(11) DEFAULT NULL,
  `id_jenis_profil` int(11) DEFAULT NULL,
  `id_jenis_usul` int(11) DEFAULT NULL,
  `id_kab_kota` int(11) DEFAULT NULL,
  `id_kecamatan` int(11) DEFAULT NULL,
  `id_kelurahan` int(11) DEFAULT NULL,
  `id_pengusul` int(11) DEFAULT NULL,
  `id_profil` int(11) DEFAULT NULL,
  `id_unit` int(11) DEFAULT NULL,
  `id_usulan` int(11) DEFAULT NULL,
  `is_batal` int(11) DEFAULT NULL,
  `is_tolak` int(11) DEFAULT NULL,
  `jenis_belanja` varchar(50) DEFAULT NULL,
  `jenis_profil` text DEFAULT NULL,
  `jenis_usul_teks` text DEFAULT NULL,
  `kelompok` text DEFAULT NULL,
  `kode_skpd` text DEFAULT NULL,
  `koefisien` text DEFAULT NULL,
  `level_pengusul` int(11) DEFAULT NULL,
  `lokus_usulan` text DEFAULT NULL,
  `masalah` text DEFAULT NULL,
  `nama_daerah` text DEFAULT NULL,
  `nama_skpd` text DEFAULT NULL,
  `nama_user` text DEFAULT NULL,
  `nip` int(11) DEFAULT NULL,
  `pengusul` text DEFAULT NULL,
  `rekom_camat_anggaran` double DEFAULT NULL,
  `rekom_camat_koefisien` text DEFAULT NULL,
  `rekom_camat_rekomendasi` text DEFAULT NULL,
  `rekom_lurah_anggaran` double DEFAULT NULL,
  `rekom_lurah_koefisien` text DEFAULT NULL,
  `rekom_lurah_rekomendasi` text DEFAULT NULL,
  `rekom_mitra_anggaran` double DEFAULT NULL,
  `rekom_mitra_koefisien` text DEFAULT NULL,
  `rekom_mitra_rekomendasi` text DEFAULT NULL,
  `rekom_skpd_anggaran` double DEFAULT NULL,
  `rekom_skpd_koefisien` text DEFAULT NULL,
  `rekom_skpd_rekomendasi` text DEFAULT NULL,
  `rekom_tapd_anggaran` double DEFAULT NULL,
  `rekom_tapd_koefisien` text DEFAULT NULL,
  `rekom_tapd_rekomendasi` text DEFAULT NULL,
  `rev_skpd` text DEFAULT NULL,
  `satuan` text DEFAULT NULL,
  `status_usul` int(11) DEFAULT NULL,
  `status_usul_teks` text DEFAULT NULL,
  `tolak_teks` int(11) DEFAULT NULL,
  `tujuan_usul` text DEFAULT NULL,
  `detail_alamatteks` text DEFAULT NULL,
  `detail_anggaran` double DEFAULT NULL,
  `detail_bidangurusan` text DEFAULT NULL,
  `detail_camatteks` text DEFAULT NULL,
  `detail_filefoto` text DEFAULT NULL,
  `detail_filefoto2` text DEFAULT NULL,
  `detail_filefoto3` text DEFAULT NULL,
  `detail_filepengantar` text DEFAULT NULL,
  `detail_fileproposal` text DEFAULT NULL,
  `detail_filerab` text DEFAULT NULL,
  `detail_gagasan` text DEFAULT NULL,
  `detail_idcamat` int(11) DEFAULT NULL,
  `detail_idkabkota` int(11) DEFAULT NULL,
  `detail_idkamus` int(11) DEFAULT NULL,
  `detail_idlurah` int(11) DEFAULT NULL,
  `detail_idskpd` int(11) DEFAULT NULL,
  `detail_jenisbelanja` text DEFAULT NULL,
  `detail_kodeskpd` text DEFAULT NULL,
  `detail_langpeta` text DEFAULT NULL,
  `detail_latpeta` text DEFAULT NULL,
  `detail_lurahteks` text DEFAULT NULL,
  `detail_masalah` text DEFAULT NULL,
  `detail_namakabkota` text DEFAULT NULL,
  `detail_namaskpd` text DEFAULT NULL,
  `detail_rekomteks` text DEFAULT NULL,
  `detail_satuan` text DEFAULT NULL,
  `detail_setStatusUsul` text DEFAULT NULL,
  `detail_subgiat` int(11) DEFAULT NULL,
  `detail_tujuanusul` text DEFAULT NULL,
  `detail_usulanggaran` double DEFAULT NULL,
  `detail_usulvolume` int(11) DEFAULT NULL,
  `detail_volume` int(11) DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `data_pokir`
--

CREATE TABLE `data_pokir` (
  `id` int(11) NOT NULL,
  `alamat_teks` text DEFAULT NULL,
  `anggaran` double DEFAULT NULL,
  `batal_teks` text DEFAULT NULL,
  `bidang_urusan` text DEFAULT NULL,
  `created_date` varchar(50) DEFAULT NULL,
  `created_user` int(11) DEFAULT NULL,
  `file_foto` text DEFAULT NULL,
  `file_pengantar` text DEFAULT NULL,
  `file_proposal` text DEFAULT NULL,
  `file_rab` text DEFAULT NULL,
  `fraksi_dewan` text DEFAULT NULL,
  `giat_teks` text DEFAULT NULL,
  `id_bidang_urusan` int(11) DEFAULT NULL,
  `id_jenis_usul` int(11) DEFAULT NULL,
  `id_kab_kota` int(11) DEFAULT NULL,
  `id_kecamatan` int(11) DEFAULT NULL,
  `id_kelurahan` int(11) DEFAULT NULL,
  `id_pengusul` int(11) DEFAULT NULL,
  `id_reses` int(11) DEFAULT NULL,
  `id_unit` int(11) DEFAULT NULL,
  `id_usulan` int(11) DEFAULT NULL,
  `is_batal` int(11) DEFAULT NULL,
  `is_tolak` int(11) DEFAULT NULL,
  `jenis_belanja` varchar(50) DEFAULT NULL,
  `jenis_usul_teks` text DEFAULT NULL,
  `kelompok` text DEFAULT NULL,
  `kode_skpd` text DEFAULT NULL,
  `koefisien` text DEFAULT NULL,
  `lokus_usulan` text DEFAULT NULL,
  `masalah` text DEFAULT NULL,
  `nama_daerah` text DEFAULT NULL,
  `nama_skpd` text DEFAULT NULL,
  `nama_user` text DEFAULT NULL,
  `pengusul` text DEFAULT NULL,
  `rekom_mitra_anggaran` double DEFAULT NULL,
  `rekom_mitra_koefisien` text DEFAULT NULL,
  `rekom_mitra_rekomendasi` text DEFAULT NULL,
  `rekom_setwan_anggaran` double DEFAULT NULL,
  `rekom_setwan_koefisien` text DEFAULT NULL,
  `rekom_setwan_rekomendasi` text DEFAULT NULL,
  `rekom_skpd_anggaran` double DEFAULT NULL,
  `rekom_skpd_koefisien` text DEFAULT NULL,
  `rekom_skpd_rekomendasi` text DEFAULT NULL,
  `rekom_tapd_anggaran` double DEFAULT NULL,
  `rekom_tapd_koefisien` text DEFAULT NULL,
  `rekom_tapd_rekomendasi` text DEFAULT NULL,
  `rev_skpd` text DEFAULT NULL,
  `satuan` text DEFAULT NULL,
  `status_usul` int(11) DEFAULT NULL,
  `status_usul_teks` text DEFAULT NULL,
  `tolak_teks` int(11) DEFAULT NULL,
  `tujuan_usul` text DEFAULT NULL,
  `detail_alamatteks` text DEFAULT NULL,
  `detail_anggaran` double DEFAULT NULL,
  `detail_bidangurusan` text DEFAULT NULL,
  `detail_camatteks` text DEFAULT NULL,
  `detail_filefoto` text DEFAULT NULL,
  `detail_filefoto2` text DEFAULT NULL,
  `detail_filefoto3` text DEFAULT NULL,
  `detail_filepengantar` text DEFAULT NULL,
  `detail_fileproposal` text DEFAULT NULL,
  `detail_filerab` text DEFAULT NULL,
  `detail_gagasan` text DEFAULT NULL,
  `detail_idcamat` int(11) DEFAULT NULL,
  `detail_idkabkota` int(11) DEFAULT NULL,
  `detail_idkamus` int(11) DEFAULT NULL,
  `detail_idlurah` int(11) DEFAULT NULL,
  `detail_idskpd` int(11) DEFAULT NULL,
  `detail_jenisbelanja` text DEFAULT NULL,
  `detail_kodeskpd` text DEFAULT NULL,
  `detail_langpeta` text DEFAULT NULL,
  `detail_latpeta` text DEFAULT NULL,
  `detail_lurahteks` text DEFAULT NULL,
  `detail_masalah` text DEFAULT NULL,
  `detail_namakabkota` text DEFAULT NULL,
  `detail_namaskpd` text DEFAULT NULL,
  `detail_rekomteks` text DEFAULT NULL,
  `detail_satuan` text DEFAULT NULL,
  `detail_setStatusUsul` text DEFAULT NULL,
  `detail_subgiat` int(11) DEFAULT NULL,
  `detail_usulanggaran` double DEFAULT NULL,
  `detail_usulvolume` int(11) DEFAULT NULL,
  `detail_volume` int(11) DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- view untuk data bantuan hibah uang --

CREATE VIEW vw_batuan_hibah_uang AS SELECT
a.kode_akun,
a.nama_akun,
r.subs_bl_teks,
r.ket_bl_teks,
r.lokus_akun_teks,
r.nama_komponen,
r.koefisien,
r.satuan,
r.harga_satuan,
r.rincian,
r.kode_sbl,
r.update_at,
r.tahun_anggaran,
al.nama AS deskel,
(SELECT nama from data_alamat where id_alamat=al.id_kec) AS kecamatan,
(SELECT nama from data_alamat where id_alamat=al.id_kab) AS kabupaten,
(SELECT nama from data_alamat where id_alamat=al.id_prov) AS provinsi,
p.nama_teks AS nama_penerima,
p.alamat_teks AS alamat_penerima,
p.jenis_penerima
FROM data_akun a
INNER JOIN data_rka r ON a.kode_akun=r.kode_akun
LEFT JOIN data_alamat al ON r.id_lurah_penerima=al.id_alamat
LEFT JOIN data_profile_penerima_bantuan p ON r.id_penerima=p.id_profil
WHERE a.is_hibah_uang=1;


--
-- Indexes for dumped tables
--

--
-- Indexes for table `data_pendapatan`
--
ALTER TABLE `data_pendapatan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_asmas`
--
ALTER TABLE `data_asmas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_pokir`
--
ALTER TABLE `data_pokir`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_pembiayaan`
--
ALTER TABLE `data_pembiayaan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_anggaran_kas`
--
ALTER TABLE `data_anggaran_kas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_lokasi_sub_keg`
--
ALTER TABLE `data_lokasi_sub_keg`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_renstra`
--
ALTER TABLE `data_renstra`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_keg_indikator_hasil`
--
ALTER TABLE `data_keg_indikator_hasil`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_user_penatausahaan`
--
ALTER TABLE `data_user_penatausahaan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_capaian_prog_sub_keg`
--
ALTER TABLE `data_capaian_prog_sub_keg`
  ADD PRIMARY KEY (`id`);
--
-- Indexes for table `data_output_giat_sub_keg`
--
ALTER TABLE `data_output_giat_sub_keg`
  ADD PRIMARY KEY (`id`);
--
-- Indexes for table `data_dana_sub_keg`
--
ALTER TABLE `data_dana_sub_keg`
  ADD PRIMARY KEY (`id`);
--
-- Indexes for table `data_sumber_dana`
--
ALTER TABLE `data_sumber_dana`
  ADD PRIMARY KEY (`id`);
--
-- Indexes for table `data_tag_sub_keg`
--
ALTER TABLE `data_tag_sub_keg`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_pengaturan_sipd`
--
ALTER TABLE `data_pengaturan_sipd`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_dewan`
--
ALTER TABLE `data_dewan`
  ADD PRIMARY KEY (`id`);
  
--
-- Indexes for table `data_desa_kelurahan`
--
ALTER TABLE `data_desa_kelurahan`
  ADD PRIMARY KEY (`id`);
--
-- Indexes for table `data_alamat`
--
ALTER TABLE `data_alamat`
  ADD PRIMARY KEY (`id`);
--
-- Indexes for table `data_profile_penerima_bantuan`
--
ALTER TABLE `data_profile_penerima_bantuan`
  ADD PRIMARY KEY (`id`);
--
-- Indexes for table `data_prog_keg`
--
ALTER TABLE `data_rpjmd`
ADD PRIMARY KEY (`id`);
--
-- Indexes for table `data_prog_keg`
--
ALTER TABLE `data_prog_keg`
ADD PRIMARY KEY (`id`);
--
-- Indexes for table `data_unit`
--
ALTER TABLE `data_unit`
ADD PRIMARY KEY (`id`);
--
-- Indexes for table `data_akun`
--
ALTER TABLE `data_akun`
ADD PRIMARY KEY (`id`);
--
-- Indexes for table `data_rka`
--
ALTER TABLE `data_rka`
ADD PRIMARY KEY (`id`);
--
-- Indexes for table `data_ssh`
--
ALTER TABLE `data_ssh`
ADD PRIMARY KEY (`id`),
  ADD KEY `id_standar_harga` (`id_standar_harga`);
--
-- Indexes for table `data_ssh_rek_belanja`
--
ALTER TABLE `data_ssh_rek_belanja`
ADD PRIMARY KEY (`id`),
  ADD KEY `id_standar_harga` (`id_standar_harga`);
--
-- Indexes for table `data_sub_keg_indikator`
--
ALTER TABLE `data_sub_keg_indikator`
ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `data_desa_kelurahan`
--
ALTER TABLE `data_desa_kelurahan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_unit`
--
ALTER TABLE `data_unit`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_akun`
--
ALTER TABLE `data_akun`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_rka`
--
ALTER TABLE `data_rka`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_ssh`
--
ALTER TABLE `data_ssh`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_ssh_rek_belanja`
--
ALTER TABLE `data_ssh_rek_belanja`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_sub_keg_indikator`
--
ALTER TABLE `data_sub_keg_indikator`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `data_ssh_rek_belanja`
--
ALTER TABLE `data_ssh_rek_belanja`
ADD CONSTRAINT `data_ssh_rek_belanja_ibfk_1` FOREIGN KEY (`id_standar_harga`) REFERENCES `data_ssh` (`id_standar_harga`);
--
-- Indexes for table `data_unit_pagu`
--
ALTER TABLE `data_unit_pagu`
ADD PRIMARY KEY (`id`);
--
-- AUTO_INCREMENT for table `data_unit_pagu`
--
ALTER TABLE `data_unit_pagu`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_prog_keg`
--
ALTER TABLE `data_prog_keg`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_prog_keg`
--
ALTER TABLE `data_rpjmd`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_profile_penerima_bantuan`
--
ALTER TABLE `data_profile_penerima_bantuan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_alamat`
--
ALTER TABLE `data_alamat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_dewan`
--
ALTER TABLE `data_dewan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_tag_sub_keg`
--
ALTER TABLE `data_tag_sub_keg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_pengaturan_sipd`
--
ALTER TABLE `data_pengaturan_sipd`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_sumber_dana`
--
ALTER TABLE `data_sumber_dana`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_dana_sub_keg`
--
ALTER TABLE `data_dana_sub_keg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_output_giat_sub_keg`
--
ALTER TABLE `data_output_giat_sub_keg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_capaian_prog_sub_keg`
--
ALTER TABLE `data_capaian_prog_sub_keg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data_user_penatausahaan`
--
ALTER TABLE `data_user_penatausahaan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data_keg_indikator_hasil`
--
ALTER TABLE `data_keg_indikator_hasil`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data_renstra`
--
ALTER TABLE `data_renstra`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data_lokasi_sub_keg`
--
ALTER TABLE `data_lokasi_sub_keg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data_anggaran_kas`
--
ALTER TABLE `data_anggaran_kas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data_pembiayaan`
--
ALTER TABLE `data_pembiayaan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data_pendapatan`
--
ALTER TABLE `data_pendapatan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data_asmas`
--
ALTER TABLE `data_asmas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data_pokir`
--
ALTER TABLE `data_pokir`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_user_tapd_sekda` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_user` int(11) DEFAULT NULL,
  `id_daerah` int(11) DEFAULT NULL,
  `id_skpd` int(11) DEFAULT NULL,
  `jabatan` text DEFAULT NULL,
  `nama` text NOT NULL,
  `nip` double(20,0) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `tahun` year(4) NOT NULL,
  `updated_at` datetime NOT NULL,
  `type` varchar(20) NOT NULL,
  `tahun_anggaran` year(4) NOT NULL,
  `singkron_at` datetime NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `data_user_tapd_sekda`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `data_user_tapd_sekda`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_rfk` (
  `id` int(11) NOT NULL,
  `bulan` tinyint(2) NOT NULL,
  `kode_sbl` text NOT NULL,
  `rak` double(20,0) DEFAULT NULL,
  `realisasi_anggaran` double(20,0) DEFAULT NULL,
  `realisasi_fisik` tinyint(3) DEFAULT NULL,
  `permasalahan` text DEFAULT NULL,
  `catatan_verifikator` text DEFAULT NULL,
  `user_edit` text DEFAULT NULL,
  `user_verifikator` text DEFAULT NULL,
  `update_verifikator_at` datetime DEFAULT NULL,
  `update_fisik_at` datetime DEFAULT NULL,
  `id_skpd` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `data_rfk`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `data_rfk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_rpjmd_program` (
  `id` int(11) NOT NULL,
  `id_misi` int(11) DEFAULT NULL,
  `id_misi_old` int(11) DEFAULT NULL,
  `id_program` int(11) DEFAULT NULL,
  `id_unik` text DEFAULT NULL,
  `id_unik_indikator` text DEFAULT NULL,
  `id_unit` int(11) DEFAULT NULL,
  `id_visi` int(11) DEFAULT NULL,
  `indikator` text DEFAULT NULL,
  `is_locked` tinyint(4) DEFAULT NULL,
  `is_locked_indikator` tinyint(4) DEFAULT NULL,
  `kode_sasaran` text DEFAULT NULL,
  `kode_skpd` text DEFAULT NULL,
  `kode_tujuan` text DEFAULT NULL,
  `misi_teks` text DEFAULT NULL,
  `nama_program` text DEFAULT NULL,
  `nama_skpd` text DEFAULT NULL,
  `pagu_1` double(20,0) DEFAULT NULL,
  `pagu_2` double(20,0) DEFAULT NULL,
  `pagu_3` double(20,0) DEFAULT NULL,
  `pagu_4` double(20,0) DEFAULT NULL,
  `pagu_5` double(20,0) DEFAULT NULL,
  `program_lock` tinyint(4) DEFAULT NULL,
  `sasaran_lock` tinyint(4) DEFAULT NULL,
  `sasaran_teks` text DEFAULT NULL,
  `satuan` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  `target_1` text DEFAULT NULL,
  `target_2` text DEFAULT NULL,
  `target_3` text DEFAULT NULL,
  `target_4` text DEFAULT NULL,
  `target_5` text DEFAULT NULL,
  `target_akhir` text DEFAULT NULL,
  `target_awal` text DEFAULT NULL,
  `tujuan_lock` tinyint(4) DEFAULT NULL,
  `tujuan_teks` text DEFAULT NULL,
  `urut_misi` int(11) DEFAULT NULL,
  `urut_sasaran` int(11) DEFAULT NULL,
  `urut_tujuan` int(11) DEFAULT NULL,
  `visi_teks` text DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `data_rpjmd_program`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `data_rpjmd_program`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_rpjmd_sasaran` (
  `id` int(11) NOT NULL,
  `id_misi` int(11) DEFAULT NULL,
  `id_misi_old` int(11) DEFAULT NULL,
  `id_sasaran` int(11) DEFAULT NULL,
  `id_unik` text DEFAULT NULL,
  `id_unik_indikator` text DEFAULT NULL,
  `id_visi` int(11) DEFAULT NULL,
  `indikator_teks` text DEFAULT NULL,
  `is_locked` tinyint(4) DEFAULT NULL,
  `is_locked_indikator` tinyint(4) DEFAULT NULL,
  `kode_tujuan` text DEFAULT NULL,
  `misi_teks` text DEFAULT NULL,
  `sasaran_teks` text DEFAULT NULL,
  `satuan` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  `target_1` text DEFAULT NULL,
  `target_2` text DEFAULT NULL,
  `target_3` text DEFAULT NULL,
  `target_4` text DEFAULT NULL,
  `target_5` text DEFAULT NULL,
  `target_akhir` text DEFAULT NULL,
  `target_awal` text DEFAULT NULL,
  `tujuan_lock` tinyint(4) DEFAULT NULL,
  `tujuan_teks` text DEFAULT NULL,
  `urut_misi` int(11) DEFAULT NULL,
  `urut_sasaran` int(11) DEFAULT NULL,
  `urut_tujuan` int(11) DEFAULT NULL,
  `visi_teks` text DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `data_rpjmd_sasaran`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `data_rpjmd_sasaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_rpjmd_tujuan` (
  `id` int(11) NOT NULL,
  `id_misi` int(11) DEFAULT NULL,
  `id_misi_old` int(11) DEFAULT NULL,
  `id_tujuan` int(11) DEFAULT NULL,
  `id_unik` text DEFAULT NULL,
  `id_unik_indikator` text DEFAULT NULL,
  `id_visi` int(11) DEFAULT NULL,
  `indikator_teks` text DEFAULT NULL,
  `is_locked` tinyint(4) DEFAULT NULL,
  `is_locked_indikator` tinyint(4) DEFAULT NULL,
  `misi_lock` tinyint(4) DEFAULT NULL,
  `misi_teks` text DEFAULT NULL,
  `satuan` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  `target_1` text DEFAULT NULL,
  `target_2` text DEFAULT NULL,
  `target_3` text DEFAULT NULL,
  `target_4` text DEFAULT NULL,
  `target_5` text DEFAULT NULL,
  `target_akhir` text DEFAULT NULL,
  `target_awal` text DEFAULT NULL,
  `tujuan_teks` text DEFAULT NULL,
  `urut_misi` int(11) DEFAULT NULL,
  `urut_tujuan` int(11) DEFAULT NULL,
  `visi_teks` text DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `data_rpjmd_tujuan`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `data_rpjmd_tujuan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_sub_keg_bl` (
  `id` int(11) NOT NULL,
  `id_sub_skpd` int(11) NOT NULL,
  `id_lokasi` int(11) DEFAULT NULL,
  `id_label_kokab` int(11) NOT NULL,
  `nama_dana` text,
  `no_sub_giat` varchar(20) NOT NULL,
  `kode_giat` varchar(50) NOT NULL,
  `id_program` int(11) NOT NULL,
  `nama_lokasi` text DEFAULT NULL,
  `waktu_akhir` int(11) NOT NULL,
  `pagu_n_lalu` double(20, 0) DEFAULT NULL,
  `id_urusan` int(11) NOT NULL,
  `id_unik_sub_bl` text NOT NULL,
  `id_sub_giat` int(11) NOT NULL,
  `label_prov` text,
  `kode_program` varchar(50) NOT NULL,
  `kode_sub_giat` varchar(50) NOT NULL,
  `no_program` varchar(20) NOT NULL,
  `kode_urusan` varchar(20) NOT NULL,
  `kode_bidang_urusan` varchar(20) NOT NULL,
  `nama_program` text NOT NULL,
  `target_4` text,
  `target_5` text,
  `id_bidang_urusan` int(11) DEFAULT NULL,
  `nama_bidang_urusan` text,
  `target_3` text,
  `no_giat` varchar(50) NOT NULL,
  `id_label_prov` int(11) NOT NULL,
  `waktu_awal` int(11) NOT NULL,
  `pagumurni` double(20, 0) DEFAULT NULL,
  `pagu` double(20, 0) NOT NULL,
  `pagu_simda` double(20, 0) DEFAULT NULL,
  `output_sub_giat` text,
  `sasaran` text,
  `indikator` text,
  `id_dana` int(11) DEFAULT NULL,
  `nama_sub_giat` text NOT NULL,
  `pagu_n_depan` double(20, 0) NOT NULL,
  `satuan` text,
  `id_rpjmd` int(11) NOT NULL,
  `id_giat` int(11) NOT NULL,
  `id_label_pusat` int(11) NOT NULL,
  `nama_giat` text NOT NULL,
  `kode_skpd` varchar(50) NOT NULL,
  `nama_skpd` text NOT NULL,
  `kode_sub_skpd` varchar(50) NOT NULL,
  `id_skpd` int(11) NOT NULL,
  `id_sub_bl` int(11) DEFAULT NULL,
  `nama_sub_skpd` text NOT NULL,
  `target_1` text,
  `nama_urusan` text NOT NULL,
  `target_2` text,
  `label_kokab` text,
  `label_pusat` text,
  `pagu_keg` double(20, 0) NOT NULL,
  `id_bl` int(11) DEFAULT NULL,
  `kode_bl` varchar(50) NOT NULL,
  `kode_sbl` varchar(50) NOT NULL,
  `active` tinyint(4) DEFAULT '1',
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL DEFAULT '2021'
) ENGINE = InnoDB DEFAULT CHARSET = latin1;
ALTER TABLE `data_sub_keg_bl`
ADD PRIMARY KEY (`id`);
ALTER TABLE `data_sub_keg_bl`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_mapping_sumberdana` (
  `id` int(11) NOT NULL,
  `id_rinci_sub_bl` int(11) NOT NULL,
  `id_sumber_dana` int(11) NOT NULL,
  `user` text DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `data_mapping_sumberdana`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `data_mapping_sumberdana`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_label_komponen` (
  `id` int(11) NOT NULL,
  `nama` text DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `id_skpd` int(11) DEFAULT NULL,
  `user` text DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `data_label_komponen`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `data_label_komponen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_mapping_label` (
  `id` int(11) NOT NULL,
  `id_rinci_sub_bl` int(11) NOT NULL,
  `id_label_komponen` int(11) NOT NULL,
  `user` text DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `data_mapping_label`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `data_mapping_label`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_renstra_tujuan` (
  `id` int(11) NOT NULL,
  `bidur_lock` int(11) DEFAULT NULL,
  `id_bidang_urusan` int(11) DEFAULT NULL,
  `id_unik` text DEFAULT NULL,
  `id_unik_indikator` text DEFAULT NULL,
  `id_unit` int(11) DEFAULT NULL,
  `indikator_teks` text DEFAULT NULL,
  `is_locked` tinyint(4) DEFAULT NULL,
  `is_locked_indikator` tinyint(4) DEFAULT NULL,
  `kode_bidang_urusan` text DEFAULT NULL,
  `kode_skpd` text DEFAULT NULL,
  `nama_bidang_urusan` text DEFAULT NULL,
  `nama_skpd` text DEFAULT NULL,
  `satuan` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  `target_1` text DEFAULT NULL,
  `target_2` text DEFAULT NULL,
  `target_3` text DEFAULT NULL,
  `target_4` text DEFAULT NULL,
  `target_5` text DEFAULT NULL,
  `target_akhir` text DEFAULT NULL,
  `target_awal` text DEFAULT NULL,
  `tujuan_teks` text DEFAULT NULL,
  `urut_tujuan` int(11) DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `data_renstra_tujuan`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `data_renstra_tujuan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_renstra_sasaran` (
  `id` int(11) NOT NULL,
  `bidur_lock` int(11) DEFAULT NULL,
  `id_bidang_urusan` int(11) DEFAULT NULL,
  `id_misi` int(11) DEFAULT NULL,
  `id_unik` int(11) DEFAULT NULL,
  `id_unik_indikator` text DEFAULT NULL,
  `id_unit` text DEFAULT NULL,
  `id_visi` int(11) DEFAULT NULL,
  `indikator_teks` text DEFAULT NULL,
  `is_locked` int(11) DEFAULT NULL,
  `is_locked_indikator` int(11) DEFAULT NULL,
  `kode_bidang_urusan` text DEFAULT NULL,
  `kode_skpd` text DEFAULT NULL,
  `kode_tujuan` text DEFAULT NULL,
  `nama_bidang_urusan` text DEFAULT NULL,
  `nama_skpd` text DEFAULT NULL,
  `sasaran_teks` text DEFAULT NULL,
  `satuan` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  `target_1` text DEFAULT NULL,
  `target_2` text DEFAULT NULL,
  `target_3` text DEFAULT NULL,
  `target_4` text DEFAULT NULL,
  `target_5` text DEFAULT NULL,
  `target_akhir` text DEFAULT NULL,
  `target_awal` text DEFAULT NULL,
  `tujuan_lock` tinyint(4) DEFAULT NULL,
  `tujuan_teks` text DEFAULT NULL,
  `urut_sasaran` tinyint(4) DEFAULT NULL,
  `urut_tujuan` tinyint(4) DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `data_renstra_sasaran`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `data_renstra_sasaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_renstra_program` (
  `id` int(11) NOT NULL,
  `bidur_lock` int(11) DEFAULT NULL,
  `id_bidang_urusan` int(11) DEFAULT NULL,
  `id_misi` int(11) DEFAULT NULL,
  `id_program` int(11) DEFAULT NULL,
  `id_unik` text DEFAULT NULL,
  `id_unik_indikator` text DEFAULT NULL,
  `id_unit` int(11) DEFAULT NULL,
  `id_visi` int(11) DEFAULT NULL,
  `indikator` text DEFAULT NULL,
  `is_locked` tinyint(4) DEFAULT NULL,
  `is_locked_indikator` tinyint(4) DEFAULT NULL,
  `kode_bidang_urusan` text DEFAULT NULL,
  `kode_program` text DEFAULT NULL,
  `kode_sasaran` text DEFAULT NULL,
  `kode_skpd` text DEFAULT NULL,
  `kode_tujuan` text DEFAULT NULL,
  `nama_bidang_urusan` text DEFAULT NULL,
  `nama_program` text DEFAULT NULL,
  `nama_skpd` text DEFAULT NULL,
  `pagu_1` int(11) DEFAULT NULL,
  `pagu_2` int(11) DEFAULT NULL,
  `pagu_3` int(11) DEFAULT NULL,
  `pagu_4` int(11) DEFAULT NULL,
  `pagu_5` int(11) DEFAULT NULL,
  `program_lock` tinyint(4) DEFAULT NULL,
  `sasaran_lock` tinyint(4) DEFAULT NULL,
  `sasaran_teks` text DEFAULT NULL,
  `satuan` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  `target_1` text DEFAULT NULL,
  `target_2` text DEFAULT NULL,
  `target_3` text DEFAULT NULL,
  `target_4` text DEFAULT NULL,
  `target_5` text DEFAULT NULL,
  `target_akhir` text DEFAULT NULL,
  `target_awal` text DEFAULT NULL,
  `tujuan_lock` int(11) DEFAULT NULL,
  `tujuan_teks` text DEFAULT NULL,
  `urut_sasaran` tinyint(4) DEFAULT NULL,
  `urut_tujuan` tinyint(4) DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `data_renstra_program`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `data_renstra_program`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_renstra_kegiatan` (
  `id` int(11) NOT NULL,
  `bidur_lock` tinyint(4) DEFAULT NULL,
  `giat_lock` tinyint(4) DEFAULT NULL,
  `id_bidang_urusan` int(11) DEFAULT NULL,
  `id_giat` int(11) DEFAULT NULL,
  `id_misi` int(11) DEFAULT NULL,
  `id_program` int(11) DEFAULT NULL,
  `id_unik` text DEFAULT NULL,
  `id_unik_indikator` text DEFAULT NULL,
  `id_unit` int(11) DEFAULT NULL,
  `id_visi` int(11) DEFAULT NULL,
  `indikator` text DEFAULT NULL,
  `is_locked` tinyint(4) DEFAULT NULL,
  `is_locked_indikator` tinyint(4) DEFAULT NULL,
  `kode_bidang_urusan` text DEFAULT NULL,
  `kode_giat` text DEFAULT NULL,
  `kode_program` text DEFAULT NULL,
  `kode_sasaran` text DEFAULT NULL,
  `kode_skpd` text DEFAULT NULL,
  `kode_tujuan` text DEFAULT NULL,
  `kode_unik_program` text DEFAULT NULL,
  `nama_bidang_urusan` text DEFAULT NULL,
  `nama_giat` text DEFAULT NULL,
  `nama_program` text DEFAULT NULL,
  `nama_skpd` text DEFAULT NULL,
  `pagu_1` text DEFAULT NULL,
  `pagu_2` text DEFAULT NULL,
  `pagu_3` text DEFAULT NULL,
  `pagu_4` text DEFAULT NULL,
  `pagu_5` text DEFAULT NULL,
  `program_lock` tinyint(4) DEFAULT NULL,
  `renstra_prog_lock` tinyint(4) DEFAULT NULL,
  `sasaran_lock` tinyint(4) DEFAULT NULL,
  `sasaran_teks` text DEFAULT NULL,
  `satuan` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  `target_1` text DEFAULT NULL,
  `target_2` text DEFAULT NULL,
  `target_3` text DEFAULT NULL,
  `target_4` text DEFAULT NULL,
  `target_5` text DEFAULT NULL,
  `target_akhir` text DEFAULT NULL,
  `target_awal` text DEFAULT NULL,
  `tujuan_lock` tinyint(4) DEFAULT NULL,
  `tujuan_teks` text DEFAULT NULL,
  `urut_sasaran` tinyint(4) DEFAULT NULL,
  `urut_tujuan` tinyint(4) DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `data_renstra_kegiatan`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `data_renstra_kegiatan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_realisasi_akun` (
  `id` int(11) NOT NULL,
  `realisasi` double(20, 0) DEFAULT NULL,
  `rak` double(20, 0) DEFAULT NULL,
  `kode_akun` text DEFAULT NULL,
  `kode_sbl` text DEFAULT NULL,
  `id_skpd` int(11) DEFAULT NULL,
  `user` text DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `data_realisasi_akun`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `data_realisasi_akun`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_realisasi_rincian` (
  `id` int(11) NOT NULL,
  `id_rinci_sub_bl` int(11) NOT NULL,
  `realisasi` double(20,0) DEFAULT NULL,
  `user` text DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `data_realisasi_rincian`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `data_realisasi_rincian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_realisasi_renja` (
  `id` int(11) NOT NULL,
  `id_indikator` int(11) DEFAULT NULL,
  `tipe_indikator` tinyint(4) DEFAULT NULL,
  `id_rumus_indikator` int(11) DEFAULT NULL,
  `kode_sbl` text DEFAULT NULL,
  `realisasi_bulan_1` int(11) DEFAULT NULL,
  `realisasi_bulan_2` int(11) DEFAULT NULL,
  `realisasi_bulan_3` int(11) DEFAULT NULL,
  `realisasi_bulan_4` int(11) DEFAULT NULL,
  `realisasi_bulan_5` int(11) DEFAULT NULL,
  `realisasi_bulan_6` int(11) DEFAULT NULL,
  `realisasi_bulan_7` int(11) DEFAULT NULL,
  `realisasi_bulan_8` int(11) DEFAULT NULL,
  `realisasi_bulan_9` int(11) DEFAULT NULL,
  `realisasi_bulan_10` int(11) DEFAULT NULL,
  `realisasi_bulan_11` int(11) DEFAULT NULL,
  `realisasi_bulan_12` int(11) DEFAULT NULL,
  `user` text DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `data_realisasi_renja`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `data_realisasi_renja`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

CREATE TABLE `data_rumus_indikator` (
  `id` int(11) NOT NULL,
  `rumus` text DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `user` text DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `update_at` datetime NOT NULL,
  `tahun_anggaran` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `data_rumus_indikator`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `data_rumus_indikator`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

INSERT INTO `data_rumus_indikator` (`id`, `rumus`, `keterangan`, `user`, `active`, `update_at`, `tahun_anggaran`) VALUES
(1, 'Indikator Tren Positif', 'Indikator Tren Positif adalah jenis indikator yang semakin tinggi realisasi maka dianggap semakin baik. Rumus capaian target = Realisasi/Target * 100. Rumus total target triwulan = akumulasi dari semua triwulan.', NULL, 1, '2021-08-23 00:00:00', 2021),
(2, 'Indikator Tren Negatif', 'Indikator Tren Negatif adalah jenis indikator yang semakin rendah realisasi maka dianggap semakin baik. Contoh : Angka Stunting. Rumus capaian target : Target/Realisasi * 100. Total triwulan = realisasi triwulan terakhir.', NULL, 1, '2021-08-23 00:00:00', 2021),
(3, 'Indikator Jenis Persentase', 'Indikator Jenis Persentase adalah jenis indikator berupa persentase. Pengisian realisasi target per bulan diisi sama atau lebih besar dari bulan sebelumnya. Rumus capaian target = Realisasi/Target * 100. Rumus total target triwulan = realisasi triwulan terakhir.', NULL, 1, '2021-08-23 00:00:00', 2021);
