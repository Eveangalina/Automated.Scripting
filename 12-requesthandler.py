import requests

def translate_status_code(code):
    try:
        return requests.status_codes._codes[code][0]
    except KeyError:
        return 'Unknown Status'

def main():
    destination_url = input("Enter the destination URL: ")
    http_method = input("Choose a HTTP Method (GET, POST, PUT, DELETE, HEAD, PATCH, OPTIONS): ").upper()

    if http_method not in ['GET', 'POST', 'PUT', 'DELETE', 'HEAD', 'PATCH', 'OPTIONS']:
        print("Invalid HTTP Method!")
        return

    print(f"Request about to be sent: {http_method} request to {destination_url}")
    confirmation = input("Do you want to proceed? (yes/no): ")

    if confirmation.lower() != 'yes':
        print("Request aborted.")
        return

    try:
        response = requests.request(http_method, destination_url)
        print(f"Status Code: {response.status_code} - {translate_status_code(response.status_code)}")
        print("Response Headers:")
        for header, value in response.headers.items():
            print(f"{header}: {value}")
    except requests.RequestException as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()
# Resources [ChatGPT] (https://chat.openai.com/share/e44a6076-0873-4a0b-a783-eb5ca00b516b)
