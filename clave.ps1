#Variables
#Variables
$counter = 0 #Counter for create password with selected length
$maxrdm = 8  #set maximum random number to 8

#Settings Window
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$window = New-Object System.Windows.Forms.Form
$window.Text =""
#$geticon = New-Object system.drawing.icon (".\pg-ps-icon.ico")
#$window.Icon = $geticon
$window.Width = 200
$window.Height = 210

#Label Settings
$labelauthor = New-Object System.Windows.Forms.Label
$labelauthor.Location = New-Object System.Drawing.Size(100,30)
$labelauthor.font = New-Object System.Drawing.Font(7,7)
$labelauthor.ForeColor = "blue"
$labelauthor.Text = "PSW-G x TUTE"
$labelauthor.AutoSize = $True
$window.Controls.Add($labelauthor)

$labelauthor = New-Object System.Windows.Forms.Label
$labelauthor.Location = New-Object System.Drawing.Size(5,10)
$labelauthor.font = New-Object System.Drawing.Font(7,7)
$labelauthor.ForeColor = "red"
$labelauthor.Text = "Clave Usuario UdeSA"
$labelauthor.AutoSize = $True
$window.Controls.Add($labelauthor)

$labellength = New-Object System.Windows.Forms.Label
$labellength.Location = New-Object System.Drawing.Size(10,10)
$labellength.Text = ""
$labellength.AutoSize = $True
$window.Controls.Add($labellength)

$labelversion = New-Object System.Windows.Forms.Label
$labelversion.Location = New-Object System.Drawing.Size(120,45)
$labelversion.font = New-Object System.Drawing.Font(7,7)
$labelversion.ForeColor = "black"
$labelversion.Text = "V: 0.2b"
$labelversion.AutoSize = $True
$window.Controls.Add($labelversion)

$linkgithub = New-Object System.Windows.Forms.LinkLabel 
$linkgithub.Location = New-Object System.Drawing.Size(434,25) 
$linkgithub.Size = New-Object System.Drawing.Size(150,20) 
$linkgithub.font = New-Object System.Drawing.Font(7,7)
$linkgithub.LinkColor = "blue" 
$linkgithub.ActiveLinkColor = "blue" 
$window.Controls.Add($linkgithub) 

$labelinfosc2 = New-Object System.Windows.Forms.Label
$labelinfosc2.Location = New-Object System.Drawing.Size(10,120)
$labelinfosc2.Text = ""
$labelinfosc2.AutoSize = $True
$window.Controls.Add($labelinfosc2)

$labelresult = New-Object System.Windows.Forms.Label
$labelresult.Location = New-Object System.Drawing.Size(10,70)
$labelresult.Size = New-Object System.Drawing.Size(10,10)
$labelresult.Text = "Tu Clave es..."
$labelresult.AutoSize = $True
$window.Controls.Add($labelresult)

#Textfield Settings
$specialcharsbx = New-Object System.Windows.Forms.TextBox
$specialcharsbx.Location = New-Object System.Drawing.Size(10,50)
$specialcharsbx.Size = New-Object System.Drawing.Size(50,50)
$specialcharsbx.Text = "*"
$window.Controls.Add($specialcharsbx)

$outputbx = New-Object System.Windows.Forms.TextBox
$outputbx.Location = New-Object System.Drawing.Size(10,90)
$outputbx.Size = New-Object System.Drawing.Size(80,50)
$window.Controls.Add($outputbx)

$lengthbx = New-Object System.Windows.Forms.TextBox
$lengthbx.Location = New-Object System.Drawing.Size(10,30)
$lengthbx.Size = New-Object System.Drawing.Size(50,50)
$lengthbx.Text = "8"
$window.Controls.Add($lengthbx)

#Button Handling
  $generatebutton = New-Object System.Windows.Forms.Button
  $generatebutton.Location = New-Object System.Drawing.Size(30,115)
  $generatebutton.Size = New-Object System.Drawing.Size(75,50)
  $generatebutton.ForeColor  = "yellow"
  $generatebutton.BackColor  = "blue"
  $generatebutton.Text = "GENERAR"
  $generatebutton.Add_Click({
     $counter = 0 #Set counter to 0 for new password
     $scvar = $specialcharsbx.Text
     $lengthvar = [int]$lengthbx.Text
     $lenghend  = $lengthvar -1
     $maxrdm = 5  #set maximum random number to 5
     $scarray = $scvar -split '' | Where-Object {$_ -ne ''} #split entries in textfield into single characters
   if ($lengthvar -lt 1) { # Check for password length 
      $password = "Please choose a length greater than 3"
      $counter = $lengthvar #End creating password by setting counter to selected length
   }   
   if ($scvar.Length -lt 1) { # Check for special characters length
      $maxrdm = 1   #Ignore special characters with setting maxrdm to 4
   } 
   
   while($counter  -ne $lengthvar){ #Start creating password
      $option = Get-Random -Minimum 1 -Maximum $maxrdm #Set Random Option

      if ($counter -eq '0') { #first char should not be a special character 
          $option = Get-Random -Minimum 1 -Maximum 4
      }
      if ($counter -eq $lenghend) { #last char should not be a special character 
          $option = Get-Random -Minimum 1 -Maximum 4
      }

      if ($option -eq '1') { #Add higher characters to generated password
          $passwordchar = Get-Random "Z","Y","X","W","V","U","T","S","R","Q","P","O","N","M","L","K","J","I","H","G","F","E","D","C","B","A"
      } elseif ($option -eq '2') { #Add lower characters to generated password
          $passwordchar = Get-Random "z","y","x","w","v","u","t","s","r","q","p","o","n","m","l","k","j","i","h","g","f","e","d","c","b","a"
      } elseif ($option -eq '3') { #Add special characters to generated password
            $passwordchar = Get-Random -InputObject $scarray -Count 1
      } elseif ($option -eq '4') { #Add numbers to generated password
          $passwordchar = Get-Random "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" 
      
      }

      $password += [string]$passwordchar #Add charcters as string to the variable password
      $counter += 1 #Count for password length
      Set-Clipboard -Value $password
   }

   $outputbx.Text = $password  #Print password   
  })
 
#Add buttons
$window.Controls.Add($defaultscbutton)
$window.Controls.Add($generatebutton)

#END
[void]$window.ShowDialog()

# bx= box, sc= special character(s), rdm= random
###EOF###