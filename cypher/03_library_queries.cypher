// ==========================================
// QUERY 1: SEARCH FOR A BOOK BY TITLE
// ==========================================

MATCH (b:Book)
WHERE toLower(b.title) CONTAINS toLower('clean')
RETURN b.bookId AS BookID,
       b.title AS Title,
       b.category AS Category;


// ==========================================
// QUERY 2: FIND BOOKS BY A PARTICULAR AUTHOR
// ==========================================

MATCH (b:Book)-[:WRITTEN_BY]->(a:Author)
WHERE a.name = 'Robert C. Martin'
RETURN b.title AS Book,
       a.name AS Author;


// ==========================================
// QUERY 3: DISPLAY BOOKS AND PUBLISHERS
// ==========================================

MATCH (b:Book)-[:PUBLISHED_BY]->(p:Publisher)
RETURN b.title AS Book,
       p.name AS Publisher;


// ==========================================
// QUERY 4: FIND AVAILABLE BOOK COPIES
// ==========================================

MATCH (b:Book)-[:HAS_COPY]->(c:Copy)
WHERE c.status = 'AVAILABLE'
RETURN b.title AS Book,
       c.copyId AS CopyID,
       c.status AS Status
ORDER BY Book;


// ==========================================
// QUERY 5: FIND BOOKS WITHOUT AVAILABLE COPIES
// ==========================================

MATCH (b:Book)-[:HAS_COPY]->(c:Copy)
WITH b,
     SUM(CASE WHEN c.status = 'AVAILABLE'
              THEN 1 ELSE 0 END) AS AvailableCopies
WHERE AvailableCopies = 0
RETURN b.title AS Book,
       AvailableCopies;


// ==========================================
// QUERY 6: DISPLAY BORROWING HISTORY
// ==========================================

MATCH (m:Member)-[r:BORROWED]->(b:Book)
RETURN m.name AS Member,
       b.title AS Book,
       r.borrowDate AS BorrowDate,
       r.dueDate AS DueDate
ORDER BY r.borrowDate DESC;


// ==========================================
// QUERY 7: FIND OVERDUE BORROWING RECORDS
// ==========================================

MATCH (m:Member)-[r:BORROWED]->(b:Book)
WHERE r.dueDate < date()
RETURN m.name AS Member,
       b.title AS Book,
       r.borrowDate AS BorrowDate,
       r.dueDate AS DueDate
ORDER BY r.dueDate;


// ==========================================
// QUERY 8: COUNT BOOKS BORROWED BY EACH MEMBER
// ==========================================

MATCH (m:Member)-[:BORROWED]->(b:Book)
RETURN m.name AS Member,
       COUNT(b) AS BooksBorrowed
ORDER BY BooksBorrowed DESC;


// ==========================================
// QUERY 9: FIND THE MOST BORROWED BOOKS
// ==========================================

MATCH (:Member)-[:BORROWED]->(b:Book)
RETURN b.title AS Book,
       COUNT(*) AS BorrowCount
ORDER BY BorrowCount DESC;


// ==========================================
// QUERY 10: COUNT COPIES BY STATUS
// ==========================================

MATCH (c:Copy)
RETURN c.status AS Status,
       COUNT(c) AS TotalCopies
ORDER BY Status;


// ==========================================
// QUERY 11: COUNT RELATIONSHIPS BY TYPE
// ==========================================

MATCH ()-[r]->()
RETURN type(r) AS RelationshipType,
       COUNT(r) AS Total
ORDER BY RelationshipType;


// ==========================================
// QUERY 12: COUNT ALL NODES
// ==========================================

MATCH (n)
RETURN COUNT(n) AS TotalNodes;