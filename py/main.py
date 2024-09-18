from web3 import Web3

# เชื่อมต่อกับ BSC Testnet
bsc_testnet_url = 'https://data-seed-prebsc-1-s1.binance.org:8545/'
web3 = Web3(Web3.HTTPProvider(bsc_testnet_url))

# ตรวจสอบการเชื่อมต่อ
if web3.isConnected():
    print("เชื่อมต่อกับ BSC Testnet สำเร็จ")
else:
    print("ไม่สามารถเชื่อมต่อกับ BSC Testnet")