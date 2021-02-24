<?php
//database connectivity

$dbhost = "localhost";
$dbuser = "root";
$dbpass = ""; 
$dbname= "databaseName";
$myConn = mysqli_connect($dbhost,$dbuser,$dbpass,$dbname) or die("Database not found...");
		
// retrieve data in for loop from mysql database	 
$q1="SELECT * from tableName";
$show = null; 
$result=mysqli_query($myConn,$q1); 
while ($row = mysqli_fetch_array($result)) 
{ 
$show[] = array(
"userid"=>"{$row['userid']}",
"phone"=>"{$row['phone']}",
);   
}
echo json_encode($show);
?>
