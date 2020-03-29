<?php
	header("Content-Type:application/json");
	$conn = mysqli_connect('localhost', 'root', '', 'bhinneka_dbms'); 
	mysqli_set_charset($conn, 'utf8');
	$method = $_SERVER['REQUEST_METHOD'];
	$results = array();

	if ($method == 'PUT'){
		parse_str(file_get_contents('php://input'), $_PUT);
		$id_pelanggan = $_PUT['id_pelanggan'];
		$nama_pelanggan = $_PUT['nama_pelanggan'];
		$email = $_PUT['email'];
		$password = $_PUT['password'];
		$jenis_kelamin = $_PUT['jenis_kelamin'];
		$tgl_lahir = $_PUT['tgl_lahir'];
		$pembayaran_berhasil = $_PUT['pembayaran_berhasil'];
		$no_telp = $_PUT['no_telp'];
		$pembayaran_batal = $_PUT['pembayaran_batal'];
		$menunggu_pembayaran = $_PUT['menunggu_pembayaran'];
		$alamat = $_PUT['alamat'];

		$sql = "UPDATE pelanggan SET nama_pelanggan = '$nama_pelanggan', email = '$email', password = '$password', jenis_kelamin ='$jenis_kelamin', tgl_lahir = '$tgl_lahir', pembayaran_berhasil = '$pembayaran_berhasil', no_telp = '$no_telp', pembayaran_batal = '$pembayaran_batal', menunggu_pembayaran = '$menunggu_pembayaran', alamat = '$alamat' WHERE id_pelanggan ='$id_pelanggan'";
		
		$conn->query($sql);

		$results['Status']['success'] = true;
		$results['Status']['code'] = 200;
		$results['Status']['description'] = 'Data Succesfully Updated';
		$results['Hasil'] = array(
			'nama_pelanggan' => $nama_pelanggan,
			'email' => $email,
			'password' => $password,
			'jenis_kelamin' => $jenis_kelamin,
			'tgl_lahir' => $tgl_lahir,
			'pembayaran_berhasil' => $pembayaran_berhasil,
			'pembayaran_batal' => $pembayaran_batal,
			'no_telp' => $no_telp,
			'menunggu_pembayaran' => $menunggu_pembayaran,
			'alamat' => $alamat
		);						
	}
	else{
		$results['Status']['code'] = 405;
	}

	//Menampilkan Data JSON dari Database
	$json = json_encode($results);
	print_r($json);
?>