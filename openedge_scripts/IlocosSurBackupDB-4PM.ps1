
###################################################################################################
#--------------------------------------------------------------------------------------------------
# **************** This Powershell Script Version2 is for 
#                                           backing up the eGaps Database *************************
# Created April 9, 2022, LTI
#--------------------------------------------------------------------------------------------------
###################################################################################################
#
#
# Modify this scrip using "Windows Powershell ISE"
#
# Modify the Step No.2, the path for each databases, name of dotbak file, 
# and filename for rar file and then test the script. 
# For example: 
# $db1 = "D:\database\IlocosSur\Global\globaldb.db"
# $db1bakup = "globaldb.bak"
# $db1rar = "globaldb.rar"
#
# If error occured, modify the other settings according to your environment.
#
#
###################################################################################################



    function Get-TimeStamp {
    
    return "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)
    
}


#
## 1. Create folder
#
$BackupFolder = "D:\DB-Backup\IlocosSur\4PM"
if (!(Test-Path $BackupFolder)) { mkdir $BackupFolder }

    if(!(Test-Path $BackupFolder)) { 
                                     write-host "Cannot locate the backup folder. Please check your script" 
                                     Write-Output "$(Get-TimeStamp) Cannot locate the backup folder. Please check your script " | Out-file C:\backuplog.txt -append
                                    } 

    else{
        #
        ###$GetTheDateToDay = (Get-Date).ToString("MMMM dd,yyyy [hhtt]")
        ###New-Item -ItemType Directory -Path "$BackupFolder" -Name ($GetTheDateToDay) -Force
        $GetDayOfWeek = (Get-Date).DayOfWeek
        New-Item -ItemType Directory -Path "$BackupFolder" -Name ($GetDayOfWeek) -Force
        #
        #
        #
        ###$GetTheHostName = "$BackupFolder\$GetTheDateToDay\${Env:ComputerName}"
        $BackupLocation = "$BackupFolder\$GetDayOfWeek"
        if (!(Test-Path $BackupLocation)) { mkdir $BackupLocation -Force}
        #
        #
        #
        #
        ## 2. Set the alias command for probkup, in order the powershell
        New-Alias probkup 'C:\Program Files\Progress\bin\probkup.bat' -Force
        #
        #
        # Set the database to backup here <<<=====
        #
        $db1      = "D:\Database\IlocosSur\AudioFile\audiodb.db"
        $db1bakup = "audiodb.bak"
        $db1rar   = "audiodb.rar"

        $db2      = "D:\Database\IlocosSur\Audit\auditdb.db" 
        $db2bakup = "auditdb.bak"
        $db2rar   = "auditdb.rar"
        

        $db3      = "D:\Database\IlocosSur\Fulltext\fulltxtdb.db"
        $db3bakup = "fulltxtdb.bak"
        $db3rar   = "fulltxtdb.rar"

        $db4      = "D:\Database\IlocosSur\Global\globaldb.db"
        $db4bakup = "globaldb.bak"
        $db4rar   = "globaldb.rar"

        $db5      = "D:\Database\IlocosSur\Legislative\legdb.db"
        $db5bakup = "legdb.bak"
        $db5rar   = "legdb.rar"

        $db6      = "D:\Database\IlocosSur\Search\searchdb.db"
        $db6bakup = "searchdb.bak"
        $db6rar   = "searchdb.rar"


        $db7      = "D:\Database\IlocosSur\SearchEngine\enginedb.db"
        $db7bakup = "enginedb.bak"
        $db7rar   = "enginedb.rar"

        $db8      = "D:\Database\IlocosSur\Temporary\tmpdb.db"
        $db8bakup = "tmpdb.bak"
        $db8rar   = "tmpdb.rar"
        
        $db9      = "D:\Database\IlocosSur\VideoFile\videodb.db"
        $db9bakup = "videodb.bak"
        $db9rar   = "videodb.rar"

        $db10      = "D:\Database\IlocosSur\Web\webdb.db"
        $db10bakup = "webdb.bak"
        $db10rar   = "webdb.rar"

        $db11      = ""
        $db11bakup = ""
        $db11rar   = ""

        $db12      = ""
        $db12bakup = ""
        $db12rar   = ""

        

        Write-Output "$(Get-TimeStamp) ------------------------" | Out-file C:\backuplog.txt -append
        Write-Output "$(Get-TimeStamp) started database backup " | Out-file C:\backuplog.txt -append
        
        if(Test-Path $db1  -PathType Leaf) { probkup online $db1   $BackupLocation\$db1bakup } else {}
        if(Test-Path $db2  -PathType Leaf) { probkup online $db2   $BackupLocation\$db2bakup } else {}     
        if(Test-Path $db3  -PathType Leaf) { probkup online $db3   $BackupLocation\$db3bakup } else {}
        if(Test-Path $db4  -PathType Leaf) { probkup online $db4   $BackupLocation\$db4bakup } else {} 
        if(Test-Path $db5  -PathType Leaf) { probkup online $db5   $BackupLocation\$db5bakup } else {}
        if(Test-Path $db6  -PathType Leaf) { probkup online $db6   $BackupLocation\$db6bakup } else {}
        if(Test-Path $db7  -PathType Leaf) { probkup online $db7   $BackupLocation\$db7bakup } else {}
        if(Test-Path $db8  -PathType Leaf) { probkup online $db8   $BackupLocation\$db8bakup } else {}
        if(Test-Path $db9  -PathType Leaf) { probkup online $db9   $BackupLocation\$db9bakup } else {}
        if(Test-Path $db10 -PathType Leaf) { probkup online $db10 $BackupLocation\$db10bakup } else {}
        if(Test-Path $db11 -PathType Leaf) { probkup online $db11 $BackupLocation\$db11bakup } else {}
        if(Test-Path $db12 -PathType Leaf) { probkup online $db12 $BackupLocation\$db12bakup } else {}


        Write-Output "$(Get-TimeStamp) done database backup " | Out-file C:\backuplog.txt -append

        #-------------------------------------------------------
        #
        #
        ## 3. Set the alias command for rar, in order the powershell
        # https://stackoverflow.com/questions/51388862/if-statement-on-path-variable-powershell-true-false-test

            $x64path = 'C:\Program Files\WinRAR\RAR.exe'

            if(Test-Path $x64path -PathType Leaf) { $winrarpath = $x64path } 
            else { $winrarpath = 'C:\Program Files (x86)\WinRAR\RAR.exe' }

                if(Test-Path $winrarpath -PathType Leaf)
                     { New-Alias rar $winrarpath -Force         
                       $RARfilesLocation = "E:\DB-Backup\rartemp"
                     if(!(Test-Path $RARfilesLocation)) {mkdir $RARfilesLocation -Force}
         
                         if(Test-Path $RARfilesLocation)
                             {


                             #
                             # Set the dotbak files here to compressed
                             #
                             if(Test-Path $BackupLocation\$db1bakup  -PathType Leaf) { rar a -m5 -ep $RARfilesLocation\$db1rar  $BackupLocation\$db1bakup }  else {}
                             if(Test-Path $BackupLocation\$db2bakup  -PathType Leaf) { rar a -m5 -ep $RARfilesLocation\$db2rar  $BackupLocation\$db2bakup }  else {}
                             if(Test-Path $BackupLocation\$db3bakup  -PathType Leaf) { rar a -m5 -ep $RARfilesLocation\$db3rar  $BackupLocation\$db3bakup }  else {}
                             if(Test-Path $BackupLocation\$db4bakup  -PathType Leaf) { rar a -m5 -ep $RARfilesLocation\$db4rar  $BackupLocation\$db4bakup }  else {}
                             if(Test-Path $BackupLocation\$db5bakup  -PathType Leaf) { rar a -m5 -ep $RARfilesLocation\$db5rar  $BackupLocation\$db5bakup }  else {}
                             if(Test-Path $BackupLocation\$db6bakup  -PathType Leaf) { rar a -m5 -ep $RARfilesLocation\$db6rar  $BackupLocation\$db6bakup }  else {}
                             if(Test-Path $BackupLocation\$db7bakup  -PathType Leaf) { rar a -m5 -ep $RARfilesLocation\$db7rar  $BackupLocation\$db7bakup }  else {}
                             if(Test-Path $BackupLocation\$db8bakup  -PathType Leaf) { rar a -m5 -ep $RARfilesLocation\$db8rar  $BackupLocation\$db8bakup }  else {}
                             if(Test-Path $BackupLocation\$db9bakup  -PathType Leaf) { rar a -m5 -ep $RARfilesLocation\$db9rar  $BackupLocation\$db9bakup }  else {}
                             if(Test-Path $BackupLocation\$db10bakup -PathType Leaf) { rar a -m5 -ep $RARfilesLocation\$db10rar $BackupLocation\$db10bakup } else {}
                             if(Test-Path $BackupLocation\$db11bakup -PathType Leaf) { rar a -m5 -ep $RARfilesLocation\$db11rar $BackupLocation\$db11bakup } else {}
                             if(Test-Path $BackupLocation\$db12bakup -PathType Leaf) { rar a -m5 -ep $RARfilesLocation\$db12rar $BackupLocation\$db12bakup } else {}
                             

                             Write-Output "$(Get-TimeStamp) create rar file for database backup " | Out-file C:\backuplog.txt -append

                             }
                         else{ 
                                write-host "rartemp folder can't be found!. Please check the correct path on your script"
                                Write-Output "$(Get-TimeStamp) rartemp folder can't be found!. Please check the correct path on your script " | Out-file C:\backuplog.txt -append
                             }
                     } 
                 else{
                        write-host "Winrar can't be found!. Please check the installation path"
                        Write-Output "$(Get-TimeStamp) Winrar can't be found!. Please check the installation path " | Out-file C:\backuplog.txt -append
                     }




        #-----------------------------------------------------
        #
        #
        ## 4. copy to External Drive [NAS] or to another remote server. Enable and then set the location of network folder
        # 
        # set the value to 'true' to enable and copy the backup to remote storage/server

            $enabled = 'false';

            if($enabled -eq $true) {

              #Write-Host -ForegroundColor GREEN "TRUE"

              $GetTheDateToDay = (Get-Date).ToString("MMMM dd,yyyy [hhtt]")

              $RemoteBackupLocation = "\\192.168.111.216\shared\test\"
              if (!(Test-Path $RemoteBackupLocation)) { mkdir $RemoteBackupLocation -Force}

                  if(Test-Path $RemoteBackupLocation)
                        {
                          $NetworkFolder = New-Item -ItemType Directory -Path "$RemoteBackupLocation" -Name ($GetTheDateToDay) -Force
                          if (!(Test-Path $NetworkFolder)) { mkdir $NetworkFolder -Force}

                             if($NetworkFolder){
                    
                                # copy each files define here
                                ###xcopy $RARfilesLocation\$db1rar $NetworkFolder /Y
                                #
                                #
                                #copy all the contents of the rartemp folder
                                #
                                #
                                xcopy $RARfilesLocation $NetworkFolder /Y
                                Write-Output "$(Get-TimeStamp) copied database backup to networkshared " | Out-file C:\backuplog.txt -append
                                }

                             else { write-host " The Remote Folder is not accessible. " 
                                   Write-Output "$(Get-TimeStamp) The Remote Folder is not accessible. " | Out-file C:\backuplog.txt -append
                                  }

                        } 

                   else { 
                          write-host " The RemoteBackupLocation Folder is not accessible. "
                          Write-Output "$(Get-TimeStamp) The RemoteBackupLocation Folder is not accessible. " | Out-file C:\backuplog.txt -append 
                        }


            } else { 
                     Write-Host -ForegroundColor RED   "Network backup is not enabled"
                     Write-Output "$(Get-TimeStamp) Network backup is not enabled. " | Out-file C:\backuplog.txt -append 
                     }

        #
        #
        #
        #
        #--------------------------------------------------
        #
        #
        ## 5. delete the temp folder for rar
        #
        #
        #
        Remove-Item -Path $RARfilesLocation\ -Force -Recurse -ErrorAction SilentlyContinue
        Write-Output "$(Get-TimeStamp) remove the temp rar file " | Out-file C:\backuplog.txt -append 
        Write-Output "$(Get-TimeStamp) ------------------------ " | Out-file C:\backuplog.txt -append        
    }


	
PowerShell -Command "Add-Type -AssemblyName PresentationFramework;[System.Windows.MessageBox]::Show('Database backup done! $(Get-TimeStamp)')"


#...end here 
#
#
# to create task scheduler, uncomment the four lines below, highlight them and press f8(Run Selection)
#
# $Trigger= New-ScheduledTaskTrigger -At 10:00am –Daily # Specify the trigger settings
# $User= "NT AUTHORITY\SYSTEM" # Specify the account to run the script
# $Action= New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "D:\IlocosSurBackupDB-1PM.ps1" # Specify what program to run and with its parameters
# Register-ScheduledTask -TaskName "BackupDB_1PM" -Trigger $Trigger -User $User -Action $Action -RunLevel Highest –Force # Specify the name of the task
#
#
#
# $Trigger= New-ScheduledTaskTrigger -At 4:00pm –Daily # Specify the trigger settings
# $User= "NT AUTHORITY\SYSTEM" # Specify the account to run the script
# $Action= New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "D:\IlocosSurBackupDB-4PM.ps1" # Specify what program to run and with its parameters
# Register-ScheduledTask -TaskName "BackupDB_4PM" -Trigger $Trigger -User $User -Action $Action -RunLevel Highest –Force # Specify the name of the task