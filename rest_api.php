<?php
	header("Content-Type:application/json");
	$conn = mysqli_connect('localhost', 'root', '', 'bhinneka_dbms'); 
	mysqli_set_charset($conn, 'utf8');
	$method = $_SERVER['REQUEST_METHOD'];
	$results = array();

	if ($method == 'GET') {
		$query = mysqli_query($conn, 'SELECT * FROM pelanggan');

		if (mysqli_num_rows($query) > 0) {
			while($row = mysqli_fetch_assoc($query)) {
				$results['Status']['success'] = true;
				$results['Status']['code'] = 200;
				$results['Status']['description'] = 'Request Valid';
				$results['Hasil'][] = [
					'id_pelanggan' => $row['id_pelanggan'],
					'nama_pelanggan' => $row['nama_pelanggan'],
					'email' => $row['email'],
					'password' => $row['password'],
					'jenis_kelamin' => $row['jenis_kelamin'],
					'tgl_lahir' => $row['tgl_lahir'],
					'pembayaran_berhasil' => $row['pembayaran_berhasil'],
					'no_telp' => $row['no_telp'],
					'pembayaran_batal' => $row['pembayaran_batal'],
					'menunggu_pembayaran' => $row['menunggu_pembayaran'],
					'alamat' => $row['alamat']
				];
			}
		}
		else{
			$results['Status']['code'] = 400;
			$results['Status']['description'] = 'Request Invalid';
		}
	}

	elseif ($method == 'POST'){
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

	elseif ($method == 'PUT'){
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

	elseif ($method == 'DELETE'){
		parse_str(file_get_contents('php://input'), $_DELETE);
		$id_pelanggan = $_DELETE['id_pelanggan'];

		$sql = "DELETE FROM pelanggan WHERE id_pelanggan ='$id_pelanggan'";
		$conn->query($sql);

		$results['Status']['success'] = true;
		$results['Status']['code'] = 200;
		$results['Status']['description'] = 'Data Succesfully Deleted';		
	}

	else{
		$results['Status']['code'] = 404;
	}

	//Menampilkan Data JSON dari Database
	$json = json_encode($results);
	print_r($json);
?>