<?php
	header("Content-Type:application/json");
	$conn = mysqli_connect('localhost', 'root', '', 'bhinneka_dbms'); 
	mysqli_set_charset($conn, 'utf8');
	$method = $_SERVER['REQUEST_METHOD'];
	$results = array();

	if ($method == 'POST'){
		$nama_pelanggan = $_POST['nama_pelanggan'];
		$email = $_POST['email'];
		$password = $_POST['password'];
		$jenis_kelamin = $_POST['jenis_kelamin'];
		$tgl_lahir = $_POST['tgl_lahir'];
		$pembayaran_berhasil = $_POST['pembayaran_berhasil'];
		$no_telp = $_POST['no_telp'];
		$pembayaran_batal = $_POST['pembayaran_batal'];
		$menunggu_pembayaran = $_POST['menunggu_pembayaran'];
		$alamat = $_POST['alamat'];

		$sql = "INSERT INTO pelanggan (nama_pelanggan, email, password, jenis_kelamin, tgl_lahir, pembayaran_berhasil, no_telp, pembayaran_batal, menunggu_pembayaran, alamat) VALUES ('$nama_pelanggan', '$email', '$password', '$jenis_kelamin', '$tgl_lahir', '$pembayaran_berhasil', '$no_telp', '$pembayaran_batal', '$menunggu_pembayaran', '$alamat')";

		$conn->query($sql);

		$results['Status']['success'] = true;
		$results['Status']['code'] = 200;
		$results['Status']['description'] = 'Request Valid';
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
		$results['Status']['code'] = 400;
	}

	//Menampilkan Data JSON dari Database
	$json = json_encode($results);
	print_r($json);
?>