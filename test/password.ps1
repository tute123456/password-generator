function Get-RandomCharacters($length, $characters) { 
    $random = 1..$length | ForEach-Object { Get-Random -Maximum $characters.length } 
    $private:ofs="" 
    return [String]$characters[$random]
}

$password = Get-RandomCharacters -length 1 -characters 'ABCDEFGHKLM'
$password += Get-RandomCharacters -length 1 -characters 'xyzwqkmj'
$password += Get-RandomCharacters -length 1 -characters 'NOPQRSTUVWXYZ'
$password += '*'
$password += Get-RandomCharacters -length 3 -characters '1234567890'
$password += Get-RandomCharacters -length 1 -characters 'xyzwqkmj'
$password
Set-Clipboard -Value $password