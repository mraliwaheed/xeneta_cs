### xeneta_cs
Download Package xeneta_cs.
In Final.ipynb and models script adjust the path as your directory.

### How to run the package:
Method 1:
Run file "Final.ipynb" or Final.py from xeneta_cs\python

Method 2:
Open cmd, come to you required directory
Run models with command:
     run each model one by one with command: dbt run --select model_name

## what does package do?
1. Loads data from csv files to duckdb
2. Transforms data to staging schema
3. Transforms data to final schema
4. Creates 1 views: for reporting or metadata purpose


## NOTE
if you will run the code from Final.ipynb you will need to install duckdb and dbt package.
Running code from final will copy files from "xeneta_cs\data\files_to_load\input_files" to "\xeneta_cs\data\files_to_load\input_files\loaded" with date folder inside to make sure whihc file is uploaded.
To check the batch processing or data loadin with each pair of new coming files you just need to place the files in the "xeneta_cs\data\files_to_load\input_files" folder.
Runing models from cmd will not copy files to uploaded folder after execution of model.
For new files like DE_casestudy_charges_*.csv and DE_casestudy_datapoints_*.csv, you need to place them in the "xeneta_cs\data\files_to_load\input_files" folder and run Final.ipynb or run model by dbt. Required files will be loaded to the database and process the data including new files automaticaly.
Initial there will be no db in "\xeneta_cs\db" but when you will run the package it will be created.

## Quereies for data team
 2 queries are provided in the package as required, 
 1st is for data team:
    Provide a few example queries to the data users. For example, how can they get the average container shipping price of equipment type _2_ from China East Main region to US West Coast region?
    you can fetch the data as per your choice, just update he paremeter like "equipment_type", "origin_region", "destination_region" in sql queryys.
 2nd is for data scientist:
    Our Data Scientists want to keep an eye on how data coverage is developing with new data imports of contracts.

## For better understanding of the package I am also including process flow of the package:

Estimated Timespent of the Assignment:
Project Initialization and Data Loading: 5-6 hours
Data Transformation in Staging Schema: 11-12 hours
Final Aggregated Table and Queries : 6-8 hours
Metadata Tracking and DBT Hooks: 2-3 hours
Python Script for Automation: 4 hours
Testing, Validation, and Documentation: 5 hours