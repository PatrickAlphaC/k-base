import siaskynet as skynet

# create a client
client = skynet.SkynetClient()

# upload
skylink = client.upload_file("./test.json")
print("Upload successful, skylink: " + skylink)

# download
client.download_file("./test.json", skylink)
print("Download successful")
