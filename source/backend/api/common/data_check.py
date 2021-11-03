def check_data_keys(data: dict, necessary_keys: dict) -> str:
    for key in data.keys():
        if key not in necessary_keys:
            return f'Redundant key {key}'

    for key in necessary_keys:
        if key not in data.keys():
            return f'Missing key {key}'
    
    return ''
