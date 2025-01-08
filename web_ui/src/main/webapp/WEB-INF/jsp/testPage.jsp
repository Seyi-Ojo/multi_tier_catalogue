<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Test Page</title>
  </head>
  <body>
    <h1>Testing New Book</h1>
    <form action="/books/add" method="post">
      <label for="name">Name:</label>
      <input type="text" name="name" required /><br />
      <label for="isbn">ISBN:</label>
      <input type="text" name="isbn" required /><br />
      <label for="publishDate">Publish Date:</label>
      <input type="text" name="publishDate" required /><br />
      <label for="bookType">Book Type:</label>
      <input type="text" name="bookType" required /><br />
      <label for="price">Price:</label>
      <input type="number" name="price" step="0.01" required /><br />
      <button type="submit">Add Book</button>
    </form>
  </body>
</html>
