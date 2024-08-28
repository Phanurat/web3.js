const Web3 = require('web3');

// เชื่อมต่อกับ BNB Testnet URL
const web3 = new Web3('https://data-seed-prebsc-1-s1.binance.org:8545/');

// ที่อยู่ที่ต้องการตรวจสอบยอดเงิน
const address = '0x7007bb372140F253fb6279471918ECe999DDb37b';

// ฟังก์ชันในการตรวจสอบยอดเงิน
async function checkBalance() {
    try {
        // ตรวจสอบยอดเงิน
        const balance = await web3.eth.getBalance(address);
        console.log('Account balance:', web3.utils.fromWei(balance, 'ether'), 'BNB');
    } catch (error) {
        console.error('Error checking balance:', error);
    }
}

// เรียกใช้ฟังก์ชันตรวจสอบยอดเงิน
checkBalance();
