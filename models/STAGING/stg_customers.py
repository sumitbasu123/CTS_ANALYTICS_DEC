def model(dbt, session):
    stg_customers_df = dbt.source("qwt_raw", "customer")
    return stg_customers_df
