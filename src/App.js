import React, { useState, useEffect } from 'react';
import { ethers } from 'ethers';
import CoffeeSupplyChain from './artifacts/contracts/CoffeeSupplyChain.sol/CoffeeSupplyChain.json';

const contractAddress = "your-contract-address-here";

function App() {
  const [lotId, setLotId] = useState('');
  const [lotData, setLotData] = useState(null);
  const [step, setStep] = useState('');
  const [provider, setProvider] = useState(null);
  const [contract, setContract] = useState(null);
  const [account, setAccount] = useState('');

  useEffect(() => {
    const loadBlockchainData = async () => {
      if (window.ethereum) {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        setProvider(provider);

        const network = await provider.getNetwork();
        const contract = new ethers.Contract(contractAddress, CoffeeSupplyChain.abi, provider.getSigner());
        setContract(contract);

        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
        setAccount(accounts[0]);
      }
    };

    loadBlockchainData();
  }, []);

  const handleCreateLot = async () => {
    if (contract) {
      await contract.createLot();
      alert("Lote creado exitosamente!");
    }
  };

  const handleAddStep = async () => {
    if (contract && lotId) {
      await contract.addStep(lotId, step);
      alert("Paso agregado exitosamente!");
    }
  };

  const handleGetLot = async () => {
    if (contract && lotId) {
      const lot = await contract.getLot(lotId);
      setLotData(lot);
    }
  };

  return (
    <div>
      <h1>Coffee Supply Chain</h1>
      <button onClick={handleCreateLot}>Crear Lote</button>
      <div>
        <input
          type="text"
          placeholder="ID del Lote"
          value={lotId}
          onChange={(e) => setLotId(e.target.value)}
        />
        <input
          type="text"
          placeholder="Paso"
          value={step}
          onChange={(e) => setStep(e.target.value)}
        />
        <button onClick={handleAddStep}>Agregar Paso</button>
        <button onClick={handleGetLot}>Consultar Lote</button>
      </div>
      {lotData && (
        <div>
          <h2>Lote ID: {lotData.id.toString()}</h2>
          <ul>
            {lotData.steps.map((step, index) => (
              <li key={index}>
                {step} - {new Date(lotData.timestamps[index] * 1000).toLocaleString()}
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}

export default App;