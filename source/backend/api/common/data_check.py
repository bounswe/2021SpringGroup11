def check_data_keys(data: dict, necessary_keys: dict) -> str:
    # will be fixed

    for key in necessary_keys:
        if key not in data.keys():
            return f'Missing key {key}'
    
    return ''
