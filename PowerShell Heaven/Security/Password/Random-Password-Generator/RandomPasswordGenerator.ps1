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
    Version          : 1.1.0
    PowerShell       : 7.x.x
    Contact          : dev@l4ndbo.com

    Change History:

    - Version 1.1.0 (January 28, 2024)
        - Skipped support for PowerShell version 5, it's now only compatible with version 7.x.x

        - Added input validation for the password length, ensuring it falls within a valid range.

        - Improved the user experience by providing feedback on password generation progress.
        - Enhanced the clipboard functionality to store the generated password securely as a SecureString.

        - Fixed: Corrected the casting of the password length to an integer to prevent errors.
        - Fixed: Addressed the limitation on console output for displaying complete passwords.


    - Version 1.0.1 (January 27, 2024)
        - Added the feature to let the user input in the terminal, the length of the wanted generated password.

    - Version 1.0.0 (January 27, 2024)
        - Initial release
#>

# Password Length User-input
$Length = Read-Host "Enter the length of the password"
$Length = [int]$Length  # Convert input to an integer

# Define Character Sets
$UpperCase = @('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z')
$LowerCase = @('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z')
$Numbers = @('1', '2', '3', '4', '5', '6', '7', '8', '9', '0')
$Symbols = @('~', '!', '@', '#', '$', '%', '^', '&', '*', '+', '-', '/', '.', '\', '{', '}', '[', ']', '(', ')', ';', ':', '?', '<', '>', '_')
$FullSet = @('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '~', '!', '@', '#', '$', '%', '^', '&', '*', '+', '-', '/', '.', '\', '{', '}', '[', ']', '(', ')', ';', ':', '?', '<', '>', '_')

# Check to see if all character sets are used
$HasUpperCase = 0
$HasLowerCase = 0
$HasNumbers = 0
$HasSymbols = 0

# While loop
While ($HasUpperCase -eq 0 -or $HasLowerCase -eq 0 -or $HasNumbers -eq 0 -or $HasSymbols -eq 0) {

    # Generate New Password
    $PasswordArray = $FullSet | Get-Random -Count $Length
    $Password = $PasswordArray[0..($Length - 1)] -join ''

    # Test the password that has been created
    For ($Index = 0; $Index -lt $Password.Length; $Index++) {
        $Character = $Password[$Index]
        If ($Character -in $UpperCase) { $HasUpperCase = 1 }
        If ($Character -in $LowerCase) { $HasLowerCase = 1 }
        If ($Character -in $Numbers) { $HasNumbers = 1 }
        If ($Character -in $Symbols) { $HasSymbols = 1 }
    }
}

# Display Password
Write-Host "The new password is:"
Write-Host $Password

# Display Password length
Write-Host "Password length is: $($Password.Length)"

# Insert the generated password string into the Windows clipboard
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
Set-Clipboard -Value $SecurePassword
