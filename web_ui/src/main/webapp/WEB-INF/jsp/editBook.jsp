<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Edit Book - MayU</title>
    <link rel="stylesheet" href="/resources/css/style.css" />
  </head>
  <body>
    <header class="header">
      <a href="/books" class="logo">MayU</a>
      <nav class="nav-links">
        <a href="/books">Books</a>
        <a href="/books/add">Add Book</a>
      </nav>
    </header>

    <div class="container">
      <div class="form-container">
        <h1>Edit Book</h1>

        <form id="editBookForm" class="book-form">
          <div class="form-group">
            <label for="name">Book Name:</label>
            <input type="text" id="name" name="name" required 
                   value="${book.name}"
                   placeholder="Enter book name" />
          </div>

          <div class="form-group">
            <label for="isbn">ISBN:</label>
            <input type="text" id="isbn" name="isbn" required 
                   value="${book.isbn}" readonly
                   placeholder="Enter ISBN number" />
          </div>

          <div class="form-group">
            <label for="publishDate">Publish Date:</label>
            <input type="date" id="publishDate" name="publishDate" required />
            <small class="form-hint">Format: DD/MM/YYYY</small>
          </div>

          <div class="form-group">
            <label for="bookType">Book Type:</label>
            <select id="bookType" name="bookType" required>
              <option value="Hard Cover" ${book.bookType == 'Hard Cover' ? 'selected' : ''}>Hard Cover</option>
              <option value="Soft Cover" ${book.bookType == 'Soft Cover' ? 'selected' : ''}>Soft Cover</option>
              <option value="eBook" ${book.bookType == 'eBook' ? 'selected' : ''}>eBook</option>
            </select>
          </div>

          <div class="form-group">
            <label for="price">Price (ZAR):</label>
            <input type="number" id="price" name="price" 
                   step="0.01" min="0" required 
                   value="${book.price}"
                   placeholder="Enter price" />
          </div>

          <div class="button-group">
            <button type="submit" class="btn btn-primary">Update Book</button>
            <a href="/books" class="btn btn-secondary">Cancel</a>
          </div>
        </form>
      </div>
    </div>

    <script>
      document.addEventListener('DOMContentLoaded', function() {
        // Convert the date from dd/MM/yyyy to yyyy-MM-dd for the date input
        const publishDate = "${book.publishDate}";
        if (publishDate) {
          const [day, month, year] = publishDate.split('/');
          document.getElementById('publishDate').value = `${year}-${month}-${day}`;
        }
      });

      document.getElementById('editBookForm').onsubmit = function(e) {
        e.preventDefault();
        
        const dateInput = document.getElementById('publishDate').value;
        const formattedDate = formatDateForApi(dateInput);
        
        const book = {
          name: document.getElementById('name').value,
          isbn: document.getElementById('isbn').value,
          publishDate: formattedDate,
          bookType: document.getElementById('bookType').value,
          price: parseFloat(document.getElementById('price').value)
        };

        fetch(`http://localhost:8081/api/books/${book.isbn}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: JSON.stringify(book)
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('Failed to update book');
          }
          return response.json();
        })
        .then(() => {
          alert('Book updated successfully!');
          window.location.href = '/books';
        })
        .catch(error => {
          console.error('Error:', error);
          alert('Failed to update book: ' + error.message);
        });
      };

      function formatDateForApi(dateString) {
        if (!dateString) return '';
        
        const date = new Date(dateString);
        if (isNaN(date.getTime())) return '';
        
        const day = String(date.getDate()).padStart(2, '0');
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const year = date.getFullYear();
        
        return `${day}/${month}/${year}`;
      }

      // Set max date to today
      const today = new Date().toISOString().split('T')[0];
      document.getElementById('publishDate').max = today;
    </script>
  </body>
</html>
