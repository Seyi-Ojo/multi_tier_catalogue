<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="jakarta.tags.core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Books List - MayU</title>
    <link rel="stylesheet" href="/resources/css/style.css" />
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
      <h1>Books List</h1>

      <c:if test="${not empty message}">
        <div class="alert alert-success" role="alert">${message}</div>
      </c:if>
      <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">${error}</div>
      </c:if>

      <c:choose>
        <c:when test="${empty books}">
          <div class="no-books">
            <p>No books found.</p>
            <a href="/books/add" class="btn btn-primary">Add your first book</a>
          </div>
        </c:when>
        <c:otherwise>
          <div class="table-responsive">
            <table class="book-table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>ISBN</th>
                  <th>Publish Date</th>
                  <th>Type</th>
                  <th>Price</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${books}" var="book">
                  <tr>
                    <td>${book.name}</td>
                    <td>${book.isbn}</td>
                    <td>${book.publishDate}</td>
                    <td><span class="badge">${book.bookType}</span></td>
                    <td>R ${book.price}</td>
                    <td class="action-buttons">
                      <a href="/books/edit/${book.isbn}" class="btn btn-edit"
                        >Edit</a
                      >
                      <form
                        method="POST"
                        action="/books/delete/${book.isbn}"
                        style="display: inline"
                      >
                        <button
                          type="submit"
                          class="btn btn-delete"
                          onclick="return confirm('Are you sure you want to delete this book?')"
                        >
                          Delete
                        </button>
                      </form>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

    <script>
      function deleteBook(isbn) {
        if (confirm("Are you sure you want to delete this book?")) {
          const form = document.createElement("form");
          form.method = "POST";
          form.action = `/books/delete/${isbn}`;

          const isbnInput = document.createElement("input");
          isbnInput.type = "hidden";
          isbnInput.name = "isbn";
          isbnInput.value = isbn;
          form.appendChild(isbnInput);

          document.body.appendChild(form);
          form.submit();
          document.body.removeChild(form);
        }
      }
    </script>

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

      .table-responsive {
        background: white;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        overflow: hidden;
      }

      .book-table {
        width: 100%;
        border-collapse: collapse;
        margin: 0;
      }

      .book-table th {
        background-color: #f8f9fa;
        padding: 1rem 1.5rem;
        text-align: left;
        font-weight: 600;
        color: #1a1a1a;
        border-bottom: 1px solid #eee;
      }

      .book-table td {
        padding: 1rem 1.5rem;
        border-bottom: 1px solid #eee;
      }

      .book-table tr:last-child td {
        border-bottom: none;
      }

      .book-table tr:hover {
        background-color: #f8f9fa;
      }

      .badge {
        background-color: #f0e6ff;
        color: #8a2be2;
        padding: 0.25rem 0.75rem;
        border-radius: 20px;
        font-size: 0.875rem;
        font-weight: 500;
      }

      .action-buttons {
        display: flex;
        gap: 0.75rem;
      }

      .btn {
        padding: 0.5rem 1rem;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 500;
        font-size: 0.875rem;
        transition: all 0.2s ease;
      }

      .btn-edit {
        background-color: #8a2be2;
        color: white;
        text-decoration: none;
      }

      .btn-delete {
        background-color: #dc3545;
        color: white;
      }

      .btn:hover {
        opacity: 0.9;
        transform: translateY(-1px);
      }

      .alert {
        padding: 1rem 1.5rem;
        margin-bottom: 1.5rem;
        border-radius: 8px;
        display: flex;
        align-items: center;
      }

      .alert-success {
        background-color: #f0e6ff;
        color: #8a2be2;
        border: 1px solid #d9bfff;
      }

      .alert-danger {
        background-color: #ffe6e6;
        color: #dc3545;
        border: 1px solid #ffcccc;
      }

      .no-books {
        text-align: center;
        padding: 3rem;
        background: white;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
      }

      .no-books p {
        margin-bottom: 1.5rem;
        color: #666;
        font-size: 1.1rem;
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
          text-align: center;
        }

        .action-buttons {
          flex-direction: column;
        }

        .btn {
          width: 100%;
          text-align: center;
        }

        .table-responsive {
          margin: 0 -1rem;
          border-radius: 0;
        }
      }
    </style>
  </body>
</html>
