import arweave

wallet_file_path = "/some/folder/on/your/system"
wallet = arweave.Wallet(wallet_file_path)

balance = wallet.balance

last_transaction = wallet.get_last_transaction_id()
