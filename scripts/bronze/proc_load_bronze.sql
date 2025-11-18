/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
Create OR ALTER PROCEDURE bronze.load_bronze AS
Begin
	Declare @start_time Datetime, @end_time Datetime, @batch_start_time Datetime, @batch_end_time Datetime;
	Begin Try
		Set @batch_start_time=getdate();
		Print'=================================';
		Print 'Loading Bronze Layer';
		Print'=================================';
	
		Print'---------------------------------';
		Print'Loading CRM Tables';
		Print'---------------------------------';
		    SET @start_time = getdate();
			PRINT '>> Truncating Table: bronze.crm_cst_info';
			Truncate table bronze.crm_cst_info;
			PRINT '>> Inserting data into: bronze.crm_cst_info';
			Bulk insert bronze.crm_cst_info
			from 'D:\Study Material\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			with(
				Firstrow = 2,
				Fieldterminator = ',',
				tablock
			);
			SET @end_time = getdate();
			Print'>> Load Duration: ' + Cast(Datediff(Second,@start_time,@end_time) As Nvarchar) + 'seconds';
			Print'>> ----------------------------';

			SET @start_time=GETDATE();
			PRINT '>> Truncating Table: bronze.crm_prd_info';
			Truncate table bronze.crm_prd_info;
			PRINT '>> Inserting data into: bronze.crm_prd_info';
			Bulk insert bronze.crm_prd_info
			from 'D:\Study Material\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			with(
				Firstrow = 2,
				Fieldterminator = ',',
				tablock
			);
			Set @end_time=GETDATE();
			Print'>> Load Duration: ' + Cast(Datediff(Second,@start_time,@end_time) As Nvarchar) + 'seconds';
			Print'>> ----------------------------';

			Set @start_time=getdate();
			PRINT '>> Truncating Table: crm_sales_details';
			Truncate Table bronze.crm_sales_details;
			PRINT '>> Inserting data into: bronze.crm_sales_details';
			Bulk insert bronze.crm_sales_details
			from 'D:\Study Material\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			with(
				Firstrow =2,
				Fieldterminator = ',',
				tablock
			);
			Set @end_time=getdate();
			Print'>> Load Duration: ' + Cast(Datediff(Second,@start_time,@end_time) As Nvarchar) + 'seconds';
			Print'>> ----------------------------';

		Print'---------------------------------';
		Print'Loading ERP Tables';
		Print'---------------------------------';
	
            set @start_time=getdate();
			PRINT '>> Truncating Table: bronze.erp_cust_az12';
			Truncate Table bronze.erp_cust_az12;
			PRINT '>> Inserting data into: bronze.erp_cust_az12';
			Bulk insert bronze.erp_cust_az12
			from 'D:\Study Material\SQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
			with(
				Firstrow = 2,
				Fieldterminator = ',',
				tablock
			);
			set @end_time=getdate();
			Print'>> Load Duration: ' + Cast(Datediff(Second,@start_time,@end_time) As Nvarchar) + 'seconds';
			Print'>> ----------------------------';

			Set @start_time = getdate();
			PRINT '>> Truncating Table: bronze.erp_loc_a101';
			Truncate table bronze.erp_loc_a101;
			PRINT '>> Inserting data into: bronze.erp_loc_a101';
			Bulk insert bronze.erp_loc_a101
			from 'D:\Study Material\SQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
			with(
				Firstrow = 2,
				Fieldterminator = ',',
				tablock
			);
			set @end_time=getdate();
			Print'>> Load Duration: ' + Cast(Datediff(Second,@start_time,@end_time) As Nvarchar) + 'seconds';
			Print'>> ----------------------------';

			set @start_time=getdate();
			PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
			Truncate Table bronze.erp_px_cat_g1v2;
			PRINT '>> Inserting data into: bronze.erp_px_cat_g1v2';
			Bulk insert bronze.erp_px_cat_g1v2
			from 'D:\Study Material\SQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
			with(
				Firstrow = 2,
				Fieldterminator = ',',
				tablock
			);
			set @end_time=getdate();
			Print'>> Load Duration: ' + Cast(Datediff(Second,@start_time,@end_time) As Nvarchar) + 'seconds';
			Print'>> ----------------------------';

			set @batch_end_time=getdate();
			Print '=============================================';
			Print ' Loading Bronze Layer is Complete';
			Print ' Total Load Duration ' + cast(datediff(second, @batch_start_time,@batch_end_time)as Nvarchar) + 'seconds';
			Print '=============================================';
		End Try
		Begin CATCH
			Print '=============================================';
			Print 'ERROR OCCURED DURING LOADING BRONZE LAYER';
			Print 'ERROR MESSAGE' + ERROR_MESSAGE();
			Print 'ERROR MESSAGE' + CAST(ERROR_NUMBER() as NVARCHAr);
			Print 'ERROR MESSAGE' + CAST(ERROR_STATE() as NVARCHAr);
			Print '=============================================';
		END CATCH
End
