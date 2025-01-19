<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Add New Book - MayU</title>
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
      rel="stylesheet"
    />
  </head>
  <body>
    <header class="header">
      <div class="header-content">
        <a href="/books" class="logo">MayU</a>
        <nav class="nav-links">
          <a href="/books" class="nav-link">Books</a>
          <a href="/books/add" class="add-book-btn">Add Book</a>
        </nav>
      </div>
    </header>

    <div class="container">
      <h1>Add New Book</h1>

      <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
      </c:if>

      <div class="form-container">
        <form
          action="/books/add"
          method="POST"
          onsubmit="return formatDateBeforeSubmit()"
        >
          <div class="form-group">
            <label for="name">Book Name</label>
            <input
              type="text"
              id="name"
              name="name"
              required
              placeholder="Enter book name"
            />
          </div>

          <div class="form-group">
            <label for="isbn">ISBN</label>
            <input
              type="text"
              id="isbn"
              name="isbn"
              required
              placeholder="Enter ISBN"
            />
          </div>

          <div class="form-group">
            <label for="publishDate">Publish Date</label>
            <input
              type="text"
              id="publishDate"
              name="publishDate"
              required
              placeholder="dd/MM/yyyy"
            />
          </div>

          <div class="form-group">
            <label for="bookType">Book Type</label>
            <select id="bookType" name="bookType" required>
              <option value="">Select book type</option>
              <option value="Hard Cover">Hard Cover</option>
              <option value="Soft Cover">Soft Cover</option>
              <option value="Mystery">Mystery</option>
              <option value="eBook">eBook</option>
            </select>
          </div>

          <div class="form-group">
            <label for="price">Price (ZAR)</label>
            <input
              type="number"
              id="price"
              name="price"
              step="0.01"
              min="0"
              required
              placeholder="Enter price"
            />
          </div>

          <div class="form-actions">
            <button type="submit" class="btn btn-primary">Add Book</button>
            <a href="/books" class="btn btn-secondary">Cancel</a>
          </div>
        </form>
      </div>
    </div>

    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Inter", sans-serif;
      }

      body {
        background-color: #f8f9fa;
        color: #1a1a1a;
        line-height: 1.6;
      }

      .header {
        background-color: #1a1a1a;
        padding: 1rem 0;
        position: sticky;
        top: 0;
        z-index: 1000;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }

      .header-content {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }

      .logo {
        color: white;
        font-size: 1.8rem;
        font-weight: 700;
        text-decoration: none;
        letter-spacing: -0.5px;
      }

      .nav-links {
        display: flex;
        gap: 1.5rem;
        align-items: center;
      }

      .nav-link {
        color: #ffffff;
        text-decoration: none;
        font-weight: 500;
        padding: 0.5rem 1rem;
        border-radius: 6px;
        transition: all 0.2s ease;
      }

      .nav-link:hover {
        background-color: rgba(255, 255, 255, 0.1);
      }

      .add-book-btn {
        background-color: #8a2be2;
        color: white;
        text-decoration: none;
        padding: 0.5rem 1.2rem;
        border-radius: 6px;
        font-weight: 500;
        transition: all 0.2s ease;
      }

      .add-book-btn:hover {
        background-color: #9d3cf3;
        transform: translateY(-1px);
      }

      .container {
        max-width: 1200px;
        margin: 2rem auto;
        padding: 0 2rem;
      }

      h1 {
        color: #1a1a1a;
        margin-bottom: 2rem;
        font-size: 2rem;
        font-weight: 600;
      }

      .form-container {
        background: white;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        padding: 2rem;
        max-width: 600px;
        margin: 0 auto;
      }

      .form-group {
        margin-bottom: 1.5rem;
      }

      .form-group label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 500;
        color: #1a1a1a;
      }

      .form-group input,
      .form-group select {
        width: 100%;
        padding: 0.75rem 1rem;
        border: 1px solid #e0e0e0;
        border-radius: 6px;
        font-size: 1rem;
        transition: all 0.2s ease;
      }

      .form-group input:focus,
      .form-group select:focus {
        outline: none;
        border-color: #8a2be2;
        box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.1);
      }

      .form-group input::placeholder {
        color: #999;
      }

      .form-actions {
        display: flex;
        gap: 1rem;
        margin-top: 2rem;
      }

      .btn {
        padding: 0.75rem 1.5rem;
        border: none;
        border-radius: 6px;
        font-weight: 500;
        font-size: 1rem;
        cursor: pointer;
        transition: all 0.2s ease;
      }

      .btn-primary {
        background-color: #8a2be2;
        color: white;
        flex: 1;
      }

      .btn-secondary {
        background-color: #f0e6ff;
        color: #8a2be2;
        text-decoration: none;
        text-align: center;
        flex: 1;
      }

      .btn:hover {
        transform: translateY(-1px);
      }

      .btn-primary:hover {
        background-color: #9d3cf3;
      }

      .btn-secondary:hover {
        background-color: #e6d9ff;
      }

      .alert {
        padding: 1rem 1.5rem;
        margin-bottom: 1.5rem;
        border-radius: 8px;
        background-color: #ffe6e6;
        color: #dc3545;
        border: 1px solid #ffcccc;
      }

      @media (max-width: 768px) {
        .header-content {
          flex-direction: column;
          gap: 1rem;
          text-align: center;
          padding: 1rem;
        }

        .nav-links {
          flex-direction: column;
          width: 100%;
        }

        .add-book-btn {
          width: 100%;
        }

        .container {
          padding: 1rem;
        }

        .form-container {
          padding: 1.5rem;
          margin: 0 -1rem;
          border-radius: 0;
        }

        .form-actions {
          flex-direction: column;
        }

        .btn {
          width: 100%;
        }
      }
    </style>

    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const dateInput = document.getElementById("publishDate");

        // Set the default value to today in dd/MM/yyyy format
        const today = new Date();
        const dd = String(today.getDate()).padStart(2, "0");
        const mm = String(today.getMonth() + 1).padStart(2, "0");
        const yyyy = today.getFullYear();
        dateInput.value = `${dd}/${mm}/${yyyy}`;

        // Add input event listener for real-time formatting
        dateInput.addEventListener("input", function (e) {
          let value = e.target.value;

          // Remove any non-numeric characters except /
          value = value.replace(/[^\d/]/g, "");

          // Auto-add slashes
          if (value.length >= 2 && value.charAt(2) !== "/") {
            value = value.slice(0, 2) + "/" + value.slice(2);
          }
          if (value.length >= 5 && value.charAt(5) !== "/") {
            value = value.slice(0, 5) + "/" + value.slice(5);
          }

          // Limit the total length
          if (value.length > 10) {
            value = value.slice(0, 10);
          }

          e.target.value = value;
        });
      });

      function formatDateBeforeSubmit() {
        const dateInput = document.getElementById("publishDate");
        const value = dateInput.value;

        // Allow both formats: dd/MM/yyyy and d/M/yyyy
        const dateRegex = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
        const matches = value.match(dateRegex);

        if (!matches) {
          alert("Please enter a valid date in dd/MM/yyyy format");
          return false;
        }

        let [_, day, month, year] = matches;

        // Convert to numbers for validation
        day = parseInt(day, 10);
        month = parseInt(month, 10);
        year = parseInt(year, 10);

        // Basic date validation
        if (month < 1 || month > 12) {
          alert("Month must be between 1 and 12");
          return false;
        }

        // Get last day of the month
        const lastDay = new Date(year, month, 0).getDate();
        if (day < 1 || day > lastDay) {
          alert(`Day must be between 1 and ${lastDay} for the selected month`);
          return false;
        }

        // Format the date with leading zeros
        const formattedDay = day.toString().padStart(2, "0");
        const formattedMonth = month.toString().padStart(2, "0");

        // Update the input value with the formatted date
        dateInput.value = `${formattedDay}/${formattedMonth}/${year}`;
        return true;
      }
    </script>
  </body>
</html>
