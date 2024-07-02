Here's a sample README.md file for the `create_users.sh` script:

# User Management Script

This Bash script, `create_users.sh`, automates the process of creating new user accounts and managing user groups for a system. It reads a text file containing the employee's usernames and group names, and then performs the necessary actions to set up the user accounts.

## Features

- Creates users and their personal groups (with the same name as the username)
- Adds users to the specified groups
- Generates random passwords for each user
- Logs all actions to `/var/log/user_management.log`
- Securely stores the generated passwords in `/var/secure/user_passwords.txt`
- Handles errors, such as existing users
- Provides clear documentation and comments within the script

## Usage

1. Save the `create_users.sh` script to a directory of your choice.
2. Ensure the script has executable permissions:
   ```
   chmod +x create_users.sh
   ```
3. Create a text file with the employee usernames and group names, following the format:
   ```
   user1;group1,group2
   user2;group3,group4
   ```
4. Run the script, passing the name of the text file as an argument:
   ```
   ./create_users.sh employee_users.txt
   ```

The script will create the users and groups, set up their home directories, generate random passwords, and log all actions. The generated passwords will be stored in the `/var/secure/user_passwords.txt` file.

## Requirements

- Bash shell
- `openssl` command-line tool (for generating random passwords)

## Technical Details

The script performs the following steps:

1. Checks if the script is run with the correct argument (the name of the text file).
2. Verifies the existence of the text file.
3. Creates the log file `/var/log/user_management.log` if it doesn't exist, and sets the appropriate permissions and ownership.
4. Creates the secure password file `/var/secure/user_passwords.txt` if it doesn't exist, and sets the appropriate permissions and ownership.
5. Iterates through the text file, line by line, and performs the following actions for each user:
   - Creates the user's personal group.
   - Creates the user with the personal group as the primary group.
   - Adds the user to the specified groups.
   - Generates a random password for the user.
   - Sets the user's password.
   - Logs the user creation with the password.
   - Stores the user's password in the secure file.
6. Displays a completion message with the locations of the log and password files.

## Contribution

If you find any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request on the [GitHub repository](https://github.com/your-username/create-users-script).

## HNG Internship

This script was developed as part of the HNG Internship program. To learn more about the HNG Internship, visit the following links:

- [HNG Internship](https://hng.tech/internship)
- [HNG Hire](https://hng.tech/hire)
- [HNG Premium](https://hng.tech/premium)
