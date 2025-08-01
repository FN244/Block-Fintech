import React, { useEffect, useState } from "react";
import { ethers } from "ethers";
import CrowdfundingABI from "./CrowdfundingABI.json";

const CF_ADDRESS = "<YOUR_CROWDFUNDING_CONTRACT_ADDRESS>";

function App() {
  const [projects, setProjects] = useState([]);
  const [goal, setGoal] = useState("");
  const [duration, setDuration] = useState("");
  const [name, setName] = useState("");
  const [symbol, setSymbol] = useState("");
  const [provider, setProvider] = useState(null);
  const [signer, setSigner] = useState(null);
  const [contract, setContract] = useState(null);

  useEffect(() => {
    if (window.ethereum) {
      const _provider = new ethers.BrowserProvider(window.ethereum);
      setProvider(_provider);
      _provider.getSigner().then(setSigner);
      setContract(new ethers.Contract(CF_ADDRESS, CrowdfundingABI, _provider));
    }
  }, []);

  const createProject = async () => {
    await contract.connect(signer).createProject(
      ethers.parseEther(goal),
      duration * 24 * 60 * 60,
      name,
      symbol
    );
  };

  // Add more UI logic for funding, claiming, refunding, listing projects, etc.

  return (
    <div>
      <h1>Tokenized Crowdfunding Platform</h1>
      <form>
        <input placeholder="Goal in ETH" value={goal} onChange={e => setGoal(e.target.value)} />
        <input placeholder="Duration (days)" value={duration} onChange={e => setDuration(e.target.value)} />
        <input placeholder="Token Name" value={name} onChange={e => setName(e.target.value)} />
        <input placeholder="Token Symbol" value={symbol} onChange={e => setSymbol(e.target.value)} />
        <button type="button" onClick={createProject}>Create Project</button>
      </form>
      {/* Render projects and actions here */}
    </div>
  );
}

export default App;