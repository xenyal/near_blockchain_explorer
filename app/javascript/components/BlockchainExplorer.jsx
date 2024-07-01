import React, { useEffect, useState } from 'react';

const BlockchainExplorer = () => {
  const [transfers, setTransfers] = useState([]);
  const [avgGasBurnt, setAvgGasBurnt] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const transfersResponse = await fetch('/api/v1/transfers');
        const transfersData = await transfersResponse.json();
        setTransfers(transfersData);

        const avgGasBurntResponse = await fetch('/api/v1/blockchains/near/avg_gas_burnt');
        const avgGasBurntData = await avgGasBurntResponse.json();
        setAvgGasBurnt(avgGasBurntData.avg_gas_burnt);
      } catch (error) {
        console.error('Error fetching data:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  if (loading) {
    return <div>Loading...</div>;
  }

  return (
    <div className="container">
      <h1>NEAR Blockchain Explorer</h1>
      <h2>Average Gas Burnt: {avgGasBurnt}</h2>
      <h3>Transfers</h3>
      <table>
        <thead>
          <tr>
            <th>Sender</th>
            <th>Receiver</th>
            <th>Deposit</th>
          </tr>
        </thead>
        <tbody>
          {transfers.map((transfer, index) => (
            <tr key={index}>
              <td>{transfer.sender}</td>
              <td>{transfer.receiver}</td>
              <td>{transfer.deposit}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default BlockchainExplorer;
