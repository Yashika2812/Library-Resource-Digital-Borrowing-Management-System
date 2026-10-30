# 📚 Library Resource & Digital Borrowing Management System

**A Graph Database Solution Powered by Neo4j and Cypher**

## 📖 Overview

The Library Resource & Digital Borrowing Management System is a DBMS mini project designed to organize library resources and represent the relationships between books, authors, publishers, members, and individual book copies.

Built using **Neo4j AuraDB** and **Cypher Query Language**, the project uses a graph-based approach to manage library information, track book availability, explore borrowing history, and discover connections between library resources.

Unlike traditional relational models, Neo4j represents data as interconnected nodes and relationships, making it well suited for exploring complex connections within a library system.

## 🎯 Objectives

- Organize library books, authors, publishers, and members.
- Represent relationships between books and their associated entities.
- Track individual book copies and their availability.
- Maintain borrowing information, including borrowing and due dates.
- Retrieve meaningful information using Cypher queries.
- Explore graph-based book recommendations.

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| **Neo4j AuraDB** | Cloud-hosted graph database |
| **Cypher** | Query language for creating, retrieving, and managing graph data |
| **Neo4j Browser/Query Interface** | Executing queries and visualizing graph relationships |

## 🗂️ Database Design

The database consists of five main node labels:

| Node | Description |
|---|---|
| `Member` | Represents registered library members |
| `Book` | Stores information about books |
| `Author` | Represents book authors |
| `Publisher` | Stores publisher information |
| `Copy` | Represents individual copies of books |

### Relationships

| Relationship | Purpose |
|---|---|
| `WRITTEN_BY` | Connects books with their authors |
| `PUBLISHED_BY` | Connects books with their publishers |
| `HAS_COPY` | Links books to their individual copies |
| `BORROWED` | Represents a member's borrowing activity |
| `BORROWED_COPY` | Connects borrowing activity with specific book copies |

This graph structure enables connected data to be explored through direct relationships instead of relying entirely on multiple table joins.

## ✨ Key Features

- **Resource Management:** Organizes books, authors, and publishers through connected graph entities.
- **Availability Tracking:** Identifies individual book copies marked as available.
- **Borrowing History:** Retrieves member borrowing records, including relevant dates.
- **Publisher Information:** Finds the publishers associated with specific books.
- **Graph-Based Recommendations:** Demonstrates how borrowing relationships can help identify potential book recommendations.
- **Graph Visualization:** Allows users to inspect connected data through Neo4j's query interface.

## 💻 Sample Cypher Queries

### 1. Count Nodes by Type

```cypher
MATCH (n)
RETURN labels(n) AS NodeType, COUNT(n) AS Total
ORDER BY NodeType;
```

### 2. Find Available Book Copies

```cypher
MATCH (b:Book)-[:HAS_COPY]->(c:Copy)
WHERE c.status = 'AVAILABLE'
RETURN b.title AS Book,
       c.copyId AS CopyID,
       c.status AS Status
ORDER BY Book;
```

### 3. Retrieve Book and Publisher Information

```cypher
MATCH (b:Book)-[:PUBLISHED_BY]->(p:Publisher)
RETURN b.title AS Book, p.name AS Publisher;
```

### 4. View Member Borrowing History

```cypher
MATCH (m:Member)-[r:BORROWED]->(b:Book)
RETURN m.name AS Member,
       b.title AS Book,
       r.borrowDate AS BorrowDate,
       r.dueDate AS DueDate;
```

These queries demonstrate graph traversal, filtering, aggregation, and retrieval of connected information.


## 🌐 Why Neo4j?

Neo4j is suitable for this project because library information naturally contains interconnected entities. Its graph model makes it straightforward to explore relationships between members, books, authors, publishers, and copies.

Cypher provides a readable way to traverse these relationships, retrieve connected information, and demonstrate graph-based recommendations.

## 🚀 Future Enhancements

- Add automated overdue-book detection.
- Introduce fine calculation for overdue returns.
- Implement member authentication and role-based access.
- Build a web interface for library operations.
- Improve recommendations using borrowing patterns and book categories.

## 📌 Conclusion

The Library Resource & Digital Borrowing Management System demonstrates the application of graph database concepts to a practical library management scenario. Using Neo4j AuraDB and Cypher, the project models interconnected library data and supports queries for resource discovery, availability tracking, borrowing history, and recommendations.

---

**Project Type:** DBMS Mini Project  
**Database:** Neo4j AuraDB  
**Query Language:** Cypher  
**Implementation:** Graph Database