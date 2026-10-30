// Ensure every member has a unique memberId.
CREATE CONSTRAINT member_id_unique IF NOT EXISTS
FOR (m:Member)
REQUIRE m.memberId IS UNIQUE;

// Ensure every book has a unique bookId.
CREATE CONSTRAINT book_id_unique IF NOT EXISTS
FOR (b:Book)
REQUIRE b.bookId IS UNIQUE;

// Ensure every author has a unique name.
CREATE CONSTRAINT author_name_unique IF NOT EXISTS
FOR (a:Author)
REQUIRE a.name IS UNIQUE;

// Ensure every publisher has a unique name.
CREATE CONSTRAINT publisher_name_unique IF NOT EXISTS
FOR (p:Publisher)
REQUIRE p.name IS UNIQUE;

// Ensure every copy has a unique copyId.
CREATE CONSTRAINT copy_id_unique IF NOT EXISTS
FOR (c:Copy)
REQUIRE c.copyId IS UNIQUE;

// Create an index for searching books by title.
CREATE INDEX book_title_index IF NOT EXISTS
FOR (b:Book)
ON (b.title);

// Create an index for searching members by name.
CREATE INDEX member_name_index IF NOT EXISTS
FOR (m:Member)
ON (m.name);