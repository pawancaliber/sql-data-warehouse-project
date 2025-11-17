/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/
	Truncate table bronze.crm_cst_info;
	Bulk insert bronze.crm_cst_info
	from 'D:\Study Material\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	with(
		Firstrow = 2,
		Fieldterminator = ',',
		tablock
	);

	Truncate table bronze.crm_prd_info;
	Bulk insert bronze.crm_prd_info
	from 'D:\Study Material\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	with(
		Firstrow = 2,
		Fieldterminator = ',',
		tablock
	);

	Truncate Table bronze.crm_sales_details;
	Bulk insert bronze.crm_sales_details
	from 'D:\Study Material\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	with(
		Firstrow =2,
		Fieldterminator = ',',
		tablock
	);

	Truncate Table bronze.erp_cust_az12;
	Bulk insert bronze.erp_cust_az12
	from 'D:\Study Material\SQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	with(
		Firstrow = 2,
		Fieldterminator = ',',
		tablock
	);

	Truncate table bronze.erp_loc_a101;
	Bulk insert bronze.erp_loc_a101
	from 'D:\Study Material\SQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	with(
		Firstrow = 2,
		Fieldterminator = ',',
		tablock
	);

	Truncate Table bronze.erp_px_cat_g1v2;
	Bulk insert bronze.erp_px_cat_g1v2
	from 'D:\Study Material\SQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
	with(
		Firstrow = 2,
		Fieldterminator = ',',
		tablock
	);
