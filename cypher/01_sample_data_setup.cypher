// ==========================================
// 1. CREATE MEMBERS
// ==========================================

MERGE (:Member {
    memberId: 1001,
    name: 'Yashika',
    email: 'yashika@example.com'
});

MERGE (:Member {
    memberId: 1002,
    name: 'Rahul',
    email: 'rahul@example.com'
});

MERGE (:Member {
    memberId: 1003,
    name: 'Priya',
    email: 'priya@example.com'
});

MERGE (:Member {
    memberId: 1004,
    name: 'Arjun',
    email: 'arjun@example.com'
});


// ==========================================
// 2. CREATE AUTHORS
// ==========================================

MERGE (:Author {name: 'Robert C. Martin'});
MERGE (:Author {name: 'Abraham Silberschatz'});
MERGE (:Author {name: 'Henry F. Korth'});
MERGE (:Author {name: 'Peter B. Galvin'});
MERGE (:Author {name: 'Greg Gagne'});
MERGE (:Author {name: 'Andrew Hunt'});
MERGE (:Author {name: 'David Thomas'});


// ==========================================
// 3. CREATE PUBLISHERS
// ==========================================

MERGE (:Publisher {name: 'Pearson'});
MERGE (:Publisher {name: 'Wiley'});
MERGE (:Publisher {name: 'Prentice Hall'});
MERGE (:Publisher {name: 'McGraw-Hill'});


// ==========================================
// 4. CREATE BOOKS
// ==========================================

MERGE (:Book {
    bookId: 101,
    title: 'Clean Code',
    category: 'Programming',
    publicationYear: 2008
});

MERGE (:Book {
    bookId: 102,
    title: 'Clean Architecture',
    category: 'Software Engineering',
    publicationYear: 2017
});

MERGE (:Book {
    bookId: 103,
    title: 'Operating System Concepts',
    category: 'Operating Systems',
    publicationYear: 2018
});

MERGE (:Book {
    bookId: 104,
    title: 'Database System Concepts',
    category: 'Database Systems',
    publicationYear: 2019
});

MERGE (:Book {
    bookId: 105,
    title: 'The Pragmatic Programmer',
    category: 'Programming',
    publicationYear: 2019
});


// ==========================================
// 5. CONNECT BOOKS TO AUTHORS
// ==========================================

MATCH (b:Book {bookId: 101}),
      (a:Author {name: 'Robert C. Martin'})
MERGE (b)-[:WRITTEN_BY]->(a);

MATCH (b:Book {bookId: 102}),
      (a:Author {name: 'Robert C. Martin'})
MERGE (b)-[:WRITTEN_BY]->(a);

MATCH (b:Book {bookId: 103}),
      (a:Author {name: 'Abraham Silberschatz'})
MERGE (b)-[:WRITTEN_BY]->(a);

MATCH (b:Book {bookId: 103}),
      (a:Author {name: 'Peter B. Galvin'})
MERGE (b)-[:WRITTEN_BY]->(a);

MATCH (b:Book {bookId: 103}),
      (a:Author {name: 'Greg Gagne'})
MERGE (b)-[:WRITTEN_BY]->(a);

MATCH (b:Book {bookId: 104}),
      (a:Author {name: 'Abraham Silberschatz'})
MERGE (b)-[:WRITTEN_BY]->(a);

MATCH (b:Book {bookId: 104}),
      (a:Author {name: 'Henry F. Korth'})
MERGE (b)-[:WRITTEN_BY]->(a);

MATCH (b:Book {bookId: 105}),
      (a:Author {name: 'Andrew Hunt'})
MERGE (b)-[:WRITTEN_BY]->(a);

MATCH (b:Book {bookId: 105}),
      (a:Author {name: 'David Thomas'})
MERGE (b)-[:WRITTEN_BY]->(a);


// ==========================================
// 6. CONNECT BOOKS TO PUBLISHERS
// ==========================================

MATCH (b:Book {bookId: 101}),
      (p:Publisher {name: 'Prentice Hall'})
MERGE (b)-[:PUBLISHED_BY]->(p);

MATCH (b:Book {bookId: 102}),
      (p:Publisher {name: 'Pearson'})
MERGE (b)-[:PUBLISHED_BY]->(p);

MATCH (b:Book {bookId: 103}),
      (p:Publisher {name: 'Wiley'})
MERGE (b)-[:PUBLISHED_BY]->(p);

MATCH (b:Book {bookId: 104}),
      (p:Publisher {name: 'McGraw-Hill'})
MERGE (b)-[:PUBLISHED_BY]->(p);

MATCH (b:Book {bookId: 105}),
      (p:Publisher {name: 'Addison-Wesley'})
MERGE (b)-[:PUBLISHED_BY]->(p);


// ==========================================
// 7. CREATE BOOK COPIES
// ==========================================

MERGE (:Copy {copyId: 'C101', status: 'AVAILABLE'});
MERGE (:Copy {copyId: 'C102', status: 'BORROWED'});
MERGE (:Copy {copyId: 'C103', status: 'AVAILABLE'});
MERGE (:Copy {copyId: 'C104', status: 'AVAILABLE'});
MERGE (:Copy {copyId: 'C105', status: 'BORROWED'});
MERGE (:Copy {copyId: 'C106', status: 'AVAILABLE'});
MERGE (:Copy {copyId: 'C107', status: 'AVAILABLE'});


// ==========================================
// 8. CONNECT BOOKS TO THEIR COPIES
// ==========================================

MATCH (b:Book {bookId: 101}), (c:Copy {copyId: 'C101'})
MERGE (b)-[:HAS_COPY]->(c);

MATCH (b:Book {bookId: 101}), (c:Copy {copyId: 'C102'})
MERGE (b)-[:HAS_COPY]->(c);

MATCH (b:Book {bookId: 102}), (c:Copy {copyId: 'C103'})
MERGE (b)-[:HAS_COPY]->(c);

MATCH (b:Book {bookId: 103}), (c:Copy {copyId: 'C104'})
MERGE (b)-[:HAS_COPY]->(c);

MATCH (b:Book {bookId: 104}), (c:Copy {copyId: 'C105'})
MERGE (b)-[:HAS_COPY]->(c);

MATCH (b:Book {bookId: 105}), (c:Copy {copyId: 'C106'})
MERGE (b)-[:HAS_COPY]->(c);

MATCH (b:Book {bookId: 105}), (c:Copy {copyId: 'C107'})
MERGE (b)-[:HAS_COPY]->(c);


// ==========================================
// 9. CREATE BORROWING RECORDS
// ==========================================

// Yashika borrows Clean Code.
MATCH (m:Member {memberId: 1001}),
      (b:Book {bookId: 101}),
      (c:Copy {copyId: 'C102'})
MERGE (m)-[r:BORROWED]->(b)
SET r.borrowDate = date('2026-10-01'),
    r.dueDate = date('2026-10-15')
MERGE (m)-[:BORROWED_COPY]->(c);

// Rahul borrows Operating System Concepts.
MATCH (m:Member {memberId: 1002}),
      (b:Book {bookId: 103}),
      (c:Copy {copyId: 'C104'})
MERGE (m)-[r:BORROWED]->(b)
SET r.borrowDate = date('2026-10-10'),
    r.dueDate = date('2026-10-24')
MERGE (m)-[:BORROWED_COPY]->(c);

// Priya borrows Database System Concepts.
MATCH (m:Member {memberId: 1003}),
      (b:Book {bookId: 104}),
      (c:Copy {copyId: 'C105'})
MERGE (m)-[r:BORROWED]->(b)
SET r.borrowDate = date('2026-10-20'),
    r.dueDate = date('2026-11-03')
MERGE (m)-[:BORROWED_COPY]->(c);

// Mark copies with existing borrowing relationships as borrowed.
MATCH (:Member)-[:BORROWED_COPY]->(c:Copy)
SET c.status = 'BORROWED';