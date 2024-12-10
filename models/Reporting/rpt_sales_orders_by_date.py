import snowflake.snowpark.functions as f

def avg_sales(x,y):
    return y/x


def model(dbt, session):

    dbt.config(materialized= "table" , schema= 'reporting')

    dim_customers_df = dbt.ref('dim_customers')

    fct_orders_df = dbt.ref('fct_orders')
    customer_orders_df = (
                            fct_orders_df
                            .group_by('customerid')
                            .agg(
                            f.min(f.col('orderdate')).alias('first_order_date'),
                            f.max(f.col('orderdate')).alias('recent_order_date'),
                            f.count(f.col('orderid')).alias('total_orders'),
                            f.sum(f.col('linesaleamount')).alias('total_sales'),
                            f.avg(f.col('margin')).alias('avg_margin')
                            )
                        )
    final_df =(
                 dim_customers_df
                                .join(customer_orders_df,customer_orders_df.customerid == dim_customers_df.customerid,'left')
                                .select(
                                dim_customers_df.companyname.alias('companyname'),
                                dim_customers_df.contactname.alias('contactname'),
                                customer_orders_df.first_order_date.alias('first_order_date'),
                                customer_orders_df.recent_order_date.alias('recent_order_date'),
                                customer_orders_df.total_orders.alias('total_orders'),
                                customer_orders_df.total_sales.alias('total_sales'),
                                customer_orders_df.avg_margin.alias('avg_margin')
                                    )
                )
    final_df = final_df.withColumn("avg_sales_value",avg_sales(final_df["total_orders"],final_df["total_sales"]))
    return final_df



    
