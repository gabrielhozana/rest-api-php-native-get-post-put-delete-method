<?php
	header("Content-Type:application/json");
	$conn = mysqli_connect('localhost', 'root', '', 'bhinneka_dbms'); 
	mysqli_set_charset($conn, 'utf8');
	$method = $_SERVER['REQUEST_METHOD'];
	$results = [];

	if ($method == 'GET') {
		$query = mysqli_query($conn, 'SELECT * FROM pelanggan');

		// $i = 1;
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
				// $i = $i + 1;
			}
			//Menampilkan Data JSON dari Database

			// $data = ['Hasil' => $results];
			$json = json_encode($results);
			print_r($json);
		}
		else{
			$results['Status']['code'] = 400;
			$results['Status']['description'] = 'Request Invalid';
		}
	}else{
		$results['Status']['code'] = 404;
	}

	
?>