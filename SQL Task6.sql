Use LibraryDB;


-- Scalar Subquery: Find the book with the earliest publication year
SELECT * 
FROM Book
WHERE publication_year = (
    SELECT MIN(publication_year) FROM Book
);
-- This subquery returns a single value (earliest year), and is used with '='


-- Subquery with IN: Find all books written by authors who have written at least 2 books
SELECT * 
FROM Book
WHERE book_id IN (
    SELECT book_id 
    FROM Book_Author
    WHERE author_id IN (
        SELECT author_id 
        FROM Book_Author
        GROUP BY author_id
        HAVING COUNT(book_id) >= 2
    )
);
-- Inner subquery filters author_ids with at least 2 books
-- Outer subquery fetches book_ids of those authors
-- Main query fetches book details for those book_ids


-- Correlated Subquery: List members who have borrowed more than 1 book
SELECT name 
FROM Member m
WHERE (
    SELECT COUNT(*) 
    FROM Borrow b 
    WHERE b.member_id = m.member_id
) > 1;
-- The subquery depends on outer query (m.member_id) – that's why it's a correlated subquery


-- EXISTS Subquery: Find members who have borrowed at least one book
SELECT name 
FROM Member m
WHERE EXISTS (
    SELECT 1 
    FROM Borrow b 
    WHERE b.member_id = m.member_id
);
-- EXISTS returns TRUE if at least one record exists in the subquery for that member


-- Scalar Subquery inside SELECT: Show each book with the average publication year
SELECT title, publication_year,
    (SELECT AVG(publication_year) FROM Book) AS average_year
FROM Book;
-- This shows a scalar subquery in the SELECT clause – returns same value for every row





