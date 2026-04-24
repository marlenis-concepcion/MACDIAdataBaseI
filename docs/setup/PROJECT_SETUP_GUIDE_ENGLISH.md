# Project Setup Guide English

### 1. Purpose

This guide describes a reusable workflow for building a complete academic or portfolio-ready data project from any dataset. The goal is to transform raw data into a structured database solution with documentation, SQL scripts, diagrams, dashboards, and Power BI-ready assets.

The guide can be adapted to different topics such as finance, education, sales, healthcare, government open data, operations, logistics, or any other domain with structured data.

### 2. Expected Final Deliverables

A complete Project X package should include:

- Raw dataset files.
- Cleaned dataset files.
- Data analysis summary.
- Conceptual data model.
- Logical data model.
- Physical data model.
- SQL Server DDL script.
- SQL Server DML script.
- SQL Server DQL analytical queries.
- Stored procedures, triggers, views, and indexes.
- Normalization explanation: 1NF, 2NF, and 3NF.
- Final written report in Markdown and PDF.
- Interactive HTML dashboard.
- Power BI-ready CSV file or model files.
- Power BI setup guide.
- Final presentation.
- README file with full file inventory.

### 3. Recommended Folder Structure

```text
project_x/
├── README.md
├── README.txt
├── PROJECT_X_SETUP_GUIDE_EN_ES.md
├── final_presentation_project_x.pptx
├── assignment/
│   └── project_instructions.pdf
├── data/
│   ├── raw/
│   │   └── original_dataset.csv
│   └── clean/
│       ├── dim_entity.csv
│       └── fact_measure.csv
├── diagrams/
│   ├── 01_conceptual_model.mmd
│   ├── 01_conceptual_model.svg
│   ├── 02_logical_model.mmd
│   ├── 02_logical_model.svg
│   ├── 03_physical_model.mmd
│   └── 03_physical_model.svg
├── document/
│   ├── final_report_project_x.md
│   └── final_report_project_x.pdf
├── dashboard/
│   └── dashboard_project_x.html
├── powerbi/
│   ├── project_x_powerbi_unified.csv
│   └── powerbi_guide.md
├── sql/
│   ├── 00_run_in_order_sqlcmd.sql
│   ├── 01_ddl_project_x.sql
│   ├── 02_dml_project_x.sql
│   ├── 03_dql_project_x.sql
│   ├── 04_programming_sp_triggers_project_x.sql
│   └── 05_complete_master_script_project_x.sql
└── tools/
    └── generation_or_cleaning_scripts
```

### 4. Preconditions

Before starting, the project owner should have:

- A dataset in CSV, XLSX, JSON, TXT, SQL, or another structured format.
- The assignment instructions, if the project is academic.
- Visual Studio Code or another code editor.
- SQL Server access.
- SQL Server extension for Visual Studio Code, such as `SQL Server (mssql)`.
- Permission to create databases, tables, views, stored procedures, and triggers.
- Power BI Desktop, Power BI Service, or access to Power BI through a browser.
- A web browser to open the HTML dashboard.

For macOS users, SQL Server can be accessed through:

- A remote SQL Server instance.
- A virtual machine.
- Docker.
- A university or company database server.
- Visual Studio Code using the `SQL Server (mssql)` extension.

### 5. Required Input From the User

To build the project, collect:

- Student or project owner name.
- Institution or organization.
- Course or project context.
- Instructor or evaluator, if applicable.
- Due date.
- Dataset files.
- Assignment instructions.
- Preferred database engine.
- Required number of queries.
- Required diagrams.
- Required dashboard or BI tool.
- Any specific formatting rules.

### 6. Dataset Review

Start by inspecting the dataset:

- Identify all columns.
- Detect primary entities.
- Review data types.
- Check null values.
- Check duplicates.
- Detect date or period fields.
- Detect numeric measures.
- Detect categorical fields.
- Review encoding and separators.
- Identify data quality issues.

Useful questions:

- What does each row represent?
- What business or academic question can the data answer?
- Which columns are descriptive attributes?
- Which columns are measurable facts?
- Which fields can become dimensions?
- Which fields should become fact tables?

### 7. Data Cleaning

Typical cleaning tasks include:

- Convert files to UTF-8.
- Standardize column names.
- Trim extra spaces.
- Convert numeric text into numeric values.
- Convert dates into valid date formats.
- Standardize category names.
- Merge duplicate entities.
- Remove invalid records or document them.
- Create clean dimension files.
- Create clean fact files.

Cleaned files should be saved separately from the raw files to preserve traceability.

### 8. Data Modeling

The project should include three model levels.

Conceptual model:

- Shows the main entities.
- Shows high-level relationships.
- Avoids technical database details.

Logical model:

- Defines tables.
- Defines primary keys.
- Defines foreign keys.
- Defines attributes.
- Shows one-to-many relationships.

Physical model:

- Defines SQL Server table names.
- Defines data types.
- Defines constraints.
- Defines indexes.
- Defines views.
- Aligns directly with the SQL implementation.

### 9. SQL Server Implementation

Create SQL scripts in the following order.

DDL script:

- Creates the database.
- Creates tables.
- Creates primary keys.
- Creates foreign keys.
- Creates `UNIQUE`, `DEFAULT`, and `CHECK` constraints.
- Creates indexes.
- Creates views.

DML script:

- Inserts dimension data.
- Inserts fact data.
- Includes required updates.
- Preserves referential integrity.

DQL script:

- Includes analytical queries.
- Uses `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`, joins, subqueries, and aggregate functions.
- May include window functions when useful.

Programming script:

- Creates stored procedures.
- Creates triggers.
- Creates audit or history logic.
- Creates validation rules.

Master script:

- Combines the full SQL workflow into one executable file.

### 10. Power BI Setup

Prepare either:

- A single unified CSV file for Power BI Online.
- Or multiple clean CSV files with relationships for Power BI Desktop.

Recommended visuals:

- KPI cards.
- Bar chart.
- Line chart.
- Pie or donut chart.
- Table or matrix.
- Slicers for year, category, region, or entity.

Recommended guide content:

- File to upload.
- Data types to configure.
- Relationships to create.
- DAX measures to add.
- Visuals to build.
- Filters to include.
- Export or presentation steps.

### 11. Dashboard Setup

The HTML dashboard should be self-contained when possible.

It should include:

- Main KPIs.
- Filters.
- At least one ranking chart.
- At least one distribution chart.
- At least one time-based chart if dates exist.
- Summary table.
- No-data messages when filters return empty results.

### 12. Final Report

The final report should include:

- Cover page.
- Introduction.
- Dataset description.
- Data problem statement.
- Data cleaning process.
- Data models.
- SQL implementation.
- DQL query summary.
- Stored procedures and triggers.
- Normalization explanation.
- Dashboard explanation.
- Main findings.
- Conclusions.
- File inventory.

### 13. Final Presentation

The presentation should summarize:

- Project title.
- Context.
- Dataset.
- Cleaning process.
- Data model.
- SQL implementation.
- Analytical queries.
- Stored procedures and triggers.
- Dashboard and Power BI.
- Main findings.
- Conclusions.

### 14. Quality Checklist

Before delivery, verify:

- Raw data is preserved.
- Clean data is available.
- SQL scripts run in order.
- Tables load without errors.
- Foreign keys are valid.
- Queries return meaningful results.
- Stored procedures execute correctly.
- Triggers work as expected.
- Diagrams match the database.
- Dashboard opens correctly.
- Power BI file or guide is usable.
- Final report is complete.
- Presentation is ready.
- README explains the full project.

### 15. Ultra-Detailed Replication Workflow

This section describes, in a generic format, the same full workflow used for the Banco Agricola RD project. It can be reused to build a complete Project X from any dataset.

#### 15.1. Receive and Organize Inputs

Before writing code or SQL, create a clean project folder and organize every input.

Minimum inputs:

- Original dataset.
- Assignment instructions.
- Student or project owner name.
- Institution name.
- Course or project context.
- Due date.
- SQL, dashboard, Power BI, or presentation requirements.

Recommended location:

```text
data/raw/
assignment/
```

Important rule:

```text
Never modify the original dataset directly.
```

The original dataset must remain available for evidence and traceability. Every cleaning step should generate new files under `data/clean/`.

#### 15.2. Configure Local Environment Variables

To avoid personal paths inside code, create two files:

```text
.env.example
.env.local
```

The `.env.example` file is shared with the project as a template.

The `.env.local` file contains real local paths for each computer and must be ignored by Git.

Recommended variables:

```text
PROJECT_DIR=/PATH/TO/project_x
DATA_RAW_DIR=/PATH/TO/project_x/data/raw
DATA_CLEAN_DIR=/PATH/TO/project_x/data/clean
SQL_DIR=/PATH/TO/project_x/sql
DASHBOARD_DIR=/PATH/TO/project_x/dashboard
POWERBI_DIR=/PATH/TO/project_x/powerbi
REPORT_INPUT_PATH=/PATH/TO/project_x/document/final_report.md
REPORT_OUTPUT_PATH=/PATH/TO/project_x/document/final_report.pdf
PRESENTATION_OUTPUT_PATH=/PATH/TO/project_x/final_presentation.pptx
```

Add this to `.gitignore`:

```text
.env.local
.env.*.local
```

This allows every person to configure the project for their own computer without exposing private paths.

#### 15.3. Review the Assignment First

Read the assignment and list exact requirements.

Assignment checklist:

- Required database engine: SQL Server, MySQL, PostgreSQL, or another engine.
- Minimum number of tables.
- Minimum number of queries.
- Whether DDL is required.
- Whether DML is required.
- Whether DQL is required.
- Whether stored procedures are required.
- Whether triggers are required.
- Whether views are required.
- Whether indexes are required.
- Whether normalization is required.
- Whether a dashboard is required.
- Whether Power BI is required.
- Whether a PDF report is required.
- Whether a final presentation is required.

Create a requirement tracking table in the README or report:

```text
Requirement | File Where It Is Covered | Status
```

#### 15.4. Profile the Dataset

Inspect every original file and document:

- Number of rows.
- Number of columns.
- Encoding.
- Separator.
- Date columns.
- Numeric columns.
- Categorical columns.
- Null values.
- Duplicates.
- Repeated entities.
- Possible spelling variations.
- Fields that should be converted to numbers.

Key questions:

- What does one row represent?
- What is the main entity?
- Are there dates or periods?
- Are there amounts, quantities, counts, or measures?
- Are there repeated categories that should be separated?
- Are there repeated customer, product, branch, or region names?

#### 15.5. Define the Topic and Data Problem

The project must explain what problem it solves.

Recommended structure:

```text
This project integrates [topic] data to analyze [main measures] by [main dimensions], making it possible to answer questions about [academic or business objective].
```

Generic example:

```text
This project integrates sales data to analyze revenue, units sold, and customers by period, product, and region, making it possible to identify trends, leading categories, and improvement opportunities.
```

#### 15.6. Design the Cleaning Process

Create a cleaning plan before generating clean data.

Common actions:

- Rename columns consistently.
- Convert text files to UTF-8.
- Trim extra spaces.
- Normalize accents and variants.
- Convert dates.
- Convert numbers with commas or currency symbols.
- Aggregate true duplicates.
- Create surrogate IDs.
- Separate dimensions.
- Separate facts.

Expected output:

```text
data/clean/dim_period.csv
data/clean/dim_entity.csv
data/clean/dim_category.csv
data/clean/fact_transaction.csv
```

Names change depending on the topic, but the logic remains the same.

#### 15.7. Create Dimensions and Facts

Separate descriptive data from measurable data.

Common dimensions:

- Period.
- Customer.
- Product.
- Category.
- Branch.
- Region.
- Department.
- Supplier.
- Destination.

Common facts:

- Sale.
- Loan.
- Payment.
- Movement.
- Academic record.
- Service.
- Inventory.
- Transaction.

Practical rule:

```text
Dimensions describe. Facts measure.
```

Example:

```text
Product dimension: product_id, product_name, category.
Sales fact: sale_id, product_id, period_id, quantity, amount.
```

#### 15.8. Create Diagrams

Create three diagrams.

Conceptual model:

- Main entities.
- High-level relationships.
- No data types.

Logical model:

- Tables.
- Primary keys.
- Foreign keys.
- Attributes.
- One-to-many relationships.

Physical model:

- Final names.
- SQL data types.
- Constraints.
- Indexes.
- Views.

Expected files:

```text
diagrams/01_conceptual_model.mmd
diagrams/01_conceptual_model.svg
diagrams/02_logical_model.mmd
diagrams/02_logical_model.svg
diagrams/03_physical_model.mmd
diagrams/03_physical_model.svg
```

#### 15.9. Create DDL

DDL must build the full database structure.

It should include:

- `CREATE DATABASE`.
- `CREATE TABLE`.
- `PRIMARY KEY`.
- `FOREIGN KEY`.
- `UNIQUE`.
- `DEFAULT`.
- `CHECK`.
- `CREATE INDEX`.
- `CREATE VIEW`.

Recommendation:

```text
DDL should be executable from scratch and recreate the full database.
```

For demos, it can include:

```sql
IF DB_ID(N'DatabaseName') IS NOT NULL
BEGIN
    ALTER DATABASE DatabaseName SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DatabaseName;
END;
GO
```

This makes database resets easier during testing.

#### 15.10. Create DML With Real Data

DML is essential so tables are not empty during the demo.

It should include `INSERT INTO` statements for:

- Dimensions.
- Fact tables.
- Data sources.
- Catalog tables.

It can also include `UPDATE` statements if required by the assignment.

Rules:

- Insert dimensions first.
- Insert facts after dimensions.
- Respect foreign keys.
- Use consistent IDs.
- Load enough records to demonstrate analysis.

Recommended order:

```text
Period
Descriptive entities
Data sources
Facts/transactions
Updates
```

#### 15.11. Create Analytical DQL

DQL proves that the database can answer questions.

Include queries such as:

- Total by year.
- Top 10 by amount.
- Ranking by category.
- Period comparison.
- Grouping by region.
- Averages.
- Maximums and minimums.
- Subqueries.
- `HAVING`.
- `EXISTS`.
- Window functions.

Recommended target:

```text
Create 25 queries unless the assignment requires a different number.
```

#### 15.12. Create Stored Procedures and Triggers

Recommended stored procedures:

- Summary by year.
- Top N entities.
- Query by category.
- Indicators by period.
- Controlled update.

Recommended triggers:

- Change auditing.
- History before update.
- Business-rule validation.

Recommended control tables:

```text
AuditOperation
EntityHistory
```

#### 15.13. Create a Master Script

The master script should run the entire workflow from one file.

It should include:

```text
DDL
DML
Stored procedures
Triggers
Test queries
```

Recommended file:

```text
sql/05_complete_master_script_project_x.sql
```

#### 15.14. Create a Demo Verification Script

This step is critical to avoid surprises.

Create:

```text
sql/06_demo_verification_project_x.sql
```

It should show:

- Record counts by table.
- General totals.
- A Top 10 query.
- Annual or monthly summary.
- View test.
- Stored procedure test.

Recommended query:

```sql
SELECT 'MainTable' AS TableName, COUNT(*) AS Records
FROM dbo.MainTable;
```

And a control query:

```sql
SELECT
    (SELECT COUNT(*) FROM dbo.Dimension1) AS TotalDimension1,
    (SELECT COUNT(*) FROM dbo.Fact1) AS TotalFact1;
```

If any main table returns zero, the demo is not ready.

#### 15.15. Test in SQL Server

Execution order:

```text
01_DDL
02_DML
04_programming_sp_triggers
03_DQL
06_demo_verification
```

Or:

```text
05_complete_master_script
06_demo_verification
```

Verify:

- No syntax errors.
- No foreign key errors.
- Counts are greater than zero.
- Queries return results.
- Procedures execute.
- Triggers work.

#### 15.16. Create the HTML Dashboard

The dashboard should open without complex setup.

It should include:

- KPIs.
- Filters.
- Bar chart.
- Distribution chart.
- Time-based chart if dates exist.
- Results table.
- No-data messages.

Example KPIs:

- Total records.
- Total amount.
- Total quantity.
- Average.
- Top category.

#### 15.17. Prepare Power BI

Create one file:

```text
powerbi/project_x_powerbi_unified.csv
```

Or multiple files:

```text
dim_period.csv
dim_entity.csv
fact_transaction.csv
```

Also create:

```text
powerbi/powerbi_guide.md
```

The guide should explain:

- File to upload.
- Data types.
- Relationships.
- DAX measures.
- Visuals.
- Filters.
- How to export evidence.

#### 15.18. Create the Final Report

The report should tell the full project story.

Recommended sections:

- Cover page.
- Introduction.
- Dataset description.
- Data problem.
- Main variables.
- Cleaning.
- Conceptual model.
- Logical model.
- Physical model.
- SQL implementation.
- DML and data load.
- DQL.
- Stored procedures and triggers.
- Normalization.
- Dashboard.
- Power BI.
- Findings.
- Conclusion.
- File inventory.

#### 15.19. Create the Final Presentation

The presentation should be clear for live delivery.

Recommended structure:

```text
1. Cover
2. Agenda
3. Context
4. Dataset
5. Cleaning
6. Data model
7. SQL Server
8. DQL queries
9. Stored procedures and triggers
10. Dashboard
11. Power BI
12. Findings
13. Conclusions
```

#### 15.20. Prepare the Demo

Before the demo:

- Open SQL Server.
- Verify the connection.
- Run the master script.
- Run the verification script.
- Open the HTML dashboard.
- Open the PDF report.
- Open the presentation.
- Have Power BI ready or screenshots available if Power BI Desktop is not available.

Suggested demo script:

```text
1. Show the original dataset.
2. Show clean data.
3. Show the physical model.
4. Run record counts.
5. Run Top 10 query.
6. Run a stored procedure.
7. Show the dashboard.
8. Show Power BI or the guide.
9. Close with findings.
```

#### 15.21. Portfolio Security Rules

Before publishing:

- Do not include `.env.local`.
- Do not include passwords.
- Do not include personal paths.
- Do not include SQL credentials.
- Do not include private instructor files if not allowed.
- Use `.env.example`.
- Use uppercase variables for paths.

Correct example:

```text
PROJECT_DIR=/PATH/TO/project
```

Example that should not be published:

```text
LOCAL_USER_HOME/Documents/project
```

#### 15.22. Final Delivery Checklist

- [ ] Original dataset saved.
- [ ] Clean data generated.
- [ ] Complete DDL.
- [ ] DML with real inserts.
- [ ] Tables are not empty.
- [ ] DQL tested.
- [ ] Stored procedures tested.
- [ ] Triggers tested.
- [ ] Master script ready.
- [ ] Demo verification script ready.
- [ ] Dashboard opens correctly.
- [ ] Power BI prepared.
- [ ] Final report complete.
- [ ] Presentation ready.
- [ ] `.env.example` included.
- [ ] `.env.local` ignored.
- [ ] README updated.

---
