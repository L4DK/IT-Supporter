<#
.SYNOPSIS
    Random Password Generator by L4ndbo.
    This script generates strong and random passwords of a specified length, ensuring the inclusion of uppercase letters, lowercase letters, numbers, and symbols. The generated passwords are designed for enhanced security and can be used for various applications, including authentication and access control.

.DESCRIPTION
    The Random Password Generator script utilizes predefined character sets to create passwords, and it checks to ensure that all specified character sets are used in the generated password. The script aims to provide secure and diverse passwords for users' needs.

.NOTES
    Script Name      : RandomPasswordGenerator.ps1
    Author           : Michael Landbo
    Nickname         : L4ndbo or L4
    Prerequisites    : None
    Date Created     : January 27, 2024
    Last Edit        : January 27, 2024
    Version          : 1.0.0
    PowerShell       : 5.1
    Contact          : dev@l4ndbo.com

    Change History:
    - Version 1.0.0 (January 27, 2024)
        - Initial release
#>

# Password Length
$Length = 12

# Define Character Sets
$UpperCase = @('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z')
$LowerCase = @('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z')
$Numbers = @('1', '2', '3', '4', '5', '6', '7', '8', '9', '0')
$Symbols = @('!', '@', '$', '?', '<', '>', '*', '&')
$FullSet = @('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '!', '@', '$', '?', '<', '>', '*', '&')

# Check to see if all character sets are used
$HasUpperCase = 0
$HasLowerCase = 0
$HasNumbers = 0
$HasSymbols = 0

While ($HasUpperCase -eq 0 -or $HasLowerCase -eq 0 -or $HasNumbers -eq 0 -or $HasSymbols -eq 0) {
    # Generate New Password
    $PasswordArray = $FullSet | Get-Random -Count $Length
    $Password = $PasswordArray[0..($Length - 1)] -join ''

    # Test the password that has been created
    For ($Index = 0; $Index -lt $Length; $Index++) {
        $Character = $Password.Substring($Index, 1)
        If ($Character -in $UpperCase) { $HasUpperCase = 1 }
        If ($Character -in $LowerCase) { $HasLowerCase = 1 }
        If ($Character -in $Numbers) { $HasNumbers = 1 }
        If ($Character -in $Symbols) { $HasSymbols = 1 }
    }
}

# Display Password
Write-Host "The new password is: " $Password
# Display Password length
Write-Host "Password length is: " $Length
# Insert the generated password string into the Windows clipboard
Set-Clipboard -Value $Password
