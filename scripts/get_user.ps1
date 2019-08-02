$matchinfo = Select-String -Path capture.txt -SimpleMatch 'Username:'
$username = ($matchinfo.ToString()).Split(':')[4].Trim()

$pwdinfo = Select-String -Path capture.txt -SimpleMatch 'Password:'
$userpassword = ($pwdinfo.ToString()).Split(':')[4].Trim()

Write-Output $username
Write-Output $userpassword
