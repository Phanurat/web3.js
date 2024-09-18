const contractAddress = '0xBaC6582C82D278557309377A7eb8e48A282bd959'; // Replace with your contract address
const contractABI = [
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "answer",
                "type": "uint256"
            }
        ],
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
        "name": "generateMathQuestion",
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
        "inputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "name": "questionResult",
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
let currentQuestion;

window.onload = async () => {
    if (typeof window.ethereum !== 'undefined') {
        web3 = new Web3(window.ethereum);
        contract = new web3.eth.Contract(contractABI, contractAddress);

        document.getElementById('connectButton').addEventListener('click', async () => {
            try {
                await window.ethereum.request({ method: 'eth_requestAccounts' });
                document.getElementById('generateQuestionButton').style.display = 'block';
                document.getElementById('status').innerText = 'Connected to MetaMask';
            } catch (error) {
                document.getElementById('status').innerText = 'User denied account access or MetaMask issue';
                console.error('Error connecting MetaMask:', error);
            }
        });

        document.getElementById('generateQuestionButton').addEventListener('click', async () => {
			try {
				const accounts = await web3.eth.getAccounts();
				const account = accounts[0];
				console.log('Generating math question for account:', account);
		
				// Call generateMathQuestion
				await contract.methods.generateMathQuestion().send({ from: account });
				console.log('Math question generated successfully.');
		
				// Fetch the current question
				const question = await contract.methods.questionResult().call();
				console.log('Math question result:', question);
				
				document.getElementById('mathQuestion').innerText = `Solve: ${question}`;
				document.getElementById('userAnswer').style.display = 'block';
				document.getElementById('claimButton').style.display = 'block';
				document.getElementById('status').innerText = 'Math question generated. Please solve it!';
			} catch (error) {
				document.getElementById('status').innerText = 'Error generating question';
				console.error('Error generating question:', error);
			}
		});			

        document.getElementById('claimButton').addEventListener('click', async () => {
            const userAnswer = document.getElementById('userAnswer').value;
            if (!userAnswer) {
                document.getElementById('status').innerText = 'Please enter your answer';
                return;
            }

            try {
                const accounts = await web3.eth.getAccounts();
                const account = accounts[0];

                // Check if the user has already claimed tokens
                const hasClaimed = await contract.methods.hasClaimed(account).call();
                if (hasClaimed) {
                    document.getElementById('status').innerText = 'You have already claimed your tokens.';
                    return;
                }

                // Attempt to claim tokens
                const gasEstimate = await contract.methods.claimTokens(userAnswer).estimateGas({ from: account });
                await contract.methods.claimTokens(userAnswer).send({ from: account, gas: gasEstimate });

                document.getElementById('status').innerText = 'Tokens claimed successfully!';
            } catch (error) {
                document.getElementById('status').innerText = 'Error claiming tokens. Please check your answer and try again.';
                console.error('Error claiming tokens:', error);
            }
        });
    } else {
        document.getElementById('status').innerText = 'Please install MetaMask!';
    }
};
