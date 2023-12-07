import os

def generate_directory_structure(user_path):
    output = ""
    for (root, dirs, files) in os.walk(user_path):
        output += f"==root==\n{root}\n==dirs==\n{dirs}\n==files==\n{files}\n\n"

    # Save output as a .txt file
    with open('directory_structure_output.txt', 'w') as file:
        file.write(output)

    # Open the .txt file with LibreOffice Writer
    os.system('libreoffice --writer directory_structure_output.txt')

def create_test_directory():
    user_input = input("Enter a string to create a test directory: ")
    directory_name = user_input.strip()  # Remove extra spaces
    os.makedirs(directory_name)
    for i in range(1, 4):
        os.makedirs(f"{directory_name}/string_0{i}")

def main():
    user_input_path = input("Enter a directory path: ")
    generate_directory_structure(user_input_path)

    # Optional: Creating a test directory
    create_test_directory()

if __name__ == "__main__":
    main()
