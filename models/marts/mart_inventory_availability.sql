SELECT
    product_id,
    SUM(quantity_on_hand) as total_available_quantity,
    COUNT(DISTINCT warehouse_id) as stocking_locations,
    STRING_AGG(DISTINCT stock_status) as stock_statuses,
    STRING_AGG(DISTINCT storage_zone, ', ') as storage_zones,
    MIN(last_received_date) as oldest_inventory_date
FROM {{ ref('stg_warehouse__inventory') }}
GROUP BY product_id