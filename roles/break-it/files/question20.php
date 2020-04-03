<?php
$now = time();
while ($now + 15 > time()) { }
print "Script complete";
ob_end_flush();
?>
