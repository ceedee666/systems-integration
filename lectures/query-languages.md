# Query languages

<!--toc:start-->

- [Query languages](#query-languages)
  - [SQL](#sql)
    - [Introduction to SQL](#introduction-to-sql)
      - [1. Data Definition (DDL - Data Definition Language)](#1-data-definition-ddl-data-definition-language)
      - [Key DDL Statements](#key-ddl-statements)
      - [Example of Table Creation](#example-of-table-creation)
      - [2. Data Querying (DQL - Data Query Language)](#2-data-querying-dql-data-query-language)
        - [Example of a Basic Query](#example-of-a-basic-query)
      - [3. Data Manipulation (DML - Data Manipulation Language)](#3-data-manipulation-dml-data-manipulation-language)
        - [Key DML Statements](#key-dml-statements)
        - [Example of Data Manipulation](#example-of-data-manipulation)
      - [4. Data Control (DCL - Data Control Language)](#4-data-control-dcl-data-control-language)
        - [Example of Data Control:](#example-of-data-control)
    - [SQL Versions](#sql-versions)
      - [SQL-86 (SQL-1) – The First SQL Standard](#sql-86-sql-1-the-first-sql-standard)
      - [SQL-92 (SQL-2) – A Major Expansion](#sql-92-sql-2-a-major-expansion)
      - [SQL:2003 – XML Support and Enhanced Data Types](#sql2003-xml-support-and-enhanced-data-types)
      - [SQL:2016 – JSON Support and Security Improvements](#sql2016-json-support-and-security-improvements)
  - [XPath](#xpath)
    - [Key Concepts in XPath](#key-concepts-in-xpath)
    - [XPath Examples](#xpath-examples)
      - [1. **Selecting All `product` Elements**](#1-selecting-all-product-elements)
      - [2. **Selecting the `name` of the First Product**](#2-selecting-the-name-of-the-first-product)
      - [3. **Selecting All `price` Elements Anywhere in the Document**](#3-selecting-all-price-elements-anywhere-in-the-document)
      - [4. **Filtering Based on Attribute Presence**](#4-filtering-based-on-attribute-presence)
      - [5. **Selecting the `currency` Attribute of All `price` Elements**](#5-selecting-the-currency-attribute-of-all-price-elements)
      - [6. **Selecting Products with a `price` Greater than 500**](#6-selecting-products-with-a-price-greater-than-500)
      - [7. **Selecting Products Where `price` Is in EUR**](#7-selecting-products-where-price-is-in-eur)
      - [8. **Counting the Number of `product` Elements**](#8-counting-the-number-of-product-elements)
      - [9. **Selecting All `product` Elements with a `stock` Value Less Than 10**](#9-selecting-all-product-elements-with-a-stock-value-less-than-10)
      - [10. **Selecting `name` Elements for Products Containing "Bike"**](#10-selecting-name-elements-for-products-containing-bike)
      - [11. **Selecting All Products Where the `currency` Attribute Exists**](#11-selecting-all-products-where-the-currency-attribute-exists)
    - [Exercise: Writing XPath Expressions](#exercise-writing-xpath-expressions)
      - [Questions](#questions)
  - [References](#references)
  - [Navigation](#navigation)
  <!--toc:end-->

After discussing different exchange formats in the previous section the focus
is now on query languages. The focus in this section will be on SQL and XPath.
SQL is still the dominating language for extracting data from databases and
XPath is the basis for XLST, one of the transformation languages discussed in a
subsequent section.

## SQL

### Introduction to SQL

**SQL (Structured Query Language)** is the standard language used for managing
and interacting with relational databases. It provides a robust set of tools
for defining the structure of the database, manipulating data, querying data,
and controlling access to the data. SQL is divided into several functional
categories, each serving a specific purpose: **Data Querying**, **Data
Definition**, **Data Manipulation**, and **Data Control**.

##### 1. Data Definition (DDL - Data Definition Language)

**Data Definition Language (DDL)** is used to define and modify the structure
of database objects like tables, indexes, and schemas. DDL statements create,
alter, or remove objects in the database.

##### Key DDL Statements

- **`CREATE`**: Used to create new database objects such as tables, indexes,
  views, and databases.
- **`ALTER`**: Used to modify existing database objects, such as adding a
  column to a table or changing a column's data type.
- **`DROP`**: Removes database objects like tables or indexes.

##### Example of Table Creation

```sql
CREATE TABLE Products (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10, 2),
    stock INT
);
```

This statement creates a `Products` table with columns for `id`, `name`,
`price`, and `stock`.

#### 2. Data Querying (DQL - Data Query Language)

**Data Query Language (DQL)** deals with retrieving and querying data from the
database. The primary focus of DQL is on the `SELECT` statement, which is used
to retrieve data from one or more tables. This includes:

- **Selecting columns and rows**: Retrieving specific columns and filtering
  rows based on conditions.
- **Sorting and ordering**: Sorting data by one or more columns.
- **Aggregating data**: Summarizing data using functions like `COUNT()`,
  `SUM()`, `AVG()`, etc.
- **Joining tables**: Combining data from multiple related tables.

##### Example of a Basic Query

```sql
SELECT name, price
FROM Products
WHERE price > 1000;
```

This query retrieves the `name` and `price` of all products where the price is
greater than 1000.

**Key Elements of Querying in SQL:**

- **`SELECT`**: Defines which columns to retrieve.
- **`FROM`**: Specifies the table(s) from which the data is pulled.
- **`WHERE`**: Applies conditions to filter the data.
- **`ORDER BY`**: Sorts the results.
- **`JOIN`**: Combines data from multiple tables.

#### 3. Data Manipulation (DML - Data Manipulation Language)

**Data Manipulation Language (DML)** is used for inserting, updating, and
deleting data in the database. These operations allow you to change the content
of the database without altering its structure.

##### Key DML Statements

- **`INSERT`**: Adds new rows (records) into a table.
- **`UPDATE`**: Modifies existing data in a table.
- **`DELETE`**: Removes rows from a table.

##### Example of Data Manipulation

1. **Insert a new record:**

```sql
INSERT INTO Products (id, name, price, stock)
VALUES (1, 'Mountain Bike', 1200.00, 10);
```

2. **Update an existing record:**

```sql
UPDATE Products
SET price = 1300.00
WHERE id = 1;
```

3. **Delete a record:**

```sql
DELETE FROM Products
WHERE id = 1;
```

#### 4. Data Control (DCL - Data Control Language)

**Data Control Language (DCL)** is used to control access to data within the
database. It manages user permissions and security by allowing or restricting
access to certain data or operations.

- **`GRANT`**: Grants specific privileges to a user or role.
- **`REVOKE`**: Removes specific privileges from a user or role.

##### Example of Data Control:

1. **Grant access to a table:**

```sql
GRANT SELECT, INSERT ON Products TO user_name;
```

2. **Revoke access from a user:**

```sql
REVOKE INSERT ON Products FROM user_name;
```

### SQL Versions

The relation database model and SQL as the query and data manipulation language
is is still the most used technologies for managing data today. The historic
evolution of relational database is discussed in the SIGMOD paper by M.
Stonebraker and A. Pavlo titled 'What goes around comes around... and
around...' [^1].

As a result of this evolution also the SQL standard evolved significantly. The
following list show the most important improvements in selected SQL versions.

#### SQL-86 (SQL-1) – The First SQL Standard

- **Released**: 1986
- **Key Improvements**:
  - The first formal SQL standard, based on the SQL language initially
    developed by IBM.
  - Introduced the basic SQL constructs like `SELECT`, `INSERT`, `UPDATE`,
    `DELETE`, `WHERE`, and `FROM`.
  - Laid the foundation for relational databases, with basic querying and
    manipulation capabilities.

While SQL-86 provided a good foundation, it lacked more advanced features such
as integrity constraints, joins, and transaction controls.

#### SQL-92 (SQL-2) – A Major Expansion

- **Released**: 1992
- **Key Improvements**:
  - Significantly extended SQL with more advanced features.
  - **Data types**: Introduced additional data types such as `DATE`, `TIME`,
    and `TIMESTAMP`.
  - **Joins**: Added support for **outer joins** (LEFT, RIGHT, FULL), allowing
    more flexible combinations of tables.
  - **Set operations**: Introduced **set operations** like `UNION`, `EXCEPT`,
    and `INTERSECT`.
  - **Subqueries**: Enhanced subquery functionality with correlated subqueries
    and more flexible nesting.
  - **Transaction control**: Introduced the `COMMIT` and `ROLLBACK` commands
    for better transaction management.
  - **String manipulation**: Introduced string functions like `SUBSTRING`,
    `POSITION`, and `TRIM`.
  - **Schema management**: Added schema definition language elements for better
    organization of database objects.

SQL-92 was widely adopted and set the stage for more advanced SQL
functionalities in future versions.

#### SQL:2003 – XML Support and Enhanced Data Types

- **Released**: 2003
- **Key Improvements**:
  - **XML support**: Introduced features to handle **XML data** natively within
    SQL databases. Functions such as `XMLQUERY`, `XMLELEMENT`, and `XMLTABLE`
    were added to query and manipulate XML data.
  - **Auto-increment columns**: Introduced **`GENERATED AS IDENTITY`** for
    defining auto-incrementing primary keys.
  - **MERGE statement**: Added the `MERGE` statement, which combines `INSERT`,
    `UPDATE`, and `DELETE` operations into one, simplifying upsert operations.

SQL:2003 enhanced SQL’s flexibility, especially with XML support, and addressed
common enterprise needs such as auto-incrementing keys and advanced querying
techniques.

#### SQL:2016 – JSON Support and Security Improvements

- **Released**: 2016
- **Key Improvements**:
  - **JSON support**: Introduced functions to handle **JSON data** similar to
    the XML functions added earlier (`JSON_VALUE`, `JSON_QUERY`, `JSON_TABLE`).
  - **Row-level security**: Added support for **row-level security**, enabling
    fine-grained access control at the row level based on user roles.
  - **Polyglot queries**: Allowed the integration of external languages and
    sources (like Hadoop or NoSQL) in SQL queries, extending its capabilities in
    Big Data environments.
  - **Lateral joins**: Introduced **LATERAL joins**, improving subquery
    functionality in complex queries.

SQL:2016 brought SQL into the modern age by supporting **semi-structured data**
(JSON) and improving security with **row-level access control**.

## XPath

**XPath (XML Path Language)** is a query language used for selecting nodes from
XML documents. It is a powerful tool for navigating and querying XML data,
allowing users to locate and extract specific data elements based on their
hierarchical structure.

XPath is often used in conjunction with XSLT, XQuery, and SQL/XML, and is an
integral part of working with XML in a variety of contexts.

### Key Concepts in XPath

As a basis for the introduction of the key concepts of XPath consider the
following XML document:

```xml
<products>
  <product id="1">
    <name>Mountain Bike</name>
    <price currency="USD">1200.00</price>
    <stock>10</stock>
  </product>
  <product id="2">
    <name>Road Bike</name>
    <price currency="USD">900.00</price>
    <stock>5</stock>
  </product>
  <product id="3">
    <name>Helmet</name>
    <price currency="USD">50.00</price>
    <stock>100</stock>
  </product>
</products>
```

1. **Nodes**: XPath operates on the **XML document’s node tree**, which
   consists of different types of nodes. The most common node types are:

   - **Element nodes**: Represent XML elements, such as `<product>` in the XML
     structure.
   - **Attribute nodes**: Represent attributes within elements, such as
     `currency="USD"` in `<price currency="USD">`.
   - **Text nodes**: Contain the text content inside elements, such as
     `Mountain Bike` in `<name>Mountain Bike</name>`.
   - **Root node**: Represents the topmost node in the XML document, usually
     the document itself.

2. **Path Expressions**: **Path expressions** in XPath are used to navigate
   through the hierarchical structure of an XML document. These expressions select
   nodes or node sets based on their position in the document.

   There are two main types of path expressions:

   - **Absolute path**: Starts from the root node and is denoted by a forward
     slash `/`. This means the path expression begins at the very start of the
     XML document.

     - Example: `/products/product` selects all `product` elements that are
       direct children of the `products` element.

   - **Relative path**: Starts from the current node (context node) and is not
     prefixed with a `/`. This means the path expression selects nodes relative
     to where the expression is evaluated.

     - Example: `product/name` selects the `name` element under the `product`
       element, but it’s relative to the current context node.

   Additionally, the **double slash (`//`)** is used to select nodes
   **anywhere in the document**, regardless of their position relative to the
   current node. It searches through all descendants of the context node (or
   the root node if used at the start).

   Example: To select all `name` elements anywhere in the XML document:

   ```xpath
   //name
   ```

   Example: To select all `price` elements that are descendants of the
   `products` element:

   ```xpath
   /products//price
   ```

3. **Predicates**: **Predicates** are used to filter nodes based on
   conditions. They are enclosed in square brackets (`[]`) and allow XPath
   expressions to select nodes based on attribute values, position, or the
   presence of child nodes.

   - **By Position**: Select the first, second, or any other specific node.
     - Example: `/products/product[1]` selects the first `product` element.
   - **By Attribute**: Filter nodes based on attribute values.

     - Example: `/products/product[@id='2']` selects the `product` element
       where the `id` attribute equals `2`.

   - **By Condition**: Apply a condition to filter nodes based on their
     content.
     - Example: `/products/product[price > 500]` selects all `product` elements
       where the `price` is greater than 500.

4. **Axes**: XPath **axes** define the relationship between the current node
   and other nodes in the document. Axes allow you to move up and down the
   tree structure.

   Some important axes are:

   - **`child`** (default): Selects all child nodes of the current node. This
     is the default axis and does not need to be explicitly specified.

     - Example: `/products/product/child::name` is equivalent to
       `/products/product/name`.

   - **`parent`**: Selects the parent node of the current node.

     - Example: `/products/product/name/parent::product` selects the `product`
       element that is the parent of the `name` element.

   - **`descendant`**: Selects all descendants (children, grandchildren, etc.)
     of the current node.

     - Example: `/products/descendant::price` selects all `price` elements that
       are descendants of the `products` element.

   - **`attribute`**: Selects attributes of the current node.
     - Example: `/products/product/price/attribute::currency` selects the
       `currency` attribute of the `price` element.

5. **Functions**: XPath includes a number of **functions** that can be used to
   manipulate data or evaluate conditions within the query. Some common
   functions are:

   - **`text()`**: Returns the text content of the current node.
     - Example: `/products/product/name/text()` selects the text content of the
       `name` element (e.g., `Mountain Bike`).
   - **`contains()`**: Checks whether a string contains a specified substring.
     - Example: `/products/product[contains(name, 'Bike')]/name` selects all
       `name` elements that contain the string "Bike".
   - **`count()`**: Counts the number of nodes in a node set.
     - Example: `count(/products/product)` returns the number of `product`
       elements in the document.

### XPath Examples

Let’s continue with our example XML document about products:

```xml
<products>
  <product id="1">
    <name>Mountain Bike</name>
    <price currency="USD">1200.00</price>
    <stock>10</stock>
  </product>
  <product id="2">
    <name>Road Bike</name>
    <price currency="USD">900.00</price>
    <stock>5</stock>
  </product>
  <product id="3">
    <name>Helmet</name>
    <price currency="USD">50.00</price>
    <stock>100</stock>
  </product>
  <product id="4">
    <name>Gloves</name>
    <price currency="EUR">25.00</price>
    <stock>50</stock>
  </product>
</products>
```

#### 1. **Selecting All `product` Elements**

To select all `product` elements under the `products` element:

```xpath
/products/product
```

**Result Set**:

```xml
<product id="1">
  <name>Mountain Bike</name>
  <price currency="USD">1200.00</price>
  <stock>10</stock>
</product>
<product id="2">
  <name>Road Bike</name>
  <price currency="USD">900.00</price>
  <stock>5</stock>
</product>
<product id="3">
  <name>Helmet</name>
  <price currency="USD">50.00</price>
  <stock>100</stock>
</product>
<product id="4">
  <name>Gloves</name>
  <price currency="EUR">25.00</price>
  <stock>50</stock>
</product>
```

#### 2. **Selecting the `name` of the First Product**

To select the `name` of the first `product`:

```xpath
/products/product[1]/name
```

**Result Set**:

```xml
<name>Mountain Bike</name>
```

#### 3. **Selecting All `price` Elements Anywhere in the Document**

To select all `price` elements, regardless of where they are located within the
XML document:

```xpath
//price
```

**Result Set**:

```xml
<price currency="USD">1200.00</price>
<price currency="USD">900.00</price>
<price currency="USD">50.00</price>
<price currency="EUR">25.00</price>
```

#### 4. **Filtering Based on Attribute Presence**

To select all `product` elements where the `currency` attribute is present in
the `price` element:

```xpath
/products/product[price/@currency]
```

This expression selects all products that have a `currency` attribute in the
`price` element.

**Result Set**:

```xml
<product id="1">
  <name>Mountain Bike</name>
  <price currency="USD">1200.00</price>
  <stock>10</stock>
</product>
<product id="2">
  <name>Road Bike</name>
  <price currency="USD">900.00</price>
  <stock>5</stock>
</product>
<product id="3">
  <name>Helmet</name>
  <price currency="USD">50.00</price>
  <stock>100</stock>
</product>
<product id="4">
  <name>Gloves</name>
  <price currency="EUR">25.00</price>
  <stock>50</stock>
</product>
```

#### 5. **Selecting the `currency` Attribute of All `price` Elements**

To select the `currency` attribute of all `price` elements:

```xpath
/products/product/price/@currency
```

**Result Set**:

```xml
currency="USD"
currency="USD"
currency="USD"
currency="EUR"
```

#### 6. **Selecting Products with a `price` Greater than 500**

To select all products where the `price` is greater than 500:

```xpath
/products/product[price > 500]
```

**Result Set**:

```xml
<product id="1">
  <name>Mountain Bike</name>
  <price currency="USD">1200.00</price>
  <stock>10</stock>
</product>
<product id="2">
  <name>Road Bike</name>
  <price currency="USD">900.00</price>
  <stock>5</stock>
</product>
```

#### 7. **Selecting Products Where `price` Is in EUR**

To select all products where the `currency` attribute in the `price` element is `EUR`:

```xpath
/products/product[price/@currency='EUR']
```

**Result Set**:

```xml
<product id="4">
  <name>Gloves</name>
  <price currency="EUR">25.00</price>
  <stock>50</stock>
</product>
```

#### 8. **Counting the Number of `product` Elements**

To count the number of `product` elements:

```xpath
count(/products/product)
```

**Result**:

```plaintext
4
```

#### 9. **Selecting All `product` Elements with a `stock` Value Less Than 10**

To select all `product` elements where the `stock` value is less than 10:

```xpath
/products/product[stock < 10]
```

**Result Set**:

```xml
<product id="2">
  <name>Road Bike</name>
  <price currency="USD">900.00</price>
  <stock>5</stock>
</product>
```

#### 10. **Selecting `name` Elements for Products Containing "Bike"**

To select the `name` elements of products whose name contains the word "Bike":

```xpath
/products/product[contains(name, 'Bike')]/name
```

**Result Set**:

```xml
<name>Mountain Bike</name>
<name>Road Bike</name>
```

#### 11. **Selecting All Products Where the `currency` Attribute Exists**

To select all products where the `currency` attribute exists in the `price`
element (useful if some `price` elements don’t have a `currency` attribute):

```xpath
/products/product[price/@currency]
```

**Result Set**:

```xml
<product id="1">
  <name>Mountain Bike</name>
  <price currency="USD">1200.00</price>
  <stock>10</stock>
</product>
<product id="2">
  <name>Road Bike</name>
  <price currency="USD">900.00</price>
  <stock>5</stock>
</product>
<product id="3">
  <name>Helmet</name>
  <price currency="USD">50.00</price>
  <stock>100</stock>
</product>
<product id="4">
  <name>Gloves</name>
  <price currency="EUR">25.00</price>
  <stock>50</stock>
</product>
```

### Exercise: Writing XPath Expressions

In this exercise, you will write XPath expressions to query and extract
data from an XML document representing a list of products. The goal is to use
various XPath features, including path expressions, predicates, attributes, and
functions. The basis for the exercise is the following XML document:

```xml
<store>
  <products>
    <product id="1">
      <name>Mountain Bike</name>
      <category>Outdoor</category>
      <price currency="USD">1200.00</price>
      <stock>10</stock>
      <featured>true</featured>
    </product>
    <product id="2">
      <name>Road Bike</name>
      <category>Outdoor</category>
      <price currency="USD">900.00</price>
      <stock>5</stock>
      <featured>false</featured>
    </product>
    <product id="3">
      <name>Helmet</name>
      <category>Accessories</category>
      <price currency="USD">50.00</price>
      <stock>100</stock>
    </product>
    <product id="4">
      <name>Gloves</name>
      <category>Accessories</category>
      <price currency="EUR">25.00</price>
      <stock>50</stock>
    </product>
    <product id="5">
      <name>Electric Scooter</name>
      <category>Urban Mobility</category>
      <price currency="USD">850.00</price>
      <stock>20</stock>
    </product>
  </products>
</store>
```

Write XPath expressions to solve the following queries. For each query, the
XPath expression should retrieve the relevant data from the XML document. Use
an XPath evaluator, e.g.
[https://codebeautify.org/Xpath-Tester](https://codebeautify.org/Xpath-Tester)
to check your results.

#### Questions

1. Select the names of all products.

   - Write an XPath expression to return the names of all products in the store.
   - Expected Result:

     ```plaintext
     Mountain Bike
     Road Bike
     Helmet
     Gloves
     Electric Scooter
     ```

2. Select the names of all products in the "Accessories" category.

   - Write an XPath expression that retrieves the `name` of all products where
     the `category` is "Accessories".
   - Expected Result:

     ```plaintext
     Helmet
     Gloves
     ```

3. Select all `product` elements that are featured.

   - Write an XPath expression that selects all `product` elements where the
     `<featured>` element is `true`.
   - Expected Result:

     ```xml
     <product id="1">
       <name>Mountain Bike</name>
       <category>Outdoor</category>
       <price currency="USD">1200.00</price>
       <stock>10</stock>
       <featured>true</featured>
     </product>
     ```

4. Count the number of products in the "Outdoor" category.

   - Write an XPath expression to count how many products are in the "Outdoor" category.
   - Expected Result:

     ```plaintext
     2
     ```

5. Select the names of all products with a `price` greater than 800.

   - Write an XPath expression to return the `name` of all products where the
     `price` is greater than `800`.
   - Expected Result:

     ```plaintext
     Mountain Bike
     Electric Scooter
     ```

6. Select all products that have the `featured` element present (regardless of
   its value).

   - Write an XPath expression that selects all `product` elements where the
     `<featured>` element exists (whether it is `true` or `false`).
   - Expected Result:

     ```xml
     <product id="1">
       <name>Mountain Bike</name>
       <category>Outdoor</category>
       <price currency="USD">1200.00</price>
       <stock>10</stock>
       <featured>true</featured>
     </product>
     <product id="2">
       <name>Road Bike</name>
       <category>Outdoor</category>
       <price currency="USD">900.00</price>
       <stock>5</stock>
       <featured>false</featured>
     </product>
     ```

7. **Select all products where the `stock` is less than 10.**

   - Write an XPath expression to select all `product` elements where the
     `stock` is less than `10`.
   - Expected Result:

     ```xml
     <product id="2">
       <name>Road Bike</name>
       <category>Outdoor</category>
       <price currency="USD">900.00</price>
       <stock>5</stock>
       <featured>false</featured>
     </product>
     ```

## References

[^1] M. Stonebraker and A. Pavlo, ‘What Goes Around Comes Around... And
Around...’, SIGMOD Record, vol. 53, no. 2, pp. 21–37, Jun. 2024. Available
[online](https://db.cs.cmu.edu/papers/2024/whatgoesaround-sigmodrec2024.pdf)
[^2] [W3School XML tutorial](https://www.w3schools.com/xml/)

## Navigation

🏠 [Overview](../README.md) | [< Previous Chapter](./exchange-formats.md) | [Next
Chapter >](./mapping-languages.md)
