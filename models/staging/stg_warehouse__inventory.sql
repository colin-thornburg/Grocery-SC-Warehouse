SELECT
    product_id,
    warehouse_id,
    CAST(quantity_on_hand AS NUMERIC) as quantity_on_hand,
    CAST(reorder_point AS NUMERIC) as reorder_point,
    CAST(restock_quantity AS NUMERIC) as restock_quantity,
    last_received_date,  -- BigQuery will automatically parse YYYY-MM-DD as DATE
    storage_zone,
    CASE 
        WHEN CAST(quantity_on_hand AS NUMERIC) <= CAST(reorder_point AS NUMERIC) THEN 'Reorder'
        WHEN CAST(quantity_on_hand AS NUMERIC) <= (CAST(reorder_point AS NUMERIC) * 1.5) THEN 'Low'
        ELSE 'Healthy'
    END as stock_status
FROM {{ ref('raw_warehouse_inventory') }}