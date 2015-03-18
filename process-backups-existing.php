<?php

// Pameters
$directory=$argv[1];

// For each file in this directory
if (is_dir($directory))
{
  foreach(glob($directory.'/*.mbz') as $file) {
    // Extract ID number
    preg_match('/backup-moodle2-course-(\d+)-/', $file, $matches);
    $courseid = $matches[1];

    // Is this already in the readonly system?

      // Yes? Delete existing course

    // Create new course with this ID
    print "Creating course " . $courseid . "\n";
    exec("/home/admin/moosh/moosh.php --moodle-path /data/www/html/ course-delete --id " . $courseid);
    //exec("/home/admin/moosh/moosh.php --moodle-path /data/www/html/ course-create --category 6 --id " . $courseid . " --fullname 'Restore Course' rcs" . $courseid);

    // Import course from backup file
    print "Importing course " . $courseid . "\n";
    exec("/home/admin/moosh/moosh.php --moodle-path /data/www/html/ course-restoreexisting \"" . $file . "\" " . $courseid);
  }

}
?>
