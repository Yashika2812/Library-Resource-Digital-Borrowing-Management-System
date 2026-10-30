// ==========================================
// QUERY 1: RECOMMEND BOOKS TO YASHIKA
// BASED ON SHARED AUTHORS
// ==========================================

MATCH (m:Member {memberId: 1001})
      -[:BORROWED]->(previous:Book)
      -[:WRITTEN_BY]->(a:Author)
      <-[:WRITTEN_BY]-(recommended:Book)

WHERE NOT (m)-[:BORROWED]->(recommended)

RETURN DISTINCT
       m.name AS Member,
       recommended.title AS RecommendedBook,
       a.name AS SharedAuthor;


// ==========================================
// QUERY 2: GROUP RECOMMENDATIONS BY BOOK
// ==========================================

MATCH (m:Member {memberId: 1001})
      -[:BORROWED]->(:Book)
      -[:WRITTEN_BY]->(a:Author)
      <-[:WRITTEN_BY]-(recommended:Book)

WHERE NOT (m)-[:BORROWED]->(recommended)

RETURN recommended.title AS RecommendedBook,
       COLLECT(DISTINCT a.name) AS SharedAuthors
ORDER BY RecommendedBook;


// ==========================================
// QUERY 3: RANK RECOMMENDATIONS
// BY NUMBER OF SHARED AUTHORS
// ==========================================

MATCH (m:Member {memberId: 1001})
      -[:BORROWED]->(:Book)
      -[:WRITTEN_BY]->(a:Author)
      <-[:WRITTEN_BY]-(recommended:Book)

WHERE NOT (m)-[:BORROWED]->(recommended)

RETURN recommended.title AS RecommendedBook,
       COUNT(DISTINCT a) AS SharedAuthorCount,
       COLLECT(DISTINCT a.name) AS SharedAuthors
ORDER BY SharedAuthorCount DESC,
         RecommendedBook;


// ==========================================
// QUERY 4: RECOMMEND BOOKS FOR ALL MEMBERS
// ==========================================

MATCH (m:Member)-[:BORROWED]->(:Book)
      -[:WRITTEN_BY]->(a:Author)
      <-[:WRITTEN_BY]-(recommended:Book)

WHERE NOT (m)-[:BORROWED]->(recommended)

RETURN m.name AS Member,
       recommended.title AS RecommendedBook,
       COLLECT(DISTINCT a.name) AS SharedAuthors
ORDER BY Member, RecommendedBook;