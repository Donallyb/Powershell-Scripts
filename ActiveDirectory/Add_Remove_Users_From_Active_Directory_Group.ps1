Import-Module ActiveDirectory
$groupname = "<Enter Name of AD Group Here>" 
#Searches through the AD Domain and passes users into the $users varible
$users = Get-ADUser -Filter * -SearchBase "OU=<yourOU>,DC=<yourADdomain>,DC=com"
#Optional add the following <| ? {$_.DistinguishedName -notlike "*OU=<yoursubOU>,OU=<yourOU>,DC=<yourdomain>,DC=com"}>
#to end of the above line if there is Sub OU that contains users or service accounts that you want to exclude

#Adding users to the AD Group
foreach($user in $users)
{
  Add-ADGroupMember -Identity $groupname -Members $user.samaccountname -ErrorAction SilentlyContinue
}
#Removes any users that have been offboarded or moved to an OU that is not in the 
#-SearchBase "OU=<yourOU>,DC=<yourdomain>,DC=com" since this script last ran
$members = Get-ADGroupMember -Identity $groupname
foreach($member in $members)
{
  if($member.distinguishedname -notlike "*OU=<yourOU>,DC=<yourdomain>,DC=com*") 
  {
    Remove-ADGroupMember -Identity $groupname -Members $member.samaccountname -Confirm:$false
  }
}