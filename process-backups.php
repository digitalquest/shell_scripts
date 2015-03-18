<?php

// Pameters
$directory=$argv[1];

$logfile = "/data/import.log";

// Connect to snapshot DB
$db = new mysqli("bagpa.lnx.warwick.ac.uk", "admin", "qf03uqzMP") or die("error: " + mysqli_error());
$db->select_db("db2");

// For each file in this directory
if (is_dir($directory))
{
  foreach(glob($directory.'/*.mbz') as $file) {
  
    $idnumber = '';
    $existingid = '';
    // Extract ID number
    preg_match('/backup-moodle2-course-(\d+)-/', $file, $matches);
    $courseid = $matches[1];

    // Using this ID, look up course idnumber from snapshot of live database
    print "Examining file " . $file . "\n";
    $db->select_db("db2");
    if ($stmt = $db->prepare("SELECT shortname FROM mdl_course WHERE id = ?")) {
      $stmt->bind_param("s", $courseid);
      $stmt->execute();
      $stmt->bind_result($idnumber);
      $stmt->fetch();
      $stmt->close();
    } else {
     print "Problem quering live database\n";
     print $db->error;
    }

    if ($idnumber != '') {
      print "*************************Found courseid: " . $idnumber . "\n";

      // Does this idnumber already exist in the readonly system?
      $db->select_db("db1");
      if ($stmt2 = $db->prepare("SELECT id FROM mdl_course WHERE shortname = ?")) {
        $stmt2->bind_param("s", $idnumber);
        $stmt2->execute();
        $stmt2->bind_result($existingid);
        $stmt2->fetch();
        $stmt2->close();

        print "****************RETRIEVED ID: " . $existingid . "\n";
  
        // If yes? Skip, otherwise import
        if( $existingid != '') {
          print "Skipping " . $idnumber . " because of existing instance of course at " . $existingid . "\n";
        } else {
          print "Importing course " . $courseid . "\n";
          exec("/home/admin/moosh/moosh.php --moodle-path /data/www/html/ course-restore \"" . $file . "\" 1");
        }
 
      } else {
       print "Problem quering read-only database\n";
       print $db->error;
      }
    }
  }

}

$db->close();
?>
