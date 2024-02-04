if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    print(f"Preprocessing: rows with zero passengers: {data['passenger_count'].isin([0]).sum()}")
    
    data = data[(data['passenger_count'] > 0) &(data['trip_distance'] > 0)]
    data.columns = (data.columns
                .str.replace('(?<=[a-z])(?=[A-Z])', '_', regex=True)
                .str.lower()
             )
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    return data



@test
def test_output(output, *args):
    assert output['passenger_count'].isin([0]).sum() == 0
    assert output['trip_distance'].isin([0]).sum() == 0

@test
def test_vendor_ids(output, *args):
    assert output['passenger_count'].isin([1, 2]).count() == len(output['passenger_count'])