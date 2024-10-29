# Mapping languages

<!--toc:start-->

- [Mapping languages](#mapping-languages)
  - [Data Transformation Features in SQL](#data-transformation-features-in-sql)
    - [Structural Data Transformation in SQL](#structural-data-transformation-in-sql)
      - [Joins: Combining Data from Multiple Tables](#joins-combining-data-from-multiple-tables)
      - [Subqueries: Nesting Queries for Flexibility](#subqueries-nesting-queries-for-flexibility)
      - [Common Table Expressions (CTEs)](#common-table-expressions-ctes)
      - [PIVOT: Reshaping Data for Analysis](#pivot-reshaping-data-for-analysis)
    - [SQL Features for Summarizing and Analyzing Data](#sql-features-for-summarizing-and-analyzing-data)
      - [Aggregate Functions for Summarization](#aggregate-functions-for-summarization)
      - [Window Functions for Advanced Analysis](#window-functions-for-advanced-analysis)
    - [Special SQL Features for XML and JSON Transformation](#special-sql-features-for-xml-and-json-transformation)
      - [Transforming Data into XML](#transforming-data-into-xml)
      - [Transforming Data into JSON](#transforming-data-into-json)
  - [XSLT: Transforming XML for Data Integration](#xslt-transforming-xml-for-data-integration)
    - [Key Features of XSLT for Data Integration](#key-features-of-xslt-for-data-integration)
      - [Template-Based Transformation](#template-based-transformation)
      - [Conditional Logic and Control Structures](#conditional-logic-and-control-structures)
      - [Data Aggregation and Sorting](#data-aggregation-and-sorting)
    - [XML-to-JSON Transformation with XSLT](#xml-to-json-transformation-with-xslt)
      - [Example: XML-to-JSON Transformation](#example-xml-to-json-transformation)
      - [Built-in `fn:xml-to-json` Function in XSLT 3.0](#built-in-fnxml-to-json-function-in-xslt-30)
      - [Built-in `fn:json-to-xml` Function in XSLT 3.0](#built-in-fnjson-to-xml-function-in-xslt-30)
      - [Syntax of `fn:json-to-xml`](#syntax-of-fnjson-to-xml)
      - [Example: Using `fn:json-to-xml`](#example-using-fnjson-to-xml)
    - [More Complex Example: Using Advanced XPath Constructs](#more-complex-example-using-advanced-xpath-constructs)
    - [Exercises](#exercises)
    - [Key Takeaways](#key-takeaways)

<!--toc:end-->

Mapping languages enable the transformation of data from one format or
structure to another, essential in data integration scenarios. This section
focuses on XSLT (Extensible Stylesheet Language Transformations) for XML
mapping. SQL-based mapping of data is also briefly discussed. Additionally,
special SQL features for working with XML and JSON data are introduced.

## Data Transformation Features in SQL

SQL was already mentions in the [previous section](./query-languages.md) as a
query language. Besides querying of data SQL also provides extensive
functionality for transforming data. In particular, SQL enable the
transformation of data it into different structures, or generating outputs like
XML and JSON. XML and JSON formats within SQL databases.

### Structural Data Transformation in SQL

SQL provides several features to transform and reorganize data structures,
allowing you to reshape tables, combine data, and create complex queries. The
following introduces a small selection of those features.

#### Joins: Combining Data from Multiple Tables

One of SQL’s most powerful features is the ability to combine data from
multiple tables using **joins**. Joins allow you to merge tables based on
related keys, enabling you to retrieve and analyze data across different
datasets.

- **Inner Join**: Returns rows when there is a match in both tables.
- **Left Join (Outer Join)**: Returns all rows from the left table and matched
  rows from the right table. Non-matching rows from the right table return
  `NULL`.
- **Right Join (Outer Join)**: Returns all rows from the right table and
  matched rows from the left table.
- **Full Outer Join**: Returns rows when there is a match in either table or
  both.

##### Example: Joining Products with Categories

```sql
SELECT p.name, p.price, c.category_name
FROM Products AS p
INNER JOIN Categories AS c
ON p.category_id = c.category_id;
```

This query retrieves product names, prices, and their corresponding category
names by joining the `Products` table with the `Categories` table on a common
`category_id`.

**Result:**

| name          | price | category_name |
| ------------- | ----- | ------------- |
| Mountain Bike | 1200  | Outdoor       |
| Road Bike     | 900   | Outdoor       |
| Laptop        | 1500  | Electronics   |

---

#### Subqueries: Nesting Queries for Flexibility

Subqueries allow you to nest one query inside another. This is useful for
filtering, aggregating, or transforming data when conditions depend on values
from a secondary query.

There are two types of subqueries:

- **Scalar Subquery**: Returns a single value and is typically used in the
  `SELECT` list or `WHERE` clause.
- **Table Subquery**: Returns a result set and is used within the `FROM`
  clause.

##### Example: Using a Subquery to Filter Data

```sql
SELECT name, price
FROM Products
WHERE price > (SELECT AVG(price) FROM Products);
```

This query retrieves all products that have a price greater than the average price of all products.

**Result:**

| name          | price |
| ------------- | ----- |
| Mountain Bike | 1200  |
| Laptop        | 1500  |

---

#### Common Table Expressions (CTEs)

**CTEs (Common Table Expressions)** provide a way to structure complex queries
by breaking them into smaller, more manageable parts. They are particularly
useful for recursion and hierarchical data querying.

CTEs are defined using the `WITH` clause and can be referenced multiple times
within the main query.

##### Example: Using CTE for Improved Readability

```sql
WITH SalesSummary AS (
  SELECT category_id, SUM(price) AS total_sales
  FROM Products
  GROUP BY category_id
)
SELECT c.category_name, s.total_sales
FROM SalesSummary s
INNER JOIN Categories c
ON s.category_id = c.category_id;
```

This query calculates total sales by category using a CTE to simplify the query structure.

**Result:**

| category_name | total_sales |
| ------------- | ----------- |
| Outdoor       | 2100        |
| Electronics   | 1500        |

#### PIVOT: Reshaping Data for Analysis

The **`PIVOT`** feature allows you to transform rows into columns, making it
easier to summarize and analyze data, especially when dealing with categorical
data.

##### Example: Pivoting Sales Data by Category

```sql
SELECT *
FROM (
  SELECT category_id, price FROM Products
) AS SourceTable
PIVOT (
  SUM(price) FOR category_id IN ([1], [2], [3])
) AS PivotTable;
```

This query reshapes the product price data by category, making each category a separate column.

**Result:**

| 1    | 2   | 3    |
| ---- | --- | ---- |
| 1200 | 900 | 1500 |

### SQL Features for Summarizing and Analyzing Data

Once data is transformed into the desired structure, SQL provides a rich set of
functions for summarizing and analyzing the data. These include aggregate
functions, grouping, and window functions.

#### Aggregate Functions for Summarization

SQL’s aggregate functions provide powerful tools for summarizing data:

- **`COUNT()`**: Counts rows or non-null values.
- **`SUM()`**: Sums numeric values.
- **`AVG()`**: Calculates the average of a numeric column.
- **`MAX()` and `MIN()`**: Return the highest and lowest values, respectively.

##### Example: Calculating Summary Statistics

```sql
SELECT category_id, COUNT(*) AS total_products, AVG(price) AS avg_price, SUM(price) AS total_sales
FROM Products
GROUP BY category_id;
```

This query calculates the total number of products, average price, and total sales for each category.

**Result:**

| category_id | total_products | avg_price | total_sales |
| ----------- | -------------- | --------- | ----------- |
| 1           | 3              | 1000.00   | 3000.00     |
| 2           | 2              | 750.00    | 1500.00     |

---

#### Window Functions for Advanced Analysis

Window functions allow calculations across a set of table rows that are related
to the current row. They are useful for running totals, ranking, and other
complex analytical queries.

##### Example: Ranking Products by Price

```sql
SELECT name, price, RANK() OVER (ORDER BY price DESC) AS rank
FROM Products;
```

This query ranks products based on their price in descending order.

**Result:**

| name       | price | rank |
| ---------- | ----- | ---- |
| Laptop     | 1500  | 1    |
| Smartphone | 1000  | 2    |
| Headphones | 200   | 3    |

---

### Special SQL Features for XML and JSON Transformation

In addition to structural and analytical transformations, modern SQL databases
support features for working with **XML** and **JSON** data, which are
essential for integration with web services, APIs, and other applications.

#### Transforming Data into XML

SQL supports converting relational data into **XML** format, which is widely
used for data exchange.

##### Key SQL XML Features:

- **`FOR XML`**: Converts query results into XML format.
- **`XML PATH()`**: Allows for custom XML element structure.
- **`XMLQUERY()`**: Extracts data from XML columns using XPath-like expressions.

##### Example: Transforming Data into XML

```sql
SELECT id, name, price
FROM Products
FOR XML PATH('product'), ROOT('products');
```

**Resulting XML:**

```xml
<products>
  <product>
    <id>1</id>
    <name>Mountain Bike</name>
    <price>1200</price>
  </product>
  <product>
    <id>2</id>
    <name>Helmet</name>
    <price>50</price>
  </product>
</products>
```

---

#### Transforming Data into JSON

SQL also allows you to convert relational data into **JSON** format, which is
commonly used in modern web applications.

##### Key SQL JSON Features:

- **`FOR JSON`**: Converts query results into JSON format.
- **`JSON_VALUE()`**: Extracts scalar values from JSON columns.
- **`OPENJSON()`**: Parses JSON data into relational format.

##### Example: Transforming Data into JSON

```sql
SELECT id, name, price
FROM Products
FOR JSON AUTO;
```

**Resulting JSON:**

```json
[
  {
    "id": 1,
    "name": "Mountain Bike",
    "price": 1200
  },
  {
    "id": 2,
    "name": "Helmet",
    "price": 50
  }
]
```

## XSLT: Transforming XML for Data Integration

**XSLT (Extensible Stylesheet Language Transformations)** is a powerful
language specifically designed for transforming XML documents. In the context
of data integration, XSLT enables the transformation of data from one XML
schema to another, facilitating data exchange between different systems. It is
particularly useful when integrating systems that rely on structured XML data,
allowing for seamless translation and mapping between diverse data formats.

While XSLT is often used for generating HTML, its primary purpose in data
integration is to transform XML data into other structured formats like another
XML schema, JSON, or plain text. XSLT operates by applying transformation rules
defined in templates, using XPath expressions to select and manipulate parts of
the XML document.

### Key Features of XSLT for Data Integration

#### Template-Based Transformation

- **Templates** define how to transform specific elements in an XML document.
- XSLT uses the `<xsl:apply-templates>` instruction to process XML elements
  based on templates.
- The `<xsl:value-of>` instruction retrieves the text value of XML elements and
  attributes, allowing precise control over how data is extracted and
  transformed.

##### Example: Basic XML Transformation

This example shows how to transform an XML structure from one schema to another.

**Input XML:**

```xml
<Products>
  <Product>
    <Name>Mountain Bike</Name>
    <Price>1200</Price>
  </Product>
  <Product>
    <Name>Helmet</Name>
    <Price>50</Price>
  </Product>
</Products>
```

**XSLT:**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Step 1: Match the root node and apply templates -->
  <xsl:template match="/">
    <TransformedData>
      <xsl:apply-templates select="Products/Product" />
    </TransformedData>
  </xsl:template>

  <!-- Step 2: Match each Product element -->
  <xsl:template match="Product">
    <Item>
      <Name><xsl:value-of select="Name" /></Name>
      <Price><xsl:value-of select="Price" /></Price>
    </Item>
  </xsl:template>

</xsl:stylesheet>
```

**Output XML:**

```xml
<TransformedData>
  <Item>
    <Name>Mountain Bike</Name>
    <Price>1200</Price>
  </Item>
  <Item>
    <Name>Helmet</Name>
    <Price>50</Price>
  </Item>
</TransformedData>
```

**Explanation:**

1. The XSLT starts by matching the root node (`/`), creating a new
   `<TransformedData>` element.
2. It uses the `<xsl:apply-templates>` instruction to apply templates to all
   `Product` elements.
3. The template for each `Product` creates a new `<Item>` element, copying the
   `Name` and `Price` using `<xsl:value-of>`.

---

#### Conditional Logic and Control Structures

- XSLT provides conditional structures like `<xsl:if>` and `<xsl:choose>`,
  enabling selective transformation based on the data content.
- These features are useful in integration scenarios where some parts of the
  XML may need to be transformed differently based on specific conditions.

##### Example: Conditional Data Transformation

This example only includes the `Price` element in the output if the price is
greater than 100.

**XSLT with Conditional Logic:**

```xml
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <TransformedData>
      <xsl:apply-templates select="Products/Product" />
    </TransformedData>
  </xsl:template>

  <xsl:template match="Product">
    <Item>
      <Name><xsl:value-of select="Name" /></Name>
      <xsl:if test="Price > 100">
        <Price><xsl:value-of select="Price" /></Price>
      </xsl:if>
    </Item>
  </xsl:template>

</xsl:stylesheet>
```

**Explanation:**

- The template for `Product` uses `<xsl:if>` to include the `Price` element
  only if the value is greater than 100.
- This allows for selective transformation based on data conditions, which is
  often needed in integration scenarios.

---

#### Data Aggregation and Sorting

- **`xsl:for-each`** allows looping over elements to transform multiple parts
  of the XML document.
- **`xsl:sort`** enables sorting of the XML data before it is transformed.

##### Example: Sorting Products by Price

This example demonstrates how to sort products by price before transforming them.

```xml
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <TransformedData>
      <xsl:for-each select="Products/Product">
        <xsl:sort select="Price" order="ascending" />
        <Item>
          <Name><xsl:value-of select="Name" /></Name>
          <Price><xsl:value-of select="Price" /></Price>
        </Item>
      </xsl:for-each>
    </TransformedData>
  </xsl:template>

</xsl:stylesheet>
```

**Explanation:**

- The `<xsl:for-each>` loops over each `Product` element.
- The `<xsl:sort>` sorts the products by their `Price` in ascending order
  before transforming them.

### XML-to-JSON Transformation with XSLT

As XSLT is a general purpos transformation language, it can not only be used
to transform XML to XML documents. It is, for example, also possible to
convert an XML document to JSON,

#### Example: XML-to-JSON Transformation

Given the following XML:

**Input XML:**

```xml
<Products>
  <Product>
    <Name>Mountain Bike</Name>
    <Price>1200</Price>
  </Product>
  <Product>
    <Name>Helmet</Name>
    <Price>50</Price>
  </Product>
</Products>
```

We can transform this XML into JSON using the following XSLT:

```xml
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- Specify text output for JSON format -->
  <xsl:output method="text" />

  <!-- Template for root node -->
  <xsl:template match="/">
    {
      "products": [
        <xsl:for-each select="Products/Product">
          {
            "name": "<xsl:value-of select='Name'/>",
            "price": <xsl:value-of select='Price'/>
          }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
      ]
    }
  </xsl:template>
</xsl:stylesheet>
```

**Explanation:**

- The XSLT manually constructs JSON by treating it as plain text, looping
  through the `Product` elements, and formatting them according to JSON syntax.
- The `<xsl:if>` is used to add the necessary comma to separate the products.

**Output JSON:**

```json
{
  "products": [
    {
      "name": "Mountain Bike",
      "price": 1200
    },
    {
      "name": "Helmet",
      "price": 50
    }
  ]
}
```

#### Built-in `fn:xml-to-json` Function in XSLT 3.0

Starting with **XSLT 3.0**, the `fn:xml-to-json()` function provides a built-in mechanism to transform XML to JSON directly, without needing to manually format the output. This function makes the transformation process simpler and ensures that the resulting JSON is well-formed.

```xsl
fn:xml-to-json($input-node, $options)
```

- **$input-node**: The XML node or subtree that you want to convert to JSON.
- **$options**: Optional parameter that defines how specific elements or
  attributes should be handled in the conversion (e.g., pretty-printing, or
  special handling for certain node types).

Let’s take the same XML input and use `fn:xml-to-json()` to generate JSON.

**Input XML:**

```xml
<Products>
  <Product>
    <Name>Mountain Bike</Name>
    <Price>1200</Price>
  </Product>
  <Product>
    <Name>Helmet</Name>
    <Price>50</Price>
  </Product>
</Products>
```

**XSLT Using `fn:xml-to-json`:**

```xml
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:map="http://www.w3.org/2005/xpath-functions/map">

  <!-- Specify text output for JSON format -->
  <xsl:output method="text" />

  <!-- Template for root node -->
  <xsl:template match="/">
    <!-- Convert the input XML to JSON -->
    <xsl:value-of select="fn:xml-to-json(.)" />
  </xsl:template>

</xsl:stylesheet>
```

**Output JSON:**

```json
{
  "Products": {
    "Product": [
      {
        "Name": "Mountain Bike",
        "Price": 1200
      },
      {
        "Name": "Helmet",
        "Price": 50
      }
    ]
  }
}
```

**Explanation:**

- The `fn:xml-to-json(.)` function converts the entire XML structure into JSON.
- The result automatically formats the XML tree into the equivalent JSON format.

You can customize the output further using the optional **$options** parameter.
For instance, you can control whether attributes should be included, whether to
pretty-print the JSON, and how certain elements should be handled.

#### Built-in `fn:json-to-xml` Function in XSLT 3.0

Similarly, XSLT 3.0 introduced the `fn:json-to-xml()` function, which enables
you to convert **JSON data into XML**. This is particularly useful when
integrating with systems that provide data in JSON format but require it to be
processed or transformed into XML.

#### Syntax of `fn:json-to-xml`

```xsl
fn:json-to-xml($json-string)
```

- **$json-string**: The input JSON data in string format, which will be
  converted into XML.

#### Example: Using `fn:json-to-xml`

Let’s take the JSON format and convert it to XML using `fn:json-to-xml()`.

**Input JSON:**

```json
{
  "Products": {
    "Product": [
      {
        "Name": "Mountain Bike",
        "Price": 1200
      },
      {
        "Name": "Helmet",
        "Price": 50
      }
    ]
  }
}
```

**XSLT Using `fn:json-to-xml`:**

```xml
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="yes"/>

  <!-- Template for root node -->
  <xsl:template match="/">
    <!-- Convert the input JSON string to XML -->
    <xsl:variable name="json-input" select="'{ &quot;Products&quot;: { &quot;Product&quot;: [ { &quot;Name&quot;: &quot;Mountain Bike&quot;, &quot;Price&quot;: 1200 }, { &quot;Name&quot;: &quot;Helmet&quot;, &quot;Price&quot;: 50 } ] } }'" />
    <xsl:copy-of select="fn:json-to-xml($json-input)" />
  </xsl:template>

</xsl:stylesheet>
```

**Output XML:**

```xml
<map:map xmlns:map="http://www.w3.org/2005/xpath-functions">
   <map:string key="Products">
      <map:map>
         <map:string key="Product">
            <map:array>
               <map:map>
                  <map:string key="Name">Mountain Bike</map:string>
                  <map:number key="Price">1200</map:number>
               </map:map>
               <map:map>
                  <map:string key="Name">Helmet</map:string>
                  <map:number key="Price">50</map:number>
               </map:map>
            </map:array>
         </map:string>
      </map:map>
   </map:string>
</map:map>
```

**Explanation:**

- The **JSON string** is passed into `fn:json-to-xml()`, which converts it into
  an XML representation.
- The resulting XML is namespaced under `map:`, representing the structure of
  the JSON data.

This XML can then be further processed using XSLT for any required transformations.

### More Complex Example: Using Advanced XPath Constructs

This example demonstrates the use of **XPath predicates** and more complex
selection logic.

**Input XML:**

```xml
<Orders>
  <Order id="001">
    <Customer>John Doe</Customer>
    <Items>
      <Item>
        <Name>Mountain Bike</Name>
        <Price>1200</Price>
        <Quantity>2</Quantity>
      </Item>
      <Item>
        <Name>Helmet</Name>
        <Price>50</Price>
        <Quantity>1</Quantity>
      </Item>
    </Items>
  </Order>
  <Order id="002">
    <Customer>Jane Smith</Customer>
    <Items>
      <Item>
        <Name>Smartphone</Name>
        <Price>700</Price>
        <Quantity>1</Quantity>
      </Item>
    </Items>
  </Order>
</Orders>
```

**Task:** Transform this XML to include only those `Item` elements where the
total price (`Price * Quantity`) exceeds 1000.

**XSLT:**

```xml
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <FilteredOrders>
      <xsl:apply-templates select="Orders/Order" />
    </FilteredOrders>
  </xsl:template>

  <xsl:template match="Order">
    <Order id="{@id}">
      <Customer><xsl:value-of select="Customer" /></Customer>
      <xsl:apply-templates select="Items/Item[Price * Quantity &gt; 1000]" />
    </Order>
  </xsl:template>

  <xsl:template match="Item">
    <Item>
      <Name><xsl:value-of select="Name" /></Name>
      <TotalPrice><xsl:value-of select="Price * Quantity" /></TotalPrice>
    </Item>
  </xsl:template>

</xsl:stylesheet>
```

**Explanation:**

- The XPath expression `Items/Item[Price * Quantity &gt; 1000]` filters out
  `Item` elements whose total price (price multiplied by quantity) is less than
  or equal to 1000.
- The total price is calculated and output as `<TotalPrice>` in the resulting
  XML.

**Output XML:**

```xml
<FilteredOrders>
  <Order id="001">
    <Customer>John Doe</Customer>
    <Item>
      <Name>Mountain Bike</Name>
      <TotalPrice>2400</TotalPrice>
    </Item>
  </Order>
  <Order id="002">
      <Customer>Jane Smith</Customer>
   </Order>
</FilteredOrders>
```

### Exercises

#### Exercise 1: XML-to-XML Transformation

You are given the following XML representing a company’s product catalog:

**Input XML:**

```xml
<Company>
  <Products>
    <Product>
      <ProductName>Smartphone</ProductName>
      <Price currency="USD">700</Price>
    </Product>
    <Product>
      <ProductName>Laptop</ProductName>
      <Price currency="USD">1500</Price>
    </Product>
  </Products>
</Company>
```

Write an XSLT stylesheet that transforms this XML into the following structure:

**Expected Output XML:**

```xml
<ProductCatalog>
  <Item>
    <Name>Smartphone</Name>
    <Cost>700</Cost>
  </Item>
  <Item>
    <Name>Laptop</Name>
    <Cost>1500</Cost>
  </Item>
</ProductCatalog>
```

#### Exercise 2: XML-to-JSON Transformation

Given the same product catalog XML from Exercise 1, write an XSLT stylesheet to transform it into JSON format as follows:

**Expected Output JSON:**

```json
{
  "catalog": [
    {
      "name": "Smartphone",
      "price": 700
    },
    {
      "name": "Laptop",
      "price": 1500
    }
  ]
}
```

### Key Takeaways

- **XSLT** is a versatile tool for transforming XML data, which can be crucial
  in integrating systems with different data formats.
- **Template-based transformation** allows selective processing of elements,
  while **conditional logic** and **looping** provide control over how data is
  structured in the output.
- XSLT can handle both **XML-to-XML transformations** and **XML-to-JSON
  conversions**, making it an essential part of modern data integration
  workflows.
- Using **advanced XPath expressions**, you can apply complex filtering and
  transformations, such as selecting elements based on calculated conditions.

## Navigation

🏠 [Overview](../README.md) | [< Previous Chapter](./query-languages.md) | [Next
Chapter >](./protocols.md)
