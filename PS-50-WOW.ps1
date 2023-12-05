# ----- Edit these Variables for your own Use Case ----- #
$PASSWORD_FOR_USERS = "Password1"
$NUMBER_OF_ACCOUNTS_TO_CREATE = 50  # Changed to 50 users
$WOW_LORE_CHARACTERS = @(
    "Malfurion Stormrage", "Sylvanas Windrunner", "Thrall", "Jaina Proudmoore", "Illidan Stormrage",
    "Tyrande Whisperwind", "Arthas Menethil", "Anduin Wrynn", "Garrosh Hellscream", "Varian Wrynn",
    "Grommash Hellscream", "Cairne Bloodhoof", "Velen", "Maiev Shadowsong", "Rexxar", "Gul'dan",
    "Kael'thas Sunstrider", "Genn Greymane", "Vol'jin", "Lady Vashj", "Cenarius", "Chen Stormstout",
    "Khadgar", "Grommash Hellscream", "Sargeras", "Kil'jaeden", "Ner'zhul", "Medivh", "Ysera", "Nozdormu",
    "Alexstrasza", "Deathwing", "Garona Halforcen", "Cho'gall", "Anub'arak", "Uther the Lightbringer",
    "Tirion Fordring", "Saurfang", "Baine Bloodhoof", "Saurfang", "Aegwynn", "Bolvar Fordragon", "Vereesa Windrunner",
    "Ragnaros", "Onyxia", "Nefarian", "Malygos", "C'thun", "Yogg-Saron", "Algalon the Observer", "Lich King"
)
$AD_ROOT_PATH = "DC=jagilmor,DC=com"
$WOW_FOLDER_NAME = "_WOW"  # Updated OU name to "_WOW"
# ------------------------------------------------------ #

# Create the WoW OU if it doesn't exist
$wowOU = Get-ADOrganizationalUnit -Filter {Name -eq $WOW_FOLDER_NAME} -SearchBase $AD_ROOT_PATH

if ($wowOU -eq $null) {
    New-ADOrganizationalUnit -Name $WOW_FOLDER_NAME -Path $AD_ROOT_PATH
}

$count = 1
while ($count -le $NUMBER_OF_ACCOUNTS_TO_CREATE) {
    $characterName = $WOW_LORE_CHARACTERS[$(Get-Random -Minimum 0 -Maximum $WOW_LORE_CHARACTERS.Count)]
    $email = ($characterName -replace " ", "").ToLower() + "@jagilmor.com"
    $username = $characterName.Replace(" ", "").ToLower()
    $password = ConvertTo-SecureString $PASSWORD_FOR_USERS -AsPlainText -Force
    $description = "From World of Warcraft lore"

    Write-Host "Creating user: $($username)" -BackgroundColor Black -ForegroundColor Cyan
    
    New-AdUser -AccountPassword $password `
               -DisplayName $characterName `
               -Name $username `
               -EmailAddress $email `
               -PasswordNeverExpires $true `
               -Description $description `
               -Path "OU=$WOW_FOLDER_NAME,$AD_ROOT_PATH" `
               -Enabled $true
    $count++
}
