#!/bin/bash

# Function to log actions
log_action() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> /var/log/user_management.log
}

# Check if script is run with the correct argument
if [ -z "$1" ]; then
    echo "Usage: $0 <name-of-text-file>"
    exit 1
fi

# Check if the text file exists
if [ ! -f "$1" ]; then
    echo "Error: File '$1' does not exist."
    exit 1
fi

# Create the log file if it doesn't exist
if [ ! -f "/var/log/user_management.log" ]; then
    touch /var/log/user_management.log
    chmod 640 /var/log/user_management.log
    chown root:adm /var/log/user_management.log
fi

# Create the secure password file if it doesn't exist
if [ ! -f "/var/secure/user_passwords.txt" ]; then
    mkdir -p /var/secure
    touch /var/secure/user_passwords.txt
    chmod 600 /var/secure/user_passwords.txt
    chown root:root /var/secure/user_passwords.txt
fi

# Iterate through the text file and create users and groups
while IFS=';' read -r username groups; do
    # Trim leading/trailing whitespace
    username=$(echo "$username" | xargs)
    groups=$(echo "$groups" | xargs)

    # Create the user's personal group
    groupadd "$username"

    # Create the user with the personal group as the primary group
    useradd -m -g "$username" "$username"

    # Add the user to the specified groups
    for group in $(echo "$groups" | tr ',' ' '); do
        usermod -a -G "$group" "$username"
    done

    # Generate a random password
    password=$(openssl rand -base64 12)

    # Set the user's password
    echo "$username:$password" | chpasswd

    # Log the user creation
    log_action "Created user '$username' with password '$password' and groups '$groups'"

    # Store the password in the secure file
    echo "$username,$password" >> /var/secure/user_passwords.txt
done < "$1"

echo "User creation completed. Logs available at /var/log/user_management.log"
echo "Passwords stored in /var/secure/user_passwords.txt"

