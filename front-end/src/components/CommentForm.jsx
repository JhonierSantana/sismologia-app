import React, { useState } from 'react';
import axios from 'axios';
import '../Style/Comments.css';

const CommentForm = () => {
  const [body, setBody] = useState('');
  const [featureId, setFeatureId] = useState('');
  const [successMessage, setSuccessMessage] = useState('');
  const [errorMessage, setErrorMessage] = useState('');

  const handleSubmit = async (event) => {
    event.preventDefault();

    if (!body.trim()) {
      setErrorMessage('Comment cannot be empty');
      return;
    }
  
    const id = parseInt(featureId);
    if (isNaN(id)) {
      setErrorMessage('Feature ID must be a number');
      return;
    }
  
    try {
      const response = await axios.post(`http://localhost:3000/api/features/${id}/comments`, {
        body
      });
      setSuccessMessage('Comment created successfully!');
      setErrorMessage('');
      setFeatureId('');
      setBody('');
    } catch (error) {
      setSuccessMessage('');
      setErrorMessage('Error creating comment');
      console.error('Error creating comment', error);
    }
  };
  
  return (
    <div className="comment-form-container">
      <h2>Create Comment</h2>
      <form onSubmit={handleSubmit}>
        <div>
          <label htmlFor="featureId">Feature ID:</label>
          <input
            type="text"
            id="featureId"
            value={featureId}
            onChange={(event) => setFeatureId(event.target.value)}
            autoComplete='off'
          />
        </div>
        <div>
          <label htmlFor="body">Comment:</label>
          <input
            type="text"
            id="body"
            value={body}
            onChange={(event) => setBody(event.target.value)}
            autoComplete='off'
          />
        </div>
        <button type="submit">Submit</button>
      </form>
      {successMessage && <p>{successMessage}</p>}
      {errorMessage && <p>{errorMessage}</p>}
    </div>
  );
};

export default CommentForm;
