import snowflake.connector


conn = snowflake.connector.connect(
    user='jackdriscoll13',
    password='Mako1234',
    account='QASBFMX.MWA09101',
    warehouse='data_api_wh',
    database='SNOWFLAKE_SAMPLE_DATA',
    schema='TPCDS_SF100TCL'
    )

conn