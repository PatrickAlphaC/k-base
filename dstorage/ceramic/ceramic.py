import requests
CERAMIC_HOST = 'http://localhost:7007'
API_PATH_2 = '/api/v0/documents/{}'
response = requests.get(CERAMIC_HOST + API_PATH_2.format(
    'kjzl6cwe1jw147gy52pk06hv9l4gqfmimr1vonhfxodki974akunjq17p16hbjx'))
print(response.json())
