<?php

if (!empty($_POST['pw'])) {
  $npass = preg_replace('/[^a-z0-9]+/i', '', $_POST['pw']);
  echo("<h2>Your new password for admin account is: ".$npass."<h2>");
  echo("<h3>You can now log in with your account here: <a href='https://".explode(':', $_SERVER['HTTP_HOST'])[0].":8080'>MineOS Admin panel</a></h3>");
  ob_end_flush();
  exec("echo 'admin:$npass' | chpasswd && pkill php && update-rc.d -f changepw remove && rm -rf /root/changepw /etc/init.d/changepw");
} else {
?>

<form method="post" action="">
<h2>Enter the new password for 'admin' account (only LETTERS and NUMBERS allowed):</h2>
<input type="text" size=40 name="pw">
<input type=submit value="Submit new password">
</form>

<?php } ?>
