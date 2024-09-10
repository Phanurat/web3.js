const contractAddress = "0xCbc3E65d8392Ad8E8afe5113B03829454A265544";
const contractABI = [
    {
        "inputs": [],
        "name": "claimTokens",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "amount",
                "type": "uint256"
            }
        ],
        "name": "fundContract",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "stateMutability": "nonpayable",
        "type": "constructor"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "name": "balanceOf",
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
        "name": "claimAmount",
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
        "name": "decimals",
        "outputs": [
            {
                "internalType": "uint8",
                "name": "",
                "type": "uint8"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "name": "hasClaimed",
        "outputs": [
            {
                "internalType": "bool",
                "name": "",
                "type": "bool"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "name",
        "outputs": [
            {
                "internalType": "string",
                "name": "",
                "type": "string"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "symbol",
        "outputs": [
            {
                "internalType": "string",
                "name": "",
                "type": "string"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "totalSupply",
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

let web3;
let contract;

window.onload = () => {
    if (typeof window.ethereum !== 'undefined') {
        web3 = new Web3(window.ethereum);
        contract = new web3.eth.Contract(contractABI, contractAddress);

        document.getElementById('connectButton').addEventListener('click', async () => {
            try {
                await window.ethereum.request({ method: 'eth_requestAccounts' });
                document.getElementById('claimButton').style.display = 'block';
                document.getElementById('status').innerText = 'Connected to MetaMask';
            } catch (error) {
                document.getElementById('status').innerText = `Error connecting MetaMask: ${error.message}`;
                console.error("Error connecting MetaMask:", error);
            }
        });

        document.getElementById('claimButton').addEventListener('click', async () => {
            const accounts = await web3.eth.getAccounts();
            const account = accounts[0];

            try {
                console.log("Attempting to claim tokens...");
                const gasEstimate = await contract.methods.claimTokens().estimateGas({ from: account });
                console.log("Estimated gas:", gasEstimate);
                await contract.methods.claimTokens().send({ from: account, gas: gasEstimate });
                document.getElementById('status').innerText = 'Tokens claimed successfully!';
            } catch (error) {
                console.error("Error claiming tokens:", error);
                document.getElementById('status').innerText = `Error claiming tokens. Please try again. Error: ${error.message}`;
            }
        });
    } else {
        document.getElementById('status').innerText = 'Please install MetaMask!';
    }
}
