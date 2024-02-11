The homework is [here](https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/cohorts/2024/03-data-warehouse/homework.md)


Bash script for batch downloading the data:
```bash
for month in {01..12}; do
    url="https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-${month}.parquet"
    echo "Downloading $url"
    wget "$url"
done
```

BQ SQL queries:

```sql
-- CREATE EXTERNAL TAPLE WITH DATA FROM GS
CREATE OR REPLACE EXTERNAL TABLE `earnest-topic-412511.nytaxi_green_taxi.external_2022`
OPTIONS (
  format = 'parquet',
  uris = ['gs://green_taxi_julnow/green_taxi/green_tripdata_2022-*.parquet']
);

-- COUNT elements in table
SELECT COUNT(*)
from earnest-topic-412511.nytaxi_green_taxi.external_2022;

-- CREATE TABLE IN BQ
CREATE OR REPLACE TABLE nytaxi_green_taxi.greendata_2022_non_partitoned AS
SELECT * FROM earnest-topic-412511.nytaxi_green_taxi.external_2022;

-- COUNT DISTINCT PULocationIDs from materialized
SELECT COUNT(DISTINCT(PULocationID))
from nytaxi_green_taxi.greendata_2022_non_partitoned;

-- COUNT DISTINCT PULocationIDs from external
SELECT COUNT(DISTINCT(PULocationID))
from nytaxi_green_taxi.external_2022;

-- COUNT fare_amount = 0
SELECT COUNT(fare_amount)
from nytaxi_green_taxi.greendata_2022_non_partitoned
where fare_amount = 0;

-- order the results by PUlocationID and filter based on lpep_pickup_datetime
CREATE OR REPLACE TABLE nytaxi_green_taxi.greendata_2022_partitoned
  PARTITION BY DATE(lpep_pickup_datetime) 
  CLUSTER BY PUlocationID AS 
SELECT * FROM nytaxi_green_taxi.greendata_2022_non_partitoned;

-- FOR PARTITIONED TABLE
SELECT DISTINCT (PULocationID)
FROM nytaxi_green_taxi.greendata_2022_partitoned
WHERE lpep_pickup_datetime between '2022-06-01' and '2022-06-30';

-- FOR NON-PARTITIONED TABLE
SELECT DISTINCT (PULocationID)
FROM nytaxi_green_taxi.greendata_2022_non_partitoned
WHERE lpep_pickup_datetime between '2022-06-01' and '2022-06-30';
```
