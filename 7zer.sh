#!/bin/bash
echo v 0.2
# Bash script to compress directories and files in the current folder with specific naming
# Excludes files or folders starting with "#" or "@"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if 7z is installed and install it if not
check_install_7z() {
    if ! command -v 7z &> /dev/null; then
        echo -e "${YELLOW}7z is not installed. Installing 7z...${NC}"
        sudo apt-get update && sudo apt-get install -y p7zip-full
    else
        echo -e "${GREEN}7z is already installed.${NC}"
    fi
}

# Function to compress and validate
compress_validate() {
    local item=$1
    local output_name

    # Determine if item is a file or a directory and set output name accordingly
    if [ -d "$item" ]; then
        output_name="${item%/}.FOLDER.7z"
    elif [ -f "$item" ]; then
        output_name="${item}.FILE.7z"
    else
        echo -e "${YELLOW}Skipping: $item is neither a file nor a directory.${NC}"
        return
    fi

    echo -e "${YELLOW}Compressing: $item${NC}"
    # Compress the item
    7z a -mx1 "$output_name" "$item" > /dev/null

    # Check if the last command was successful
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Compression successful: $output_name${NC}"

        # Test the integrity of the created archive
        if 7z t "$output_name" > /dev/null; then
            echo -e "${GREEN}Archive integrity verified. Deleting original item: $item${NC}"
            rm -rf "$item"
        else
            echo -e "${RED}Archive integrity test failed. Keeping the original item: $item${NC}"
        fi
    else
        echo -e "${RED}Compression failed for item: $item${NC}"
    fi
}

# Check and install 7z if needed
check_install_7z

# Loop over items in the current folder
for item in *; do
    # Skip items starting with '#' or '@'
    if [[ $item == \#* ]] || [[ $item == @* ]]; then
        echo -e "${YELLOW}Skipping excluded item: $item${NC}"
        continue
    fi
    compress_validate "$item"
done

echo -e "${GREEN}Operation completed.${NC}"














exit
#!/bin/bash

# Bash script to compress directories and files in the current folder with specific naming

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if 7z is installed and install it if not
check_install_7z() {
    if ! command -v 7z &> /dev/null; then
        echo -e "${YELLOW}7z is not installed. Installing 7z...${NC}"
        sudo apt-get update && sudo apt-get install -y p7zip-full
    else
        echo -e "${GREEN}7z is already installed.${NC}"
    fi
}

# Function to compress and validate
compress_validate() {
    local item=$1
    local output_name

    # Determine if item is a file or a directory and set output name accordingly
    if [ -d "$item" ]; then
        output_name="${item%/}.FOLDER.7z"
    elif [ -f "$item" ]; then
        output_name="${item}.FILE.7z"
    else
        echo -e "${YELLOW}Skipping: $item is neither a file nor a directory.${NC}"
        return
    fi

    echo -e "${YELLOW}Compressing: $item${NC}"
    # Compress the item
    7z a -mx1 "$output_name" "$item" > /dev/null

    # Check if the last command was successful
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Compression successful: $output_name${NC}"

        # Test the integrity of the created archive
        if 7z t "$output_name" > /dev/null; then
            echo -e "${GREEN}Archive integrity verified. Deleting original item: $item${NC}"
            rm -rf "$item"
        else
            echo -e "${RED}Archive integrity test failed. Keeping the original item: $item${NC}"
        fi
    else
        echo -e "${RED}Compression failed for item: $item${NC}"
    fi
}

# Check and install 7z if needed
check_install_7z

# Loop over items in the current folder
for item in *; do
    compress_validate "$item"
done

echo -e "${GREEN}Operation completed.${NC}"






exit
#!/bin/bash

# Bash script to compress directories and files in the current folder

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if 7z is installed and install it if not
check_install_7z() {
    if ! command -v 7z &> /dev/null; then
        echo -e "${YELLOW}7z is not installed. Installing 7z...${NC}"
        sudo apt-get update && sudo apt-get install -y p7zip-full
    else
        echo -e "${GREEN}7z is already installed.${NC}"
    fi
}

# Function to compress and validate
compress_validate() {
    local item=$1
    local output_name="${item%/}.7z"

    echo -e "${YELLOW}Compressing: $item${NC}"
    # Compress the item (directory or file)
    7z a -mx1 "$output_name" "$item" > /dev/null

    # Check if the last command was successful
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Compression successful: $output_name${NC}"

        # Test the integrity of the created archive
        if 7z t "$output_name" > /dev/null; then
            echo -e "${GREEN}Archive integrity verified. Deleting original item: $item${NC}"
            rm -rf "$item"
        else
            echo -e "${RED}Archive integrity test failed. Keeping the original item: $item${NC}"
        fi
    else
        echo -e "${RED}Compression failed for item: $item${NC}"
    fi
}

# Check and install 7z if needed
check_install_7z

# Loop over items in the current folder
for item in *; do
    # Skip if it's not a directory or file
    if [ ! -d "$item" ] && [ ! -f "$item" ]; then
        continue
    fi

    compress_validate "$item"
done

echo -e "${GREEN}Operation completed.${NC}"







exit
#!/bin/bash

# Bash script to compress directories and files in the current folder

# Function to check if 7z is installed and install it if not
check_install_7z() {
    if ! command -v 7z &> /dev/null; then
        echo "7z could not be found, attempting to install..."
        sudo apt-get update && sudo apt-get install -y p7zip-full
    fi
}

# Function to compress and validate
compress_validate() {
    local item=$1
    local output_name="${item%/}.7z"

    # Compress the item (directory or file)
    7z a -mx1 "$output_name" "$item"

    # Check if the last command was successful
    if [ $? -eq 0 ]; then
        echo "Compression successful: $output_name"

        # Test the integrity of the created archive
        7z t "$output_name"

        # If the test is successful, delete the original item
        if [ $? -eq 0 ]; then
            echo "Archive integrity verified. Deleting original item: $item"
            rm -rf "$item"
        else
            echo "Archive integrity test failed. Keeping the original item: $item"
        fi
    else
        echo "Compression failed for item: $item"
    fi
}

# Check and install 7z if needed
check_install_7z

# Loop over items in the current folder
for item in *; do
    # Skip if it's not a directory or file
    if [ ! -d "$item" ] && [ ! -f "$item" ]; then
        continue
    fi

    compress_validate "$item"
done

echo "Operation completed."
