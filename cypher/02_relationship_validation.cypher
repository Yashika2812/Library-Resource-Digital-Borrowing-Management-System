// 1. Display connected nodes and relationships.
MATCH (n)-[r]->(m)
RETURN n, r, m
LIMIT 100;


// 2. Count nodes by label.
MATCH (n)
RETURN labels(n) AS NodeType,
       COUNT(n) AS Total
ORDER BY NodeType;


// 3. List books and their authors.
MATCH (b:Book)-[:WRITTEN_BY]->(a:Author)
RETURN b.title AS Book,
       a.name AS Author
ORDER BY Book;


// 4. List books and their publishers.
MATCH (b:Book)-[:PUBLISHED_BY]->(p:Publisher)
RETURN b.title AS Book,
       p.name AS Publisher
ORDER BY Book;


// 5. Show every book and its copies.
MATCH (b:Book)-[:HAS_COPY]->(c:Copy)
RETURN b.title AS Book,
       c.copyId AS CopyID,
       c.status AS Status
ORDER BY Book, CopyID;


// 6. Show borrowing relationships.
MATCH (m:Member)-[r:BORROWED]->(b:Book)
RETURN m.name AS Member,
       b.title AS Book,
       r.borrowDate AS BorrowDate,
       r.dueDate AS DueDate;


// 7. Verify member-to-copy relationships.
MATCH (m:Member)-[:BORROWED_COPY]->(c:Copy)
RETURN m.name AS Member,
       c.copyId AS CopyID,
       c.status AS Status;