def check_data_keys(data: dict, necessary_keys: dict, forbidden_keys: dict) -> str:
    # will be fixed

    for key in necessary_keys:
        if key not in data.keys():
            return f'Missing key {key}'

    for key in data.keys():
        if key in forbidden_keys:
            return f'Forbidden key {key}'

    return ''
