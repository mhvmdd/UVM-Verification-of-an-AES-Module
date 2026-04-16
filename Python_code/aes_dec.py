from Crypto.Cipher import AES

with open('key.txt', 'r') as file:
    data_hex = file.readline().strip()  # Read the ciphertext hex string
    key_hex = file.readline().strip()  # Read the key hex string

data = bytes.fromhex(data_hex)
key = bytes.fromhex(key_hex)

cipher = AES.new(key, AES.MODE_ECB)

# Decrypt without unpadding
plaintext = cipher.decrypt(data)

with open('output.txt', 'w') as file:
    file.write(plaintext.hex())
