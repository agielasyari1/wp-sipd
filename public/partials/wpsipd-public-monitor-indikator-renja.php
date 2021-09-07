<?php
global $wpdb;
$input = shortcode_atts( array(
	'id_skpd' => '',
	'tahun_anggaran' => '2022'
), $atts );

if(empty($input['id_skpd'])){
	die('<h1>SKPD tidak ditemukan!</h1>');
}

$tahun_sekarang = date('Y');
$batas_bulan_input = date('m');
if($input['tahun_anggaran'] < $tahun_sekarang){
	$batas_bulan_input = 12;
}
$api_key = get_option('_crb_api_key_extension' );

function button_edit_monev($class=false){
	$ret = ' <span style="display: none;" data-id="'.$class.'" class="edit-monev"><i class="dashicons dashicons-edit"></i></span>';
	return $ret;
}

$rumus_indikator_db = $wpdb->get_results("SELECT * from data_rumus_indikator where active=1 and tahun_anggaran=".$input['tahun_anggaran'], ARRAY_A);
$rumus_indikator_html = '';
$keterangan_indikator_html = '';
foreach ($rumus_indikator_db as $k => $v){
	$rumus_indikator_html .= '<option value="'.$v['id'].'">'.$v['rumus'].'</option>';
	$keterangan_indikator_html .= '<li data-id="'.$v['id'].'" style="display: none;">'.$v['keterangan'].'</li>';
}

$sql = $wpdb->prepare("
	select 
		* 
	from data_unit 
	where tahun_anggaran=%d
		and id_skpd =".$input['id_skpd']."
		and active=1
	order by id_skpd ASC
", $input['tahun_anggaran']);
$unit = $wpdb->get_results($sql, ARRAY_A);
$pengaturan = $wpdb->get_results($wpdb->prepare("
	select 
		* 
	from data_pengaturan_sipd 
	where tahun_anggaran=%d
", $input['tahun_anggaran']), ARRAY_A);

$awal_rpjmd = 2018;
$akhir_rpjmd = 2023;
if(!empty($pengaturan)){
	$awal_rpjmd = $pengaturan[0]['awal_rpjmd'];
	$akhir_rpjmd = $pengaturan[0]['akhir_rpjmd'];
}
$urut = $input['tahun_anggaran']-$awal_rpjmd;
$nama_pemda = $pengaturan[0]['daerah'];

$current_user = wp_get_current_user();

$bulan = date('m');
$subkeg = $wpdb->get_results($wpdb->prepare("
		select 
			k.*,
			k.id as id_sub_keg, 
			r.rak,
			r.realisasi_anggaran, 
			r.id as id_rfk, 
			r.realisasi_fisik, 
			r.permasalahan,
			r.catatan_verifikator
		from data_sub_keg_bl k
			left join data_rfk r on k.kode_sbl=r.kode_sbl
				AND k.tahun_anggaran=r.tahun_anggaran
				AND k.id_sub_skpd=r.id_skpd
				AND r.bulan=%d
		where k.tahun_anggaran=%d
			and k.active=1
			and k.id_sub_skpd=%d
		order by kode_sub_giat ASC
	", $bulan, $input['tahun_anggaran'], $unit[0]['id_skpd']), ARRAY_A);
$data_all = array(
	'total' => 0,
	'total_simda' => 0,
	'triwulan_1' => 0,
	'triwulan_2' => 0,
	'triwulan_3' => 0,
	'triwulan_4' => 0,
	'realisasi' => 0,
	'data' => array()
);
foreach ($subkeg as $kk => $sub) {
	$kd = explode('.', $sub['kode_sub_giat']);
	$kd_urusan90 = (int) $kd[0];
	$kd_bidang90 = (int) $kd[1];
	$kd_program90 = (int) $kd[2];
	$kd_kegiatan90 = ((int) $kd[3]).'.'.$kd[4];
	$kd_sub_kegiatan = (int) $kd[5];
	$nama_keg = explode(' ', $sub['nama_sub_giat']);
    unset($nama_keg[0]);
    $nama_keg = implode(' ', $nama_keg);
	$total_simda = $sub['pagu_simda'];
	$realisasi = $sub['realisasi_anggaran'];
	$total_pagu = $sub['pagu'];
	$kode = explode('.', $sub['kode_sbl']);

	$rfk_all = $wpdb->get_results($wpdb->prepare("
		select 
			realisasi_anggaran,
			bulan
		from data_rfk
		where tahun_anggaran=%d
			and id_skpd=%d
			and kode_sbl=%s
		order by id DESC
	", $input['tahun_anggaran'], $unit[0]['id_skpd'], $sub['kode_sbl']), ARRAY_A);
	$triwulan_1 = 0;
	$triwulan_2 = 0;
	$triwulan_3 = 0;
	$triwulan_4 = 0;
	foreach ($rfk_all as $k => $v) {
		if($v['bulan'] <= 3){
			$triwulan_1 = $v['realisasi_anggaran'];
		}else if($v['bulan'] <= 6){
			$triwulan_2 = $v['realisasi_anggaran']-$triwulan_1;
		}else if($v['bulan'] <= 9){
			$triwulan_3 = $v['realisasi_anggaran']-$triwulan_2;
		}else if($v['bulan'] <= 12){
			$triwulan_4 = $v['realisasi_anggaran']-$triwulan_3;
		}
	}

	$kode_sbl_s = explode('.', $sub['kode_sbl']);
	if(empty($data_all['data'][$sub['kode_urusan']])){
		$data_all['data'][$sub['kode_urusan']] = array(
			'nama'	=> $sub['nama_urusan'],
			'total' => 0,
			'triwulan_1' => 0,
			'triwulan_2' => 0,
			'triwulan_3' => 0,
			'triwulan_4' => 0,
			'total_simda' => 0,
			'realisasi' => 0,
			'data'	=> array()
		);
	}
	if(empty($data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']])){
		$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']] = array(
			'nama'	=> $sub['nama_bidang_urusan'],
			'total' => 0,
			'triwulan_1' => 0,
			'triwulan_2' => 0,
			'triwulan_3' => 0,
			'triwulan_4' => 0,
			'total_simda' => 0,
			'realisasi' => 0,
			'data'	=> array()
		);
	}
	if(empty($data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']])){
		$capaian_prog = $wpdb->get_results($wpdb->prepare("
			select 
				* 
			from data_capaian_prog_sub_keg 
			where tahun_anggaran=%d
				and active=1
				and kode_sbl=%s
				and capaianteks != ''
			order by id ASC
		", $input['tahun_anggaran'], $sub['kode_sbl']), ARRAY_A);

		$kode_sbl = $kode_sbl_s[0].'.'.$kode_sbl_s[1].'.'.$kode_sbl_s[2];
		$realisasi_renja = $wpdb->get_results($wpdb->prepare("
			select
				id_indikator,
				id_rumus_indikator,
				realisasi_bulan_1,
				realisasi_bulan_2,
				realisasi_bulan_3,
				realisasi_bulan_4,
				realisasi_bulan_5,
				realisasi_bulan_6,
				realisasi_bulan_7,
				realisasi_bulan_8,
				realisasi_bulan_9,
				realisasi_bulan_10,
				realisasi_bulan_11,
				realisasi_bulan_12
			from data_realisasi_renja
			where tahun_anggaran=%d
				and tipe_indikator=%d
				and kode_sbl=%s
		", $input['tahun_anggaran'], 3, $kode_sbl), ARRAY_A);
		$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']] = array(
			'nama'	=> $sub['nama_program'],
			'indikator' => $capaian_prog,
			'realisasi_indikator' => $realisasi_renja,
			'kode_sbl' => $sub['kode_sbl'],
			'total' => 0,
			'triwulan_1' => 0,
			'triwulan_2' => 0,
			'triwulan_3' => 0,
			'triwulan_4' => 0,
			'total_simda' => 0,
			'realisasi' => 0,
			'data'	=> array()
		);
	}
	if(empty($data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']])){
		$output_giat = $wpdb->get_results($wpdb->prepare("
			select 
				* 
			from data_output_giat_sub_keg 
			where tahun_anggaran=%d
				and active=1
				and kode_sbl=%s
			order by id ASC
		", $input['tahun_anggaran'], $sub['kode_sbl']), ARRAY_A);

		$kode_sbl = $kode_sbl_s[0].'.'.$kode_sbl_s[1].'.'.$kode_sbl_s[2].'.'.$kode_sbl_s[3];
		$realisasi_renja = $wpdb->get_results($wpdb->prepare("
			select
				id_indikator,
				id_rumus_indikator,
				realisasi_bulan_1,
				realisasi_bulan_2,
				realisasi_bulan_3,
				realisasi_bulan_4,
				realisasi_bulan_5,
				realisasi_bulan_6,
				realisasi_bulan_7,
				realisasi_bulan_8,
				realisasi_bulan_9,
				realisasi_bulan_10,
				realisasi_bulan_11,
				realisasi_bulan_12
			from data_realisasi_renja
			where tahun_anggaran=%d
				and tipe_indikator=%d
				and kode_sbl=%s
		", $input['tahun_anggaran'], 2, $kode_sbl), ARRAY_A);
		$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']] = array(
			'nama'	=> $sub['nama_giat'],
			'indikator' => $output_giat,
			'realisasi_indikator' => $realisasi_renja,
			'kode_sbl' => $sub['kode_sbl'],
			'total' => 0,
			'triwulan_1' => 0,
			'triwulan_2' => 0,
			'triwulan_3' => 0,
			'triwulan_4' => 0,
			'total_simda' => 0,
			'realisasi' => 0,
			'data'	=> array()
		);
	}
	if(empty($data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']]['data'][$sub['kode_sub_giat']])){
		$output_sub_giat = $wpdb->get_results($wpdb->prepare("
			select 
				* 
			from data_sub_keg_indikator
			where tahun_anggaran=%d
				and active=1
				and kode_sbl=%s
			order by id DESC
		", $input['tahun_anggaran'], $sub['kode_sbl']), ARRAY_A);

		$realisasi_renja = $wpdb->get_results($wpdb->prepare("
			select
				id_indikator,
				id_rumus_indikator,
				realisasi_bulan_1,
				realisasi_bulan_2,
				realisasi_bulan_3,
				realisasi_bulan_4,
				realisasi_bulan_5,
				realisasi_bulan_6,
				realisasi_bulan_7,
				realisasi_bulan_8,
				realisasi_bulan_9,
				realisasi_bulan_10,
				realisasi_bulan_11,
				realisasi_bulan_12
			from data_realisasi_renja
			where tahun_anggaran=%d
				and tipe_indikator=%d
				and kode_sbl=%s
		", $input['tahun_anggaran'], 1, $sub['kode_sbl']), ARRAY_A);
		$nama = explode(' ', $sub['nama_sub_giat']);
		unset($nama[0]);
		$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']]['data'][$sub['kode_sub_giat']] = array(
			'nama'	=> implode(' ', $nama),
			'indikator' => $output_sub_giat,
			'realisasi_indikator' => $realisasi_renja,
			'total' => 0,
			'triwulan_1' => 0,
			'triwulan_2' => 0,
			'triwulan_3' => 0,
			'triwulan_4' => 0,
			'total_simda' => 0,
			'realisasi' => 0,
			'data'	=> $sub
		);
	}
	$data_all['total'] += $total_pagu;
	$data_all['data'][$sub['kode_urusan']]['total'] += $total_pagu;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['total'] += $total_pagu;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['total'] += $total_pagu;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']]['total'] += $total_pagu;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']]['data'][$sub['kode_sub_giat']]['total'] += $total_pagu;

	$data_all['realisasi'] += $realisasi;
	$data_all['data'][$sub['kode_urusan']]['realisasi'] += $realisasi;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['realisasi'] += $realisasi;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['realisasi'] += $realisasi;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']]['realisasi'] += $realisasi;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']]['data'][$sub['kode_sub_giat']]['realisasi'] += $realisasi;

	$data_all['total_simda'] += $total_simda;
	$data_all['data'][$sub['kode_urusan']]['total_simda'] += $total_simda;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['total_simda'] += $total_simda;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['total_simda'] += $total_simda;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']]['total_simda'] += $total_simda;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']]['data'][$sub['kode_sub_giat']]['total_simda'] += $total_simda;

	$data_all['triwulan_1'] += $triwulan_1;
	$data_all['data'][$sub['kode_urusan']]['triwulan_1'] += $triwulan_1;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['triwulan_1'] += $triwulan_1;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['triwulan_1'] += $triwulan_1;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']]['triwulan_1'] += $triwulan_1;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']]['data'][$sub['kode_sub_giat']]['triwulan_1'] += $triwulan_1;

	$data_all['triwulan_2'] += $triwulan_2;
	$data_all['data'][$sub['kode_urusan']]['triwulan_2'] += $triwulan_2;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['triwulan_2'] += $triwulan_2;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['triwulan_2'] += $triwulan_2;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']]['triwulan_2'] += $triwulan_2;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']]['data'][$sub['kode_sub_giat']]['triwulan_2'] += $triwulan_2;

	$data_all['triwulan_3'] += $triwulan_3;
	$data_all['data'][$sub['kode_urusan']]['triwulan_3'] += $triwulan_3;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['triwulan_3'] += $triwulan_3;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['triwulan_3'] += $triwulan_3;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']]['triwulan_3'] += $triwulan_3;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']]['data'][$sub['kode_sub_giat']]['triwulan_3'] += $triwulan_3;

	$data_all['triwulan_4'] += $triwulan_4;
	$data_all['data'][$sub['kode_urusan']]['triwulan_4'] += $triwulan_4;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['triwulan_4'] += $triwulan_4;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['triwulan_4'] += $triwulan_4;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']]['triwulan_4'] += $triwulan_4;
	$data_all['data'][$sub['kode_urusan']]['data'][$sub['kode_bidang_urusan']]['data'][$sub['kode_program']]['data'][$sub['kode_giat']]['data'][$sub['kode_sub_giat']]['triwulan_4'] += $triwulan_4;
}

$body_monev = '';
$no_program = 0;
$no_kegiatan = 0;
$no_sub_kegiatan = 0;
foreach ($data_all['data'] as $kd_urusan => $urusan) {
	foreach ($urusan['data'] as $kd_bidang => $bidang) {
		foreach ($bidang['data'] as $kd_program_asli => $program) {
			$no_program++;
			$kd_program = explode('.', $kd_program_asli);
			$kd_program = $kd_program[count($kd_program)-1];
			$capaian = 0;
			if(!empty($program['total_simda'])){
				$capaian = $this->pembulatan(($program['realisasi']/$program['total_simda'])*100);
			}
			$capaian_prog = '';
			$target_capaian_prog = '';
			$satuan_capaian_prog = '';
			if(!empty($program['indikator'])){
				$capaian_prog = $program['indikator'][0]['capaianteks'].button_edit_monev($input['tahun_anggaran'].'-'.$input['id_skpd'].'-'.$kd_program_asli.'-'.$program['kode_sbl'].'-0');
				$target_capaian_prog = $program['indikator'][0]['targetcapaian'];
				$satuan_capaian_prog = $program['indikator'][0]['satuancapaian'];
			}
			$realisasi_indikator_tw1 = 0;
			$realisasi_indikator_tw2 = 0;
			$realisasi_indikator_tw3 = 0;
			$realisasi_indikator_tw4 = 0;
			$total_tw = 0;
			$capaian_realisasi_indikator = 0;
			$class_rumus_target = "positif";
			if(!empty($program['realisasi_indikator'])){
				$max = 0;
				$rumus_indikator = $program['realisasi_indikator'][0]['id_rumus_indikator'];
				for($i=1; $i<=12; $i++){
					$realisasi_bulan = $program['realisasi_indikator'][0]['realisasi_bulan_'.$i];
					if($max < $realisasi_bulan){
						$max = $realisasi_bulan;
					}
					$total_tw += $realisasi_bulan;
					if($i <= 3){
						if($rumus_indikator == 3 || $rumus_indikator == 2){
							if($i == 3){
								$realisasi_indikator_tw1 = $realisasi_bulan;
							}
						}else{
							$realisasi_indikator_tw1 += $realisasi_bulan;
						}
					}else if($i <= 6){
						if($rumus_indikator == 3 || $rumus_indikator == 2){
							if($i == 6){
								$realisasi_indikator_tw2 = $realisasi_bulan;
							}
						}else{
							$realisasi_indikator_tw2 += $realisasi_bulan;
						}
					}else if($i <= 9){
						if($rumus_indikator == 3 || $rumus_indikator == 2){
							if($i == 9){
								$realisasi_indikator_tw3 = $realisasi_bulan;
							}
						}else{
							$realisasi_indikator_tw3 += $realisasi_bulan;
						}
					}else if($i <= 12){
						if($rumus_indikator == 3 || $rumus_indikator == 2){
							if($i == 12){
								$realisasi_indikator_tw4 = $realisasi_bulan;
							}
						}else{
							$realisasi_indikator_tw4 += $realisasi_bulan;
						}
					}
				}
				if($rumus_indikator == 1){
					$class_rumus_target = "positif";
					if(!empty($target_capaian_prog)){
						$capaian_realisasi_indikator = $this->pembulatan(($total_tw/$target_capaian_prog)*100);
					}
				}else if($rumus_indikator == 2){
					$class_rumus_target = "negatif";
					$total_tw = $max;
					if(!empty($total_tw)){
						$capaian_realisasi_indikator = $this->pembulatan(($target_capaian_prog/$total_tw)*100);
					}
				}else if($rumus_indikator == 3){
					$class_rumus_target = "persentase";
					$total_tw = $max;
					if(!empty($target_capaian_prog)){
						$capaian_realisasi_indikator = $this->pembulatan(($total_tw/$target_capaian_prog)*100);
					}
				}
			}
			$realisasi_indikator_tw1 = '<span class="realisasi_indikator_tw1-0">'.$realisasi_indikator_tw1.'</span>';
			$realisasi_indikator_tw2 = '<span class="realisasi_indikator_tw2-0">'.$realisasi_indikator_tw2.'</span>';
			$realisasi_indikator_tw3 = '<span class="realisasi_indikator_tw3-0">'.$realisasi_indikator_tw3.'</span>';
			$realisasi_indikator_tw4 = '<span class="realisasi_indikator_tw4-0">'.$realisasi_indikator_tw4.'</span>';
			$total_tw = '<span class="total_tw-0 rumus_indikator '.$class_rumus_target.'">'.$total_tw.'</span>';
			$capaian_realisasi_indikator = '<span class="capaian_realisasi_indikator-0 rumus_indikator '.$class_rumus_target.'">'.$this->pembulatan($capaian_realisasi_indikator).'</span>';
			$body_monev .= '
				<tr class="program" data-kode="'.$kd_urusan.'.'.$kd_bidang.'.'.$kd_program.'">
		            <td class="kiri kanan bawah text_blok">'.$no_program.'</td>
		            <td class="text_tengah kanan bawah text_blok"></td>
		            <td class="text_tengah kanan bawah text_blok"></td>
		            <td class="kanan bawah text_blok">'.$kd_program_asli.'</td>
		            <td class="kanan bawah text_blok nama">'.$program['nama'].'</td>
		            <td class="kanan bawah text_blok indikator rumus_indikator '.$class_rumus_target.'">'.$capaian_prog.'</td>
		            <td class="text_tengah kanan bawah text_blok total_renstra"></td>
		            <td class="text_tengah kanan bawah text_blok total_renstra">'.$satuan_capaian_prog.'</td>
		            <td class="text_kanan kanan bawah text_blok total_renstra"></td>
		            <td class="text_tengah kanan bawah text_blok realisasi_renstra_tahun_lalu"></td>
		            <td class="text_tengah kanan bawah text_blok realisasi_renstra_tahun_lalu">'.$satuan_capaian_prog.'</td>
		            <td class="text_kanan kanan bawah text_blok realisasi_renstra_tahun_lalu"></td>
		            <td class="text_tengah kanan bawah text_blok total_renja target_indikator">'.$target_capaian_prog.'</td>
		            <td class="text_tengah kanan bawah text_blok total_renja satuan_indikator">'.$satuan_capaian_prog.'</td>
		            <td class="text_kanan kanan bawah text_blok total_renja pagu_renja" data-pagu="'.$program['total_simda'].'">'.number_format($program['total_simda'],0,",",".").'</td>
		            <td class="text_tengah kanan bawah text_blok triwulan_1">'.$realisasi_indikator_tw1.'</td>
		            <td class="text_tengah kanan bawah text_blok triwulan_1">'.$satuan_capaian_prog.'</td>
		            <td class="text_kanan kanan bawah text_blok triwulan_1">'.number_format($program['triwulan_1'],0,",",".").'</td>
		            <td class="text_tengah kanan bawah text_blok triwulan_2">'.$realisasi_indikator_tw2.'</td>
		            <td class="text_tengah kanan bawah text_blok triwulan_2">'.$satuan_capaian_prog.'</td>
		            <td class="text_kanan kanan bawah text_blok triwulan_2">'.number_format($program['triwulan_2'],0,",",".").'</td>
		            <td class="text_tengah kanan bawah text_blok triwulan_3">'.$realisasi_indikator_tw3.'</td>
		            <td class="text_tengah kanan bawah text_blok triwulan_3">'.$satuan_capaian_prog.'</td>
		            <td class="text_kanan kanan bawah text_blok triwulan_3">'.number_format($program['triwulan_3'],0,",",".").'</td>
		            <td class="text_tengah kanan bawah text_blok triwulan_4">'.$realisasi_indikator_tw4.'</td>
		            <td class="text_tengah kanan bawah text_blok triwulan_4">'.$satuan_capaian_prog.'</td>
		            <td class="text_kanan kanan bawah text_blok triwulan_4">'.number_format($program['triwulan_4'],0,",",".").'</td>
		            <td class="text_tengah kanan bawah text_blok realisasi_renja">'.$total_tw.'</td>
		            <td class="text_tengah kanan bawah text_blok realisasi_renja">'.$satuan_capaian_prog.'</td>
		            <td class="text_kanan kanan bawah text_blok realisasi_renja pagu_renja_realisasi" data-pagu="'.$program['realisasi'].'">'.number_format($program['realisasi'],0,",",".").'</td>
		            <td class="text_tengah kanan bawah text_blok capaian_renja">'.$capaian_realisasi_indikator.'</td>
		            <td class="text_kanan kanan bawah text_blok capaian_renja">'.$capaian.'</td>
		            <td class="text_tengah kanan bawah text_blok realisasi_renstra_tahun_berjalan"></td>
		            <td class="text_tengah kanan bawah text_blok realisasi_renstra_tahun_berjalan">'.$satuan_capaian_prog.'</td>
		            <td class="text_kanan kanan bawah text_blok realisasi_renstra_tahun_berjalan"></td>
		            <td class="text_tengah kanan bawah text_blok capaian_renstra_tahun_berjalan"></td>
		            <td class="text_kanan kanan bawah text_blok capaian_renstra_tahun_berjalan"></td>
	        		<td class="kanan bawah text_blok">'.$unit[0]['nama_skpd'].'</td>
		        </tr>
			';
			foreach ($program['data'] as $kd_giat1 => $giat) {
				$no_kegiatan++;
				$kd_giat = explode('.', $kd_giat1);
				$kd_giat = $kd_giat[count($kd_giat)-2].'.'.$kd_giat[count($kd_giat)-1];
				$nama_page = $input['tahun_anggaran'] . ' | ' . $unit[0]['kode_skpd'] . ' | ' . $kd_giat1 . ' | ' . $giat['nama'];
				$custom_post = get_page_by_title($nama_page, OBJECT, 'post');
				$link = $this->get_link_post($custom_post);
				$capaian = 0;
				if(!empty($giat['total_simda'])){
					$capaian = $this->pembulatan(($giat['realisasi']/$giat['total_simda'])*100);
				}
				$output_giat = '';
				$target_output_giat = '';
				$satuan_output_giat = '';
				if(!empty($giat['indikator'])){
					$output_giat = $giat['indikator'][0]['outputteks'].button_edit_monev($input['tahun_anggaran'].'-'.$input['id_skpd'].'-'.$kd_giat1.'-'.$giat['kode_sbl'].'-0');
					$target_output_giat = $giat['indikator'][0]['targetoutput'];
					$satuan_output_giat = $giat['indikator'][0]['satuanoutput'];
				}
				$realisasi_indikator_tw1 = 0;
				$realisasi_indikator_tw2 = 0;
				$realisasi_indikator_tw3 = 0;
				$realisasi_indikator_tw4 = 0;
				$total_tw = 0;
				$capaian_realisasi_indikator = 0;
				$class_rumus_target = "positif";
				if(!empty($giat['realisasi_indikator'])){
					$rumus_indikator = $giat['realisasi_indikator'][0]['id_rumus_indikator'];
					$max = 0;
					for($i=1; $i<=12; $i++){
						$realisasi_bulan = $giat['realisasi_indikator'][0]['realisasi_bulan_'.$i];
						if($max < $realisasi_bulan){
							$max = $realisasi_bulan;
						}
						$total_tw += $realisasi_bulan;
						if($i <= 3){
							if($rumus_indikator == 3 || $rumus_indikator == 2){
								if($i == 3){
									$realisasi_indikator_tw1 = $realisasi_bulan;
								}
							}else{
								$realisasi_indikator_tw1 += $realisasi_bulan;
							}
						}else if($i <= 6){
							if($rumus_indikator == 3 || $rumus_indikator == 2){
								if($i == 6){
									$realisasi_indikator_tw2 = $realisasi_bulan;
								}
							}else{
								$realisasi_indikator_tw2 += $realisasi_bulan;
							}
						}else if($i <= 9){
							if($rumus_indikator == 3 || $rumus_indikator == 2){
								if($i == 9){
									$realisasi_indikator_tw3 = $realisasi_bulan;
								}
							}else{
								$realisasi_indikator_tw3 += $realisasi_bulan;
							}
						}else if($i <= 12){
							if($rumus_indikator == 3 || $rumus_indikator == 2){
								if($i == 12){
									$realisasi_indikator_tw4 = $realisasi_bulan;
								}
							}else{
								$realisasi_indikator_tw4 += $realisasi_bulan;
							}
						}
					}
					if($rumus_indikator == 1){
						$class_rumus_target = "positif";
						if(!empty($target_output_giat)){
							$capaian_realisasi_indikator = $this->pembulatan(($total_tw/$target_output_giat)*100);
						}
					}else if($rumus_indikator == 2){
						$class_rumus_target = "negatif";
						$total_tw = $max;
						if(!empty($total_tw)){
							$capaian_realisasi_indikator = $this->pembulatan(($target_output_giat/$total_tw)*100);
						}
					}else if($rumus_indikator == 3){
						$class_rumus_target = "persentase";
						$total_tw = $max;
						if(!empty($target_output_giat)){
							$capaian_realisasi_indikator = $this->pembulatan(($total_tw/$target_output_giat)*100);
						}
					}
				}
				$realisasi_indikator_tw1 = '<span class="realisasi_indikator_tw1-0">'.$realisasi_indikator_tw1.'</span>';
				$realisasi_indikator_tw2 = '<span class="realisasi_indikator_tw2-0">'.$realisasi_indikator_tw2.'</span>';
				$realisasi_indikator_tw3 = '<span class="realisasi_indikator_tw3-0">'.$realisasi_indikator_tw3.'</span>';
				$realisasi_indikator_tw4 = '<span class="realisasi_indikator_tw4-0">'.$realisasi_indikator_tw4.'</span>';
				$total_tw = '<span class="total_tw-0 rumus_indikator '.$class_rumus_target.'">'.$total_tw.'</span>';
				$capaian_realisasi_indikator = '<span class="capaian_realisasi_indikator-0 rumus_indikator '.$class_rumus_target.'">'.$this->pembulatan($capaian_realisasi_indikator).'</span>';
				$body_monev .= '
					<tr class="kegiatan" data-kode="'.$kd_urusan.'.'.$kd_bidang.'.'.$kd_program.'.'.$kd_giat.'">
			            <td class="kiri kanan bawah text_blok">'.$no_program.'.'.$no_kegiatan.'</td>
			            <td class="text_tengah kanan bawah text_blok"></td>
			            <td class="text_tengah kanan bawah text_blok"></td>
			            <td class="kanan bawah text_blok">'.$kd_giat1.'</td>
			            <td class="kanan bawah text_blok nama"><a href="'.$link.'" target="_blank">'.$giat['nama'].'</a></td>
			            <td class="kanan bawah text_blok indikator rumus_indikator '.$class_rumus_target.'">'.$output_giat.'</td>
			            <td class="text_tengah kanan bawah text_blok total_renstra"></td>
			            <td class="text_tengah kanan bawah text_blok total_renstra">'.$satuan_output_giat.'</td>
			            <td class="text_kanan kanan bawah text_blok total_renstra"></td>
			            <td class="text_tengah kanan bawah text_blok realisasi_renstra_tahun_lalu"></td>
			            <td class="text_tengah kanan bawah text_blok realisasi_renstra_tahun_lalu">'.$satuan_output_giat.'</td>
			            <td class="text_kanan kanan bawah text_blok realisasi_renstra_tahun_lalu"></td>
			            <td class="text_tengah kanan bawah text_blok total_renja target_indikator">'.$target_output_giat.'</td>
			            <td class="text_tengah kanan bawah text_blok total_renja satuan_indikator">'.$satuan_output_giat.'</td>
			            <td class="text_kanan kanan bawah text_blok total_renja pagu_renja" data-pagu="'.$giat['total_simda'].'">'.number_format($giat['total_simda'],0,",",".").'</td>
			            <td class="text_tengah kanan bawah text_blok triwulan_1">'.$realisasi_indikator_tw1.'</td>
			            <td class="text_tengah kanan bawah text_blok triwulan_1">'.$satuan_output_giat.'</td>
			            <td class="text_kanan kanan bawah text_blok triwulan_1">'.number_format($giat['triwulan_1'],0,",",".").'</td>
			            <td class="text_tengah kanan bawah text_blok triwulan_2">'.$realisasi_indikator_tw2.'</td>
			            <td class="text_tengah kanan bawah text_blok triwulan_2">'.$satuan_output_giat.'</td>
			            <td class="text_kanan kanan bawah text_blok triwulan_2">'.number_format($giat['triwulan_2'],0,",",".").'</td>
			            <td class="text_tengah kanan bawah text_blok triwulan_3">'.$realisasi_indikator_tw3.'</td>
			            <td class="text_tengah kanan bawah text_blok triwulan_3">'.$satuan_output_giat.'</td>
			            <td class="text_kanan kanan bawah text_blok triwulan_3">'.number_format($giat['triwulan_3'],0,",",".").'</td>
			            <td class="text_tengah kanan bawah text_blok triwulan_4">'.$realisasi_indikator_tw4.'</td>
			            <td class="text_tengah kanan bawah text_blok triwulan_4">'.$satuan_output_giat.'</td>
			            <td class="text_kanan kanan bawah text_blok triwulan_4">'.number_format($giat['triwulan_4'],0,",",".").'</td>
			            <td class="text_tengah kanan bawah text_blok realisasi_renja">'.$total_tw.'</td>
			            <td class="text_tengah kanan bawah text_blok realisasi_renja">'.$satuan_output_giat.'</td>
			            <td class="text_kanan kanan bawah text_blok realisasi_renja pagu_renja_realisasi" data-pagu="'.$giat['realisasi'].'">'.number_format($giat['realisasi'],0,",",".").'</td>
			            <td class="text_tengah kanan bawah text_blok capaian_renja">'.$capaian_realisasi_indikator.'</td>
			            <td class="text_kanan kanan bawah text_blok capaian_renja">'.$capaian.'</td>
			            <td class="text_tengah kanan bawah text_blok realisasi_renstra_tahun_berjalan"></td>
			            <td class="text_tengah kanan bawah text_blok realisasi_renstra_tahun_berjalan">'.$satuan_output_giat.'</td>
			            <td class="text_kanan kanan bawah text_blok realisasi_renstra_tahun_berjalan"></td>
			            <td class="text_tengah kanan bawah text_blok capaian_renstra_tahun_berjalan"></td>
			            <td class="text_kanan kanan bawah text_blok capaian_renstra_tahun_berjalan"></td>
		        		<td class="kanan bawah text_blok">'.$unit[0]['nama_skpd'].'</td>
			        </tr>
				';
				foreach ($giat['data'] as $kd_sub_giat1 => $sub_giat) {
					$no_sub_kegiatan++;
					$kd_sub_giat = explode('.', $kd_sub_giat1);
					$kd_sub_giat = $kd_sub_giat[count($kd_sub_giat)-1];
					$capaian = 0;
					if(!empty($sub_giat['total_simda'])){
						$capaian = $this->pembulatan(($sub_giat['realisasi']/$sub_giat['total_simda'])*100);
					}
					$output_sub_giat = array();
					$target_output_sub_giat = array();
					$satuan_output_sub_giat = array();
					$realisasi_indikator_tw1 = array();
					$realisasi_indikator_tw2 = array();
					$realisasi_indikator_tw3 = array();
					$realisasi_indikator_tw4 = array();
					$total_tw = array();
					$capaian_realisasi_indikator = array();
					$class_rumus_target = array();
					if(!empty($sub_giat['indikator'])){
						$realisasi_indikator = array();
						foreach ($sub_giat['realisasi_indikator'] as $k_sub => $v_sub) {
							$realisasi_indikator[$v_sub['id_indikator']] = $v_sub;
						}
						foreach ($sub_giat['indikator'] as $k_sub => $v_sub) {
							$target_output_sub_giat[] = '<span data-id="'.$v_sub['idoutputbl'].'">'.$v_sub['targetoutput'].'</span>';
							$satuan_output_sub_giat[] = '<span data-id="'.$v_sub['idoutputbl'].'">'.$v_sub['satuanoutput'].'</span>';
							$target_indikator = $v_sub['targetoutput'];
							$realisasi_indikator_tw1[$k_sub] = 0;
							$realisasi_indikator_tw2[$k_sub] = 0;
							$realisasi_indikator_tw3[$k_sub] = 0;
							$realisasi_indikator_tw4[$k_sub] = 0;
							$total_tw[$k_sub] = 0;
							$capaian_realisasi_indikator[$k_sub] = 0;
							$class_rumus_target[$k_sub] = "positif";
							if(!empty($realisasi_indikator)){
								$rumus_indikator = $realisasi_indikator[$v_sub['idoutputbl']]['id_rumus_indikator'];
								$max = 0;
								for($i=1; $i<=12; $i++){
									$realisasi_bulan = $realisasi_indikator[$v_sub['idoutputbl']]['realisasi_bulan_'.$i];
									if($max < $realisasi_bulan){
										$max = $realisasi_bulan;
									}
									$total_tw[$k_sub] += $realisasi_bulan;
									if($i <= 3){
										if($rumus_indikator == 3 || $rumus_indikator == 2){
											if($i == 3){
												$realisasi_indikator_tw1[$k_sub] = $realisasi_bulan;
											}
										}else{
											$realisasi_indikator_tw1[$k_sub] += $realisasi_bulan;
										}
									}else if($i <= 6){
										if($rumus_indikator == 3 || $rumus_indikator == 2){
											if($i == 6){
												$realisasi_indikator_tw2[$k_sub] = $realisasi_bulan;
											}
										}else{
											$realisasi_indikator_tw2[$k_sub] += $realisasi_bulan;
										}
									}else if($i <= 9){
										if($rumus_indikator == 3 || $rumus_indikator == 2){
											if($i == 9){
												$realisasi_indikator_tw3[$k_sub] = $realisasi_bulan;
											}
										}else{
											$realisasi_indikator_tw3[$k_sub] += $realisasi_bulan;
										}
									}else if($i <= 12){
										if($rumus_indikator == 3 || $rumus_indikator == 2){
											if($i == 12){
												$realisasi_indikator_tw4[$k_sub] = $realisasi_bulan;
											}
										}else{
											$realisasi_indikator_tw4[$k_sub] += $realisasi_bulan;
										}
									}
								}
								if($rumus_indikator == 1){
									$class_rumus_target[$k_sub] = "positif";
									if(!empty($target_indikator)){
										$capaian_realisasi_indikator[$k_sub] = $this->pembulatan(($total_tw[$k_sub]/$target_indikator)*100);
									}
								}else if($rumus_indikator == 2){
									$class_rumus_target[$k_sub] = "negatif";
									$total_tw[$k_sub] = $max;
									if(!empty($total_tw[$k_sub])){
										$capaian_realisasi_indikator[$k_sub] = $this->pembulatan(($target_indikator/$total_tw[$k_sub])*100);
									}
								}else if($rumus_indikator == 3){
									$class_rumus_target[$k_sub] = "persentase";
									$total_tw[$k_sub] = $max;
									if(!empty($target_indikator)){
										$capaian_realisasi_indikator[$k_sub] = $this->pembulatan(($total_tw[$k_sub]/$target_indikator)*100);
									}
								}
							}
							$output_sub_giat[] = '<span data-id="'.$v_sub['idoutputbl'].'" class="rumus_indikator '.$class_rumus_target[$k_sub].'">'.$v_sub['outputteks'].button_edit_monev($input['tahun_anggaran'].'-'.$input['id_skpd'].'-'.$kd_sub_giat1.'-'.$sub_giat['data']['kode_sbl'].'-'.$v_sub['idoutputbl']).'</span>';
							$realisasi_indikator_tw1[$k_sub] = '<span class="realisasi_indikator_tw1-'.$v_sub['idoutputbl'].'">'.$realisasi_indikator_tw1[$k_sub].'</span>';
							$realisasi_indikator_tw2[$k_sub] = '<span class="realisasi_indikator_tw2-'.$v_sub['idoutputbl'].'">'.$realisasi_indikator_tw2[$k_sub].'</span>';
							$realisasi_indikator_tw3[$k_sub] = '<span class="realisasi_indikator_tw3-'.$v_sub['idoutputbl'].'">'.$realisasi_indikator_tw3[$k_sub].'</span>';
							$realisasi_indikator_tw4[$k_sub] = '<span class="realisasi_indikator_tw4-'.$v_sub['idoutputbl'].'">'.$realisasi_indikator_tw4[$k_sub].'</span>';
							$total_tw[$k_sub] = '<span class="total_tw-'.$v_sub['idoutputbl'].' rumus_indikator '.$class_rumus_target[$k_sub].'">'.$total_tw[$k_sub].'</span>';
							$capaian_realisasi_indikator[$k_sub] = '<span class="capaian_realisasi_indikator-'.$v_sub['idoutputbl'].' rumus_indikator '.$class_rumus_target[$k_sub].'">'.$capaian_realisasi_indikator[$k_sub].'</span>';
						}
					}
					$output_sub_giat = implode('<br>', $output_sub_giat);
					$target_output_sub_giat = implode('<br>', $target_output_sub_giat);
					$satuan_output_sub_giat = implode('<br>', $satuan_output_sub_giat);
					$realisasi_indikator_tw1 = implode('<br>', $realisasi_indikator_tw1);
					$realisasi_indikator_tw2 = implode('<br>', $realisasi_indikator_tw2);
					$realisasi_indikator_tw3 = implode('<br>', $realisasi_indikator_tw3);
					$realisasi_indikator_tw4 = implode('<br>', $realisasi_indikator_tw4);
					$total_tw = implode('<br>', $total_tw);
					$capaian_realisasi_indikator = implode('<br>', $capaian_realisasi_indikator);
					$body_monev .= '
						<tr class="sub_kegiatan" data-kode="'.$kd_urusan.'.'.$kd_bidang.'.'.$kd_program.'.'.$kd_giat.'.'.$kd_sub_giat.'">
				            <td class="kiri kanan bawah">'.$no_program.'.'.$no_kegiatan.'.'.$no_sub_kegiatan.'</td>
				            <td class="text_tengah kanan bawah"></td>
				            <td class="text_tengah kanan bawah"></td>
				            <td class="kanan bawah">'.$kd_sub_giat1.'</td>
				            <td class="kanan bawah nama">'.$sub_giat['nama'].'</td>
				            <td class="kanan bawah indikator">'.$output_sub_giat.'</td>
				            <td class="text_tengah kanan bawah total_renstra"></td>
				            <td class="text_tengah kanan bawah total_renstra">'.$satuan_output_sub_giat.'</td>
				            <td class="text_kanan kanan bawah total_renstra"></td>
				            <td class="text_tengah kanan bawah realisasi_renstra_tahun_lalu"></td>
				            <td class="text_tengah kanan bawah realisasi_renstra_tahun_lalu">'.$satuan_output_sub_giat.'</td>
				            <td class="text_kanan kanan bawah realisasi_renstra_tahun_lalu"></td>
				            <td class="text_tengah kanan bawah total_renja target_indikator">'.$target_output_sub_giat.'</td>
				            <td class="text_tengah kanan bawah total_renja satuan_indikator">'.$satuan_output_sub_giat.'</td>
				            <td class="text_kanan kanan bawah total_renja pagu_renja" data-pagu="'.$sub_giat['total_simda'].'">'.number_format($sub_giat['total_simda'],0,",",".").'</td>
				            <td class="text_tengah kanan bawah triwulan_1">'.$realisasi_indikator_tw1.'</td>
				            <td class="text_tengah kanan bawah triwulan_1">'.$satuan_output_sub_giat.'</td>
				            <td class="text_kanan kanan bawah triwulan_1">'.number_format($sub_giat['triwulan_1'],0,",",".").'</td>
				            <td class="text_tengah kanan bawah triwulan_2">'.$realisasi_indikator_tw2.'</td>
				            <td class="text_tengah kanan bawah triwulan_2">'.$satuan_output_sub_giat.'</td>
				            <td class="text_kanan kanan bawah triwulan_2">'.number_format($sub_giat['triwulan_2'],0,",",".").'</td>
				            <td class="text_tengah kanan bawah triwulan_3">'.$realisasi_indikator_tw3.'</td>
				            <td class="text_tengah kanan bawah triwulan_3">'.$satuan_output_sub_giat.'</td>
				            <td class="text_kanan kanan bawah triwulan_3">'.number_format($sub_giat['triwulan_3'],0,",",".").'</td>
				            <td class="text_tengah kanan bawah triwulan_4">'.$realisasi_indikator_tw4.'</td>
				            <td class="text_tengah kanan bawah triwulan_4">'.$satuan_output_sub_giat.'</td>
				            <td class="text_kanan kanan bawah triwulan_4">'.number_format($sub_giat['triwulan_4'],0,",",".").'</td>
				            <td class="text_tengah kanan bawah realisasi_renja">'.$total_tw.'</td>
				            <td class="text_tengah kanan bawah realisasi_renja">'.$satuan_output_sub_giat.'</td>
				            <td class="text_kanan kanan bawah realisasi_renja pagu_renja_realisasi" data-pagu="'.$sub_giat['realisasi'].'">'.number_format($sub_giat['realisasi'],0,",",".").'</td>
				            <td class="text_tengah kanan bawah capaian_renja">'.$capaian_realisasi_indikator.'</td>
				            <td class="text_kanan kanan bawah capaian_renja">'.$capaian.'</td>
				            <td class="text_tengah kanan bawah realisasi_renstra_tahun_berjalan"></td>
				            <td class="text_tengah kanan bawah realisasi_renstra_tahun_berjalan">'.$satuan_output_sub_giat.'</td>
				            <td class="text_kanan kanan bawah realisasi_renstra_tahun_berjalan"></td>
				            <td class="text_tengah kanan bawah capaian_renstra_tahun_berjalan"></td>
				            <td class="text_kanan kanan bawah capaian_renstra_tahun_berjalan"></td>
			        		<td class="kanan bawah">'.$unit[0]['nama_skpd'].'</td>
				        </tr>
					';
				}
			}
		}
	}
}

$nama_page = 'RFK '.$unit[0]['nama_skpd'].' '.$unit[0]['kode_skpd'].' | '.$input['tahun_anggaran'];
$custom_post = get_page_by_title($nama_page, OBJECT, 'page');
$link = $this->get_link_post($custom_post);
$url_skpd = '<a href="'.$link.'" target="_blank">'.$unit[0]['kode_skpd'].' '.$unit[0]['nama_skpd'].'</a> ';
?>
<style type="text/css">
	table th, #mod-monev th {
		vertical-align: middle;
	}
	body {
		overflow: auto;
	}
	td[contenteditable="true"] {
	    background: #ff00002e;
	}
	.negatif {
		color: #ff0000;
	}
	.persentase {
		color: #9d00ff; 
	}
</style>
<input type="hidden" value="<?php echo get_option('_crb_api_key_extension' ); ?>" id="api_key">
<input type="hidden" value="<?php echo $input['tahun_anggaran']; ?>" id="tahun_anggaran">
<input type="hidden" value="<?php echo $unit[0]['id_skpd']; ?>" id="id_skpd">
<h4 style="text-align: center; margin: 0; font-weight: bold;">Monitoring dan Evaluasi Rencana Kerja <br><?php echo $url_skpd.'<br>Tahun '.$input['tahun_anggaran'].' '.$nama_pemda; ?></h4>
<div id="cetak" title="Laporan MONEV RENJA" style="padding: 5px; overflow: auto; height: 80vh;">
	<table cellpadding="2" cellspacing="0" style="font-family:\'Open Sans\',-apple-system,BlinkMacSystemFont,\'Segoe UI\',sans-serif; border-collapse: collapse; font-size: 70%; border: 0; table-layout: fixed;" contenteditable="false">
		<thead>
			<tr>
				<th rowspan="5" style="width: 60px;" class='atas kiri kanan bawah text_tengah text_blok'>No</th>
				<th rowspan="2" style="width: 200px;" class='atas kanan bawah text_tengah text_blok'>Tujuan</th>
				<th rowspan="2" style="width: 200px;" class='atas kanan bawah text_tengah text_blok'>Sasaran</th>
				<th rowspan="2" style="width: 100px;" class='atas kanan bawah text_tengah text_blok'>Kode</th>
				<th rowspan="2" style="width: 300px;" class='atas kanan bawah text_tengah text_blok'>Program, Kegiatan, Sub Kegiatan</th>
				<th rowspan="2" style="width: 200px;" class='atas kanan bawah text_tengah text_blok'>Indikator Kinerja Tujuan, Sasaran, Program(outcome) dan Kegiatan (output), Sub Kegiatan</th>
				<th rowspan="2" colspan="3" style="width: 300px;" class='atas kanan bawah text_tengah text_blok'>Target Renstra SKPD pada Tahun <?php echo $awal_rpjmd; ?> s/d <?php echo $akhir_rpjmd; ?> (periode Renstra SKPD)</th>
				<th rowspan="2" colspan="3" style="width: 300px;" class='atas kanan bawah text_tengah text_blok'>Realisasi Capaian Kinerja Renstra SKPD sampai dengan Renja SKPD Tahun Lalu</th>
				<th rowspan="2" colspan="3" style="width: 300px;" class='atas kanan bawah text_tengah text_blok'>Target kinerja dan anggaran Renja SKPD Tahun Berjalan Tahun <?php echo $input['tahun_anggaran']; ?> yang dievaluasi</th>
				<th colspan="12" style="width: 1200px;" class='atas kanan bawah text_tengah text_blok'>Realisasi Kinerja Pada Triwulan</th>
				<th rowspan="2" colspan="3" style="width: 300px;" class='atas kanan bawah text_tengah text_blok'>Realisasi Capaian Kinerja dan Anggaran Renja SKPD yang dievaluasi</th>
				<th rowspan="2" colspan="2" style="width: 200px;" class='atas kanan bawah text_tengah text_blok'>Tingkat Capaian Kinerja dan Realisasi Anggaran Renja yang dievaluasi (%)</th>
				<th rowspan="2" colspan="3" style="width: 300px;" class='atas kanan bawah text_tengah text_blok'>Realisasi Kinerja dan Anggaran Renstra SKPD s/d Tahun <?php echo $input['tahun_anggaran']; ?> (Akhir Tahun Pelaksanaan Renja SKPD)</th>
				<th rowspan="2" colspan="2" style="width: 200px;" class='atas kanan bawah text_tengah text_blok'>Tingkat Capaian Kinerja dan Realisasi Anggaran Renstra SKPD s/d tahun <?php echo $input['tahun_anggaran']; ?> (%)</th>
				<th rowspan="2" style="width: 200px;" class='atas kanan bawah text_tengah text_blok'>Unit OPD Penanggung Jawab</th>
			</tr>
			<tr>
				<th colspan="3" class='atas kanan bawah text_tengah text_blok'>I</th>
				<th colspan="3" class='atas kanan bawah text_tengah text_blok'>II</th>
				<th colspan="3" class='atas kanan bawah text_tengah text_blok'>III</th>
				<th colspan="3" class='atas kanan bawah text_tengah text_blok'>VI</th>
			</tr>
			<tr>
				<th rowspan="3" class='atas kanan bawah text_tengah text_blok'>0</th>
				<th rowspan="3" class='atas kanan bawah text_tengah text_blok'>1</th>
				<th rowspan="3" class='atas kanan bawah text_tengah text_blok'>2</th>
				<th rowspan="3" class='atas kanan bawah text_tengah text_blok'>3</th>
				<th rowspan="3" class='atas kanan bawah text_tengah text_blok'>4</th>
				<th colspan="3" class='atas kanan bawah text_tengah text_blok'>5</th>
				<th colspan="3" class='atas kanan bawah text_tengah text_blok'>6</th>
				<th colspan="3" class='atas kanan bawah text_tengah text_blok'>7</th>
				<th colspan="3" class='atas kanan bawah text_tengah text_blok'>8</th>
				<th colspan="3" class='atas kanan bawah text_tengah text_blok'>9</th>
				<th colspan="3" class='atas kanan bawah text_tengah text_blok'>10</th>
				<th colspan="3" class='atas kanan bawah text_tengah text_blok'>11</th>
				<th colspan="3" class='atas kanan bawah text_tengah text_blok'>12 = 8+9+10+11</th>
				<th colspan="2" class='atas kanan bawah text_tengah text_blok'>13 = 12/7x100</th>
				<th colspan="3" class='atas kanan bawah text_tengah text_blok'>14 = 6 + 12</th>
				<th colspan="2" class='atas kanan bawah text_tengah text_blok'>15 = 14/5 x100</th>
				<th rowspan="3" class='atas kanan bawah text_tengah text_blok'>16</th>
			</tr>
			<tr>
				<th colspan="2" class='atas kanan bawah text_tengah text_blok'>K</th>
				<th rowspan="2" class='atas kanan bawah text_tengah text_blok'>Rp</th>
				<th colspan="2" class='atas kanan bawah text_tengah text_blok'>K</th>
				<th rowspan="2" class='atas kanan bawah text_tengah text_blok'>Rp</th>
				<th colspan="2" class='atas kanan bawah text_tengah text_blok'>K</th>
				<th rowspan="2" class='atas kanan bawah text_tengah text_blok'>Rp</th>
				<th colspan="2" class='atas kanan bawah text_tengah text_blok'>K</th>
				<th rowspan="2" class='atas kanan bawah text_tengah text_blok'>Rp</th>
				<th colspan="2" class='atas kanan bawah text_tengah text_blok'>K</th>
				<th rowspan="2" class='atas kanan bawah text_tengah text_blok'>Rp</th>
				<th colspan="2" class='atas kanan bawah text_tengah text_blok'>K</th>
				<th rowspan="2" class='atas kanan bawah text_tengah text_blok'>Rp</th>
				<th colspan="2" class='atas kanan bawah text_tengah text_blok'>K</th>
				<th rowspan="2" class='atas kanan bawah text_tengah text_blok'>Rp</th>
				<th colspan="2" class='atas kanan bawah text_tengah text_blok'>K</th>
				<th rowspan="2" class='atas kanan bawah text_tengah text_blok'>Rp</th>
				<th rowspan="2" class='atas kanan bawah text_tengah text_blok'>K</th>
				<th rowspan="2" class='atas kanan bawah text_tengah text_blok'>Rp</th>
				<th colspan="2" class='atas kanan bawah text_tengah text_blok'>K</th>
				<th rowspan="2" class='atas kanan bawah text_tengah text_blok'>Rp</th>
				<th rowspan="2" class='atas kanan bawah text_tengah text_blok'>K</th>
				<th rowspan="2" class='atas kanan bawah text_tengah text_blok'>Rp</th>
			</tr>
			<tr>
				<th class='atas kanan bawah text_tengah text_blok'>Volume</th>
				<th class='atas kanan bawah text_tengah text_blok'>Satuan</th>
				<th class='atas kanan bawah text_tengah text_blok'>Volume</th>
				<th class='atas kanan bawah text_tengah text_blok'>Satuan</th>
				<th class='atas kanan bawah text_tengah text_blok'>Volume</th>
				<th class='atas kanan bawah text_tengah text_blok'>Satuan</th>
				<th class='atas kanan bawah text_tengah text_blok'>Volume</th>
				<th class='atas kanan bawah text_tengah text_blok'>Satuan</th>
				<th class='atas kanan bawah text_tengah text_blok'>Volume</th>
				<th class='atas kanan bawah text_tengah text_blok'>Satuan</th>
				<th class='atas kanan bawah text_tengah text_blok'>Volume</th>
				<th class='atas kanan bawah text_tengah text_blok'>Satuan</th>
				<th class='atas kanan bawah text_tengah text_blok'>Volume</th>
				<th class='atas kanan bawah text_tengah text_blok'>Satuan</th>
				<th class='atas kanan bawah text_tengah text_blok'>Volume</th>
				<th class='atas kanan bawah text_tengah text_blok'>Satuan</th>
				<th class='atas kanan bawah text_tengah text_blok'>Volume</th>
				<th class='atas kanan bawah text_tengah text_blok'>Satuan</th>
			</tr>
		</thead>
		<tbody>
			<?php echo $body_monev; ?>
		</tbody>
	</table>
</div>

<div class="modal fade" id="mod-monev" tabindex="-1" role="dialog" data-backdrop="static" aria-hidden="true">'
    <div class="modal-dialog" style="min-width: 800px;" role="document">
        <div class="modal-content">
            <div class="modal-header bgpanel-theme">
                <h4 style="margin: 0;" class="modal-title" id="">Edit MONEV Indikator Per Bulan</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span><i class="dashicons dashicons-dismiss"></i></span></button>
            </div>
            <div class="modal-body">
            	<form>
                  	<div class="form-group">
                  		<table class="table table-bordered">
                  			<tbody>
                  				<tr>
                  					<th style="width: 200px;">Program / Kegaitan / Sub Kegiatan</th>
                  					<td id="monev-nama"></td>
                  				</tr>
                  				<tr>
                  					<td colspan="2">
                  						<table>
                  							<thead>
                  								<tr>
                  									<th class="text_tengah">Indikator Program(outcome) dan Kegiatan (output), Sub Kegiatan</th>
                  									<th class="text_tengah" style="width: 120px;">Target</th>
                  									<th class="text_tengah" style="width: 120px;">Satuan</th>
                  								</tr>
                  							</thead>
                  							<tbody id="monev-indikator">
                  							</tbody>
                  						</table>
                  					</td>
                  				</tr>
                  				<tr>
                  					<td colspan="2">
                  						<table>
                  							<thead>
                  								<tr>
                  									<th class="text_tengah" style="width: 140px;">Total Pagu (Rp.)</th>
                  									<th class="text_tengah">Pilih Rumus Indikator</th>
                  								</tr>
                  							</thead>
                  							<tbody>
                  								<tr>
                  									<td class="text_kanan" id="monev-pagu">-</td>
				                  					<td>
				                  						<select style="width: 100%;" id="tipe_indikator">
				                  							<?php echo $rumus_indikator_html; ?>
				                  						</select>
				                  						<ul id="helptext_tipe_indikator" style="margin: 10px 0 0 30px;">
				                  							<?php echo $keterangan_indikator_html; ?>
				                  						</ul>
				                  					</td>
                  								</tr>
                  							</tbody>
                  						</table>
                  					</td>
                  				</tr>
                  				<tr>
                  					<td colspan="2">
                  						<table>
                  							<thead>
                  								<tr>
		              								<th class="text_tengah">Bulan</th>
		              								<th class="text_tengah" style="width: 150px;">RAK (Rp.)</th>
		              								<th class="text_tengah" style="width: 150px;">Realisasi (Rp.)</th>
		              								<th class="text_tengah" style="width: 150px;">Selisih (Rp.)</th>
		              								<th class="text_tengah" style="width: 150px;">Realisasi Target</th>
		              							</tr>
                  								<tr>
		              								<th class="text_tengah">1</th>
		              								<th class="text_tengah">2</th>
		              								<th class="text_tengah">3</th>
		              								<th class="text_tengah">4 = 2 - 3</th>
		              								<th class="text_tengah">5</th>
		              							</tr>
                  							</thead>
                  							<tbody id="monev-body"></tbody>
                  							<tfoot>
												<tr>
													<th class="text_tengah text_blok">Target Indikator</th>
													<th class="text_kanan text_blok" id="target_indikator_monev_rumus">0</th>
													<th class="text_kanan text_blok" colspan="2">Capaian target dihitung sesuai rumus indikator</th>
													<th class="text_tengah text_blok" id="capaian_target_realisasi">0</th>
												</tr>
                  							</tfoot>
                  						</table>
                  					</td>
                  				</tr>
                  			</tbody>
                  		</table>
                  	</div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="set-monev">Simpan</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Tutup</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
	run_download_excel();
	var batas_bulan_input = <?php echo $batas_bulan_input; ?>;
	var aksi = ''
		+'<h3 style="margin-top: 20px;">SETTING</h3>'
		+'<label><input type="checkbox" onclick="edit_monev_indikator(this);"> Edit Monev indikator</label>';
	jQuery('#action-sipd').append(aksi);
	function edit_monev_indikator(that){
		if(jQuery(that).is(':checked')){
			jQuery('.edit-monev').show();
		}else{
			jQuery('.edit-monev').hide();
		}
	}
	function setRumus(id){
		jQuery('#tipe_indikator').val(id);
		jQuery('#helptext_tipe_indikator li').hide();
		jQuery('#helptext_tipe_indikator li[data-id="'+id+'"]').show();
		setTotalMonev(false);
	}
	function setTotalMonev(that){
		var total_indikator = +jQuery('#target_indikator_monev').text();
		var tipe_indikator = jQuery('#tipe_indikator').val();
		if(tipe_indikator == 3 && that){
			var id = jQuery(that).attr('id');
			var bulan = +id.replace('target_realisasi_bulan_', '');
			if(bulan > 1){
				var val_bulan_sebelumnya = +jQuery('#target_realisasi_bulan_'+(bulan-1)).text();
				var val = jQuery(that).text();
				if(val < val_bulan_sebelumnya && val > 0){
					jQuery(that).text(val_bulan_sebelumnya);
					alert('Untuk rumus indikator persentasi, nilai target tidak boleh lebih kecil dari bulan sebelumnya!');
				}
			}
		}
		var total = 0;
		var target_batas_bulan_input = 0;
		var bulan = 0;
		jQuery('#monev-body .target_realisasi').map(function(){
			bulan++;
			var target_bulanan = +jQuery(this).text();
			total += target_bulanan;
			if(batas_bulan_input == bulan){
				target_batas_bulan_input = target_bulanan;
			}
		});
		var total_realisasi_indikator = 0;
		if(tipe_indikator == 1){
			if(total_indikator > 0){
				total_realisasi_indikator = Math.round((total/total_indikator)*10000)/100;
			}
		}else if(tipe_indikator == 2){
			total = target_batas_bulan_input;
			if(total > 0){
				total_realisasi_indikator = Math.round((total_indikator/total)*10000)/100;
			}
		}else if(tipe_indikator == 3){
			total = target_batas_bulan_input;
			if(total_indikator > 0){
				total_realisasi_indikator = Math.round((total/total_indikator)*10000)/100;
			}
		}
		jQuery('#total_target_realisasi').text(total);
		jQuery('#capaian_target_realisasi').text(total_realisasi_indikator);
	}
	jQuery('#tipe_indikator').on('click', function(){
		setRumus(jQuery(this).val());
	});
	jQuery('.edit-monev').on('click', function(){
		jQuery('#wrap-loading').show();
		var id_unik = jQuery(this).attr('data-id');
		var tr = jQuery(this).closest('tr');
		var nama = tr.find('td.nama').text();
		var id_indikator = id_unik.split('-').pop();
		var indikator_text = tr.find('td.indikator span[data-id="'+id_indikator+'"]').text();
		if(indikator_text == ''){
			indikator_text = tr.find('td.indikator').text();
		}
		var target_indikator_text = tr.find('td.target_indikator span[data-id="'+id_indikator+'"]').text();
		if(target_indikator_text == ''){
			target_indikator_text = tr.find('td.target_indikator').text();
		}
		var satuan_indikator_text = tr.find('td.satuan_indikator span[data-id="'+id_indikator+'"]').text();
		if(satuan_indikator_text == ''){
			satuan_indikator_text = tr.find('td.satuan_indikator').text();
		}
		var pagu_renja = tr.find('td.pagu_renja').attr('data-pagu');
		var pagu_renja_text = tr.find('td.pagu_renja').text();
		var indikator = ''
			+'<tr>'
				+'<td>'+indikator_text+'</td>'
				+'<td class="text_tengah" id="target_indikator_monev">'+target_indikator_text+'</td>'
				+'<td class="text_tengah">'+satuan_indikator_text+'</td>'
			+'</tr>';
		jQuery('#target_indikator_monev_rumus').text(target_indikator_text);
		jQuery.ajax({
			url: ajax.url,
          	type: "post",
          	data: {
          		"action": "get_monev",
          		"api_key": "<?php echo $api_key; ?>",
      			"tahun_anggaran": <?php echo $input['tahun_anggaran']; ?>,
          		"id_unik": id_unik
          	},
          	dataType: "json",
          	success: function(res){
          		jQuery('#monev-nama').text(nama);
          		jQuery('#monev-indikator').html(indikator);
          		jQuery('#monev-pagu').attr('data-pagu', pagu_renja).text(pagu_renja_text);
          		jQuery('#monev-body').html(res.table);
				jQuery('#mod-monev').attr('data-id_unik', id_unik);
          		setRumus(res.id_rumus_indikator);
				jQuery('#mod-monev').modal('show');
				jQuery('#wrap-loading').hide();
			}
		});
	});
	jQuery('#set-monev').on('click', function(){
		var target_realisasi = {};
		var total_tw1 = 0;
		var total_tw2 = 0;
		var total_tw3 = 0;
		var total_tw4 = 0;
		var total_tw = jQuery('#total_target_realisasi').text();
		var capaian_realisasi_indikator = jQuery('#capaian_target_realisasi').text();
		var tipe_indikator = jQuery('#tipe_indikator').val();
		for(var i=1; i<=12; i++){
			var id = 'target_realisasi_bulan_'+i; 
			target_realisasi[id] = +jQuery('#'+id).text().trim();
			if(i<=3){
				if(tipe_indikator == 3 || tipe_indikator == 2){
					if(i == 3){
						total_tw1 = target_realisasi[id];
					}
				}else{
					total_tw1 += target_realisasi[id];
				}
			}else if(i<=6){
				if(tipe_indikator == 3 || tipe_indikator == 2){
					if(i == 6){
						total_tw2 = target_realisasi[id];
					}
				}else{
					total_tw2 += target_realisasi[id];
				}
			}else if(i<=9){
				if(tipe_indikator == 3 || tipe_indikator == 2){
					if(i == 9){
						total_tw3 = target_realisasi[id];
					}
				}else{
					total_tw3 += target_realisasi[id];
				}
			}else if(i<=12){
				if(tipe_indikator == 3 || tipe_indikator == 2){
					if(i == 12){
						total_tw4 = target_realisasi[id];
					}
				}else{
					total_tw4 += target_realisasi[id];
				}
			}
		}
		if(confirm('Apakah anda yakin untuk menyimpan data ini!')){
			jQuery('#wrap-loading').show();
			var id_unik = jQuery('#mod-monev').attr('data-id_unik');
			jQuery.ajax({
				url: ajax.url,
	          	type: "post",
	          	data: {
	          		"action": "save_monev_renja",
	          		"api_key": "<?php echo $api_key; ?>",
	      			"tahun_anggaran": <?php echo $input['tahun_anggaran']; ?>,
	          		"id_unik": id_unik,
	          		"data": target_realisasi,
	          		"rumus_indikator": jQuery('#tipe_indikator').val()
	          	},
	          	dataType: "json",
	          	success: function(res){
	          		var tr  = jQuery('.edit-monev[data-id="'+id_unik+'"]').closest('tr');
	          		var ids = id_unik.split('-');
	          		var id_indikator = ids[4];
	          		jQuery(tr).find('.realisasi_indikator_tw1-'+id_indikator).text(total_tw1);
	          		jQuery(tr).find('.realisasi_indikator_tw2-'+id_indikator).text(total_tw2);
	          		jQuery(tr).find('.realisasi_indikator_tw3-'+id_indikator).text(total_tw3);
	          		jQuery(tr).find('.realisasi_indikator_tw4-'+id_indikator).text(total_tw4);
	          		jQuery(tr).find('.realisasi_indikator_tw4-'+id_indikator).text(total_tw4);
	          		jQuery(tr).find('.total_tw-'+id_indikator).text(total_tw);
	          		jQuery(tr).find('.capaian_realisasi_indikator-'+id_indikator).text(capaian_realisasi_indikator);
	          		jQuery(tr).find('.rumus_indikator').removeClass('positif negatif persentase');
	          		var rumus_indikator = 'positif';
	          		if(tipe_indikator == 2){
	          			rumus_indikator = 'negatif';
	          		}else if(tipe_indikator == 3){
	          			rumus_indikator = 'persentase';
	          		}
	          		jQuery(tr).find('.rumus_indikator').addClass(rumus_indikator);
					jQuery('#mod-monev').modal('hide');
					jQuery('#wrap-loading').hide();
				}
			});
		}
	});
</script>