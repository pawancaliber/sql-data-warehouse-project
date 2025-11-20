
create or alter view gold.dim_customer as
select
	ROW_NUMBER() Over(order by cst_id) as customer_key,
	ci.cst_id As customer_id,
	ci.cst_key As customer_number,
	ci.cst_firstname as first_name,
	ci.cst_lastname as last_name,
	la.CNTRY as country,
	ci.cst_marital_status as marital_status,
	Case when ci.cst_gndr!='N/A' then ci.cst_gndr
		 else Coalesce(ca.GEN,'N/A')
	ENd as gender,
	ca.BDATE as birthdate,
	ci.cst_create_date as create_date
	From silver.crm_cust_info ci
	Left join silver.erp_cust_az12 ca
	on ci.cst_key=ca.CID
	Left join silver.erp_loc_a101 la
	on ci.cst_key=la.CID
	where ci.cst_id is not null;

	------------------------------------------------------------------------

	create view gold.fact_sales as
select
	sd.sls_ord_num As order_number,
	pr.product_key,
	cr.customer_key,
	sd.sls_order_dt as order_date,
	sd.sls_ship_dt as shipping_date,
	sd.sls_due_dt as due_date,
	sd.sls_sales as sales_amount,
	sd.sls_quantity as quantity,
	sd.sls_price as price
from
silver.crm_sales_details sd
Left join gold.dim_products pr
on sd.sls_prd_key=pr.product_number
Left join gold.dim_customer cr
on sd.sls_cust_id=cr.customer_id


--------------------------------------------------------------------------------



create view gold.dim_products as
select
	Row_Number() Over (Order BY pn.prd_start_dt,pn.prd_key) as product_key,
	pn.prd_id as product_id,
	pn.prd_key as product_number,
	pn.prd_nm as product_name,
	pn.cat_id as category_id,
	pc.CAT as category,
	pc.SUB as subcategory,
	pc.MAINTENANCE as maintence,
	pn.prd_cost as cost,
	pn.prd_line as product_line,
	pn.prd_start_dt as start_date
from silver.crm_prd_info pn
left join silver.erp_px_cat_g1v2 pc
on pn.cat_id=pc.ID
where prd_end_dt is null


-------------------------------------------------------------------
