$UserName = 'healthshare\somebody'

$Password = '*passwordgoeshere*'

Function Test-ADAuthentication {

    param(

        $username,

        $password)

   

    (New-Object DirectoryServices.DirectoryEntry "",$username,$password).psbase.name -ne $null

}

Test-ADAuthentication -username $UserName -password $password
