import React, { useState } from 'react';
import './App.css';

function App() {
  const [message, setMessage] = useState('Hello World');
  const [loading, setLoading] = useState(false);

  const fetchTest = async () => {
    setLoading(true);
    try {
      const response = await fetch('http://localhost:3000/test');
      if (!response.ok) {
        throw new Error('Ошибка сети');
      }
      const data = await response.text(); // предполагаем, что бэкенд возвращает строку
      setMessage(data);
    } catch (error) {
      console.error('Ошибка запроса:', error);
      setMessage('Не удалось загрузить данные');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="App">
      <header className="App-header">
        <p>{message}</p>
        <button onClick={fetchTest} disabled={loading}>
          {loading ? 'Загрузка...' : 'Получить с бэкенда'}
        </button>
      </header>
    </div>
  );
}

export default App;