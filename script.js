const Web3 = require('web3');

// ใช้ BNB Testnet URL
const web3 = new Web3('https://data-seed-prebsc-1-s1.binance.org:8545/');

// ABI ของสัญญา
const abi = [
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "x",
                "type": "uint256"
            }
        ],
        "name": "set",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "get",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "storedData",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    }
];

// ที่อยู่ของสัญญาที่ถูกดีพลอย
const contractAddress = '0xa8fdcdb59ef052e2de4b06d423fbe3fa9b8b7082';
const contract = new web3.eth.Contract(abi, contractAddress);

// Private Key ของคุณ
const privateKey = '0x16a20ed2bd1c51e4dba8bcf0c9c40c83bd97f366877b05d91b820e62ed3d3a0b';

// สร้างบัญชีจาก private key
const account = web3.eth.accounts.privateKeyToAccount(privateKey);
web3.eth.accounts.wallet.add(account);

// ฟังก์ชันในการตั้งค่า
async function setValue() {
    try {
        // ตรวจสอบยอดเงินก่อน
        await checkBalance();
        
        const result = await contract.methods.set(555).send({
            from: account.address,
            gas: 22000, // ปรับค่าก๊าซให้เพียงพอ
            gasPrice: web3.utils.toWei('5', 'gwei') // ปรับค่าค่าก๊าซตามที่ใช้ในเครือข่าย
        });
        console.log('Value set successfully!');
        console.log('Transaction hash:', result.transactionHash);
    } catch (error) {
        console.error('Error setting value:', error);
    }
}

// ฟังก์ชันในการดึงค่า
async function getValue() {
    try {
        const value = await contract.methods.get().call();
        console.log('Stored value is:', value);
    } catch (error) {
        console.error('Error getting value:', error);
    }
}

// ตรวจสอบยอดเงิน
async function checkBalance() {
    try {
        const balance = await web3.eth.getBalance(account.address);
        console.log('Account balance:', web3.utils.fromWei(balance, 'ether'), 'BNB');
    } catch (error) {
        console.error('Error checking balance:', error);
    }
}

// เรียกใช้ฟังก์ชัน
setValue().then(() => getValue());
