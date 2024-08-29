// app.js

window.addEventListener('load', async () => {
    // ตรวจสอบว่า MetaMask หรือ Web3 provider ถูกติดตั้ง
    if (window.ethereum) {
        const web3 = new Web3(window.ethereum);
        await window.ethereum.request({ method: 'eth_requestAccounts' });

        const contractAddress = 'YOUR_CONTRACT_ADDRESS';
        const contractABI = [/* ABI ของ Smart Contract ของคุณ */];
        const contract = new web3.eth.Contract(contractABI, contractAddress);

        document.getElementById('deduct-button').addEventListener('click', async () => {
            const accounts = await web3.eth.getAccounts();
            const fromAddress = accounts[0];
            const amount = web3.utils.toWei('1', 'ether'); // จำนวนเหรียญที่ต้องการหัก

            try {
                await contract.methods.deductTokens(fromAddress, amount).send({ from: fromAddress });
                alert('Tokens deducted successfully!');
            } catch (error) {
                console.error('Error deducting tokens:', error);
                alert('Error deducting tokens.');
            }
        });
    } else {
        alert('Please install MetaMask or another Web3 provider.');
    }
});
