import React, { useState, useEffect } from 'react';
import axios from 'axios';
import '../Style/FeatureList.css';

const FeatureList = () => {
  const [features, setFeatures] = useState([]);
  const [page, setPage] = useState(1);
  const [perPage, setPerPage] = useState(10);
  const [magTypeFilter, setMagTypeFilter] = useState('');
  const [hasMore, setHasMore] = useState(true);

  useEffect(() => {
    fetchFeatures();
  }, [page, perPage, magTypeFilter]);

  const fetchFeatures = () => {
    let url = `http://localhost:3000/api/features?page=${page}&per_page=${perPage}`;
    if (magTypeFilter !== '') {
      url += `&filters[mag_type]=${magTypeFilter}`;
    }
    axios.get(url)
      .then(response => {
        const newFeatures = response.data.data;
        setFeatures(newFeatures);
        setHasMore(newFeatures.length === perPage);
      })
      .catch(error => {
        console.error('Error fetching features:', error);
      });
  };

  const handleNextPage = () => {
    setPage(page + 1); 
  };

  const handlePrevPage = () => {
    setPage(page - 1);
  };

  const handleFilterChange = event => {
    setMagTypeFilter(event.target.value);
    setPage(1);
  };

  const magTypeOptions = ["", "md", "ml", "ms", "mw", "me", "mi", "mb", "mlg"];

  return (
    <div className="feature-list-container">
      <h2 className='title'>Earthquake - Feature List</h2>
      <div className="filter-section">
        <label className="label" htmlFor='magTypeFilter'>Filter by Magnitude Type:</label>
        <select id="magTypeFilter" value={magTypeFilter} onChange={handleFilterChange}>
          {magTypeOptions.map(option => (
            <option key={option || "ALL"} value={option}>{option || "ALL"}</option>
          ))}
        </select>
      </div>
      <ul className="features-grid">
        {features.map(feature => (
          <li key={feature.id} className="feature-item">
            <p><strong>Title:</strong> {feature.attributes.title}</p>
            <p><strong>Magnitude:</strong> {feature.attributes.magnitude}</p>
            <p><strong>Place:</strong> {feature.attributes.place}</p>
            <p><strong>Time:</strong> {feature.attributes.time}</p>
            <p><strong>Tsunami:</strong> {feature.attributes.tsunami ? 'Yes' : 'No'}</p>
            <p><strong>Mag Type:</strong> {feature.attributes.mag_type}</p>
            <p><strong>External ID:</strong> {feature.attributes.external_id}</p>
            <p><strong>Longitude:</strong> {feature.attributes.coordinates.longitude}</p>
            <p><strong>Latitude:</strong> {feature.attributes.coordinates.latitude}</p>
          </li>
        ))}
      </ul>
      <div className="pagination-buttons">
        <button className="button" onClick={handlePrevPage} disabled={page === 1}>Previous Page</button>
        <button className="button" onClick={handleNextPage} disabled={!hasMore}>Next Page</button>
      </div>
    </div>
  );
};

export default FeatureList;
