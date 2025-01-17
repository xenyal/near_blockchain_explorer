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
    return <div className="text-center text-white text-xl mt-10">Loading...</div>;
  }

  return (
    <div className="container mx-auto p-8 bg-gray-900 text-white rounded-lg shadow-lg">
      <h1 className="text-4xl font-extrabold text-center text-blue-400 mb-6">NEAR Blockchain Explorer</h1>
      <h2 className="text-2xl text-center text-blue-300 mb-6">Average Gas Burnt: {avgGasBurnt}</h2>
      <h3 className="text-xl text-center text-blue-200 mb-4">Transfers</h3>
      <table className="w-full bg-gray-800 text-white rounded-lg shadow-lg">
        <thead className="bg-gray-700">
          <tr>
            <th className="py-3 px-4">Sender</th>
            <th className="py-3 px-4">Receiver</th>
            <th className="py-3 px-4">Deposit</th>
          </tr>
        </thead>
        <tbody>
          {transfers.map((transfer, index) => (
            <tr key={index} className="border-b border-gray-700 hover:bg-gray-700 transition-colors duration-200">
              <td className="py-3 px-4">{transfer.sender}</td>
              <td className="py-3 px-4">{transfer.receiver}</td>
              <td className="py-3 px-4">{transfer.deposit}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default BlockchainExplorer;
