# Exchange Formats

<!--toc:start-->

- [Exchange Formats](#exchange-formats)
  - [Overview of Exchange Formats](#overview-of-exchange-formats)
  - [Introduction to EDIFACT](#introduction-to-edifact)
    - [Basic building blocks of EDIFACT](#basic-building-blocks-of-edifact)
    - [EDIFACT syntax](#edifact-syntax)
    - [EDIFACT Example: Purchase Order (ORDERS) Message](#edifact-example-purchase-order-orders-message)
    - [EDIFACT semantic](#edifact-semantic)
    - [Exercise: Analyzing an EDIFACT Message](#exercise-analyzing-an-edifact-message)
      - [Message to Analyze](#message-to-analyze)
    - [Key Takeaways](#key-takeaways)
  - [XML](#xml)
  - [JSON](#json)
  - [Navigation](#navigation)
  <!--toc:end-->

## Overview of Exchange Formats

Exchange formats are critical for enabling communication between systems on the
syntax level (cf. Integration levels and tasks). Exchange formats describe the
structure of the data exchanged. Over the years, various formats have emerged,
each tailored to specific integration needs. CSV (Comma-Separated Values), one
of the earliest formats, has been widely used since the 1970s for simple
tabular data transfers, and is still common in data imports and exports between
business systems.

, introduced in early 1980s, is
a standardized format for exchanging business documents, particularly in
logistics and global trade. In 1987 the UN/EDIFACT Syntax Rules were approved
as the ISO standard [ISO 9735](https://www.iso.org/standard/82813.html) by the
International Organization for Standardization.

The EDIFACT standard provides:

- a set of syntax rules to structure data
- an interactive exchange protocol (I-EDI)
- standard messages which allow multi-country and multi-industry exchange.
  While complex, it remains widely used in industries where structured,
  high-volume transactions are required.

With the rise of the internet in the 1990s,
[XML](https://en.wikipedia.org/wiki/XML) became popular for its flexibility and
ability to represent complex, hierarchical data structures. One of the key
ideas of XML was to represent data in a machine and human-readable format. In
1998, the XML 1.0 specification was published by the
[W3C](https://en.wikipedia.org/wiki/World_Wide_Web_Consortium). Today XML is
still prevalent in enterprise systems and document-based workflows as well as
in numerous XML-based standards like e.g.
[SVG](https://en.wikipedia.org/wiki/SVG) or the
[OpenDocument](https://en.wikipedia.org/wiki/OpenDocument) format.

In contrast, [JSON](https://en.wikipedia.org/wiki/JSON), emerging in the early
2000s, offers a lightweight alternative for Web applications. Today, JSON servs
as the de-factor standard format for Web APIs.

In this section we will introduce EDIFACT, XML and JSON in more detail.

## Introduction to EDIFACT

This section gives a basic introduction to [EDIFACT](https://en.wikipedia.org/wiki/EDIFACT).

### Basic building blocks of EDIFACT

EDIFACT messages are composed of several fundamental elements that define the
structure of the message:

1. **Interchange**: This is the outermost envelope of an EDIFACT message and
   includes control information for the entire data exchange.
2. **Segments**: A message is broken into segments, which represent specific data
   elements (e.g., an order number, a date). Each segment begins with a
   three-letter segment tag.
3. **Data Elements**: These are individual fields within segments that contain the
   actual values being exchanged (e.g., a customer ID, a price).
4. **Composite** Data Elements: Some data elements are composite, meaning they
   consist of multiple sub-elements (e.g., a combination of product ID and product
   description).
5. **Separators**: EDIFACT uses specific characters to separate data elements
   (`+`), composite elements (`:`), and segments (`'`).

### EDIFACT syntax

EDIFACT messages contain a hierarchical structure. The top level of the this
structure is the interchange. Each interchange con contain multiple messages.
Each of the messages consist of multiple segments. The following listing show
this principle structure as well as the corresponding segment tags.

```plaintext
|_Service String Advice              UNA  Optional
|____Interchange Header              UNB  Mandatory
     |___Functional Group Header     UNG  Conditional
         |___Message Header          UNH  Mandatory
             |__ User Data Segments       As required
         |__ Message Trailer         UNT  Mandatory
     |__ Functional Group Trailer    UNE  Conditional
|___ Interchange Trailer             UNZ  Mandatory

```

### EDIFACT Example: Purchase Order (ORDERS) Message

Here is a complete EDIFACT message that includes all the necessary components
from the **UNA** segment (defining delimiters) through to the **UNZ** segment
(end of interchange control):

```plaintext
UNA:+.? '
UNB+UNOC:3+SENDERID+RECEIVERID+220101:1200+123456789'
UNH+00000001+ORDERS:D:96A:UN'
BGM+220+PO12345+9'
DTM+137:20240401:102'
NAD+BY+123456789::16'
NAD+SU+987654321::16'
LIN+1++123456:IN'
QTY+21:5'
PRI+INV:1200.00'
UNS+S'
UNT+10+00000001'
UNZ+1+123456789'
```

In the following we analyze each of the segments of the message in details.

1. **UNA (Service String Advice)**:

   - `UNA:+.? '`
     - **UNA** specifies the delimiters used in the message.
     - **+**: Data element separator.
     - **:**: Component element separator.
     - **.**: Decimal notation.
     - **?**: Release character (used to escape delimiters within data).
     - reserved, must be a **space**
     - **'**: Segment terminator.
     - This segment is optional but used when the delimiters differ from the default.

2. **UNB (Interchange Header)**:

   - `UNB+UNOC:3+SENDERID+RECEIVERID+220101:1200+123456789'`
     - **UNB**: Interchange header identifying the sender and receiver.
     - **UNOC:3**: Syntax identifier (UN/EDIFACT with character set level 3).
     - **SENDERID**: The sender’s ID.
     - **RECEIVERID**: The receiver’s ID.
     - **220101:1200**: Date and time of preparation (January 1, 2022, 12:00 PM).
     - **123456789**: Interchange control reference number.

3. **UNH (Message Header)**:

   - `UNH+00000001+ORDERS:D:96A:UN'`
     - **UNH**: Unique message reference number (`00000001`).
     - **ORDERS**: Message type for purchase orders.
     - **D:96A**: EDIFACT directory version (Release 96A).
     - **UN**: Indicates UN/EDIFACT syntax is being used.

4. **BGM (Beginning of Message)**:

   - `BGM+220+PO12345+9'`
     - **BGM**: Identifies the message type.
     - **220**: Function code for an order.
     - **PO12345**: Purchase order number.
     - **9**: Original message related to this transaction.

5. **DTM (Date/Time/Period)**:

   - `DTM+137:20240401:102'`
     - **DTM**: Date/time/period segment.
     - **137**: Qualifier indicating the document date.
     - **20240401**: The date (April 1, 2024).
     - **102**: Date format qualifier (basic date format).

6. **NAD (Name and Address)**:

   - `NAD+BY+123456789::16'`
     - **NAD**: Segment for buyer’s information.
     - **BY**: Buyer code.
     - **123456789**: Buyer’s identification number.
     - **16**: Party identifier qualifier.
   - `NAD+SU+987654321::16'`
     - **NAD**: Segment for supplier’s information.
     - **SU**: Supplier code.
     - **987654321**: Supplier’s identification number.
     - **16**: Party identifier qualifier.

7. **LIN (Line Item)**:

   - `LIN+1++123456:IN'`
     - **LIN**: Line item segment.
     - **1**: Line item number.
     - **123456**: Item number.
     - **IN**: Code qualifier indicating internal product identification.

8. **QTY (Quantity)**:

   - `QTY+21:5'`
     - **QTY**: Segment for specifying quantities.
     - **21**: Quantity qualifier for the ordered quantity.
     - **5**: Ordered quantity.

9. **PRI (Price Details)**:

   - `PRI+INV:1200.00'`
     - **PRI**: Segment for price information.
     - **INV**: Price qualifier (invoice price).
     - **1200.00**: Unit price.

10. **UNS (Section Control)**:

    - `UNS+S'`
      - **UNS**: Indicates the separation between header and detail sections of
        the message.

11. **UNT (Message Trailer)**:

    - `UNT+10+00000001'`
      - **UNT**: Message trailer segment.
      - **10**: The number of segments in the message (excluding the `UNA` and
        `UNB` segments).
      - **00000001**: Message reference number, matching the number in the
        `UNH` segment.

12. **UNZ (Interchange Trailer)**:

    - `UNZ+1+123456789'`
      - **UNZ**: Interchange control trailer.
      - **1**: Number of messages within this interchange.
      - **123456789**: Interchange control reference number, matching the one
        in `UNB`.

### EDIFACT semantic

The semantic of the mesages types and the different segments is defined in code
list. The current code list can be found
[here](https://unece.org/uncefact/unedifact/2021-2023). For example, the
specification of an
[ORDERS](https://service.unece.org/trade/untdid/d23a/trmd/orders_c.htm) message
defines the following structure:

```plaintext
00010   UNH Message header                           M   1
00020   BGM Beginning of message                     M   1
00030   DTM Date/time/period                         M   35
00040   PAI Payment instructions                     C   1
00050   ALI Additional information                   C   5
00060   IMD Item description                         C   999
00070   FTX Free text                                C   99
00080   GIR Related identification numbers           C   10

...

00120       ---- Segment group 2  ------------------ C   99---------------+
00130   NAD Name and address                         M   1                |
00140   LOC Place/location identification            C   99               |
00150   FII Financial institution information        C   5                |
```

The structure shows if a segment is mandatory (M) or optional (C) and the
number of repetitions (e.g. 1, 5 or 999 in the example). Also for each segment,
there is a description of the possible elements and there meaning.

### Exercise: Analyzing an EDIFACT Message

You have received an EDIFACT message from a trading partner, but no additional
information about the message is provided. Your task is to analyze the message,
identify its purpose, and extract key business details such as the involved
parties, monetary amounts, and line items.

#### Message to Analyze

```plaintext
UNB+UNOB:1+SENDER1:1+RECEIVER1:1+071101:1701+131++INVOIC++1++1'
UNG+INVOIC+2:1+3:4+971013:1040+5+UN+D:96A:UN+PASSPORT'
UNH+509010117+INVOIC:D:96A:UN'
BGM+380+IN432097'
DTM+137:20020308:102'
PAI+::42'
RFF+ON:ORD9523'
DTM+171:20020212:102'
RFF+PL:PL99523'
DTM+171:20020101:102'
RFF+DQ:53662'
DTM+171:20020215:102'
NAD+BY+5412345000013::9'
RFF+VA:4146023'
NAD+SU+4012345500004::9'
RFF+VA:VR12345'
NAD+DP+5412345678908::9'
CUX+2:EUR:4'
PAT+1++5:3:M:2'
PAT+22++5:3:D:10'
PCD+12:2.5:13'
ALC+C++6++FC'
MOA+23:120'
TAX+7+VAT+++:::19+S'
MOA+124:22.80'
LIN+1++4000862141404:SRS'
QTY+47:40'
MOA+203:2160'
PRI+AAB:60:CA'
TAX+7+VAT+++:::21+S'
MOA+124:453.60'
ALC+A'
PCD+1:10'
LIN+2++5412345111115:SRS'
QTY+46:5'
QTY+47:12.65:KGM'
MOA+203:2530'
PRI+AAA:200:CA::1:KGM'
TAX+7+VAT+++:::19+S'
MOA+124:480.70'
UNS+S'
CNT+2:2'
MOA+86:5767.10'
MOA+79:4690'
MOA+129:5767.10'
MOA+125:4810'
MOA+176:957.10'
MOA+131:120'
TAX+7+VAT+++:::19+S'
MOA+124:503.50'
TAX+7+VAT+++:::21+S'
MOA+124:453.60'
ALC+C++++FC'
MOA+131:120'
UNT+53+509010117'
UNE+1+5'
UNZ+1+131'
```

Start by examining the **UNH** segment (Message Header) and the **BGM** segment
(Beginning of Message) to determine the type of message you are analyzing.
Afterwards use the [message type
directory](https://service.unece.org/trade/untdid/d23a/trmd/trmdi1.htm) for
further analysis.

Try to answer the following questions:

1. What type of transaction does this message represent?
2. What is the document reference (e.g., invoice number) and when was it
   issued?
3. Who are the sender and receiver of the message? What are their
   identification numbers?
4. What are the monetary amounts involved in this transaction, including taxes?
5. What items are being invoiced, and what are their quantities and unit
   prices?
6. How many messages are included in this interchange?

### Key Takeaways

- EDIFACT provides a robust framework for handling structured business
  transactions at scale.
- Despite its complexity, EDIFACT remains widely used in industries that
  require standardized, high-volume data exchanges, such as logistics, supply
  chain management, and global trade.
- Understanding EDIFACT syntax and its building blocks is essential for
  interpreting and working with legacy systems or industries that rely on this
  format.

## XML

## JSON

## Navigation

🏠 [Overview](../README.md) | [< Previous Chapter](./integration-styles.md) |
[Next Chapter >](./query-languages.md)
