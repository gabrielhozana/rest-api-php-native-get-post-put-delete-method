<?php
	header("Content-Type:application/json");
	$conn = mysqli_connect('localhost', 'root', '', 'bhinneka_dbms'); 
	mysqli_set_charset($conn, 'utf8');
	$method = $_SERVER['REQUEST_METHOD'];
	$results = array();

	if ($method == 'DELETE'){
		parse_str(file_get_contents('php://input'), $_DELETE);
		$id_pelanggan = $_DELETE['id_pelanggan'];

		$sql = "DELETE FROM pelanggan WHERE id_pelanggan ='$id_pelanggan'";
		$conn->query($sql);

		$results['Status']['success'] = true;
		$results['Status']['code'] = 200;
		$results['Status']['description'] = 'Data Succesfully Deleted';		
	}
	else{
		$results['Status']['code'] = 405;
	}

	//Menampilkan Data JSON dari Database
	$json = json_encode($results);
	print_r($json);
?>