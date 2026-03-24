import re
import chardet

def fix_embedded_quotes(line: str) -> str:
    # Replace inner unescaped quotes (not at field boundaries) with doubled quotes
    # This regex targets quotes NOT preceded/followed by comma, newline, or start/end
    return re.sub(r'(?<!^)(?<!,)"(?!,)(?!$)', '""', line.strip())

def process_csv_line(line):
    """
    Parse a CSV line manually, tracking which fields were originally quoted.
    Returns a list of (value, was_quoted) tuples.
    Handles trailing commas that represent empty fields.
    """
    fields = []
    i = 0
    while i < len(line):
        if line[i] == '"':
            # Quoted field — find the closing quote, respecting "" escapes
            i += 1
            field_chars = []
            while i < len(line):
                if line[i] == '"':
                    if i + 1 < len(line) and line[i+1] == '"':
                        field_chars.append('"')  # unescape "" → "
                        i += 2
                    else:
                        i += 1  # closing quote
                        break
                else:
                    field_chars.append(line[i])
                    i += 1
            fields.append((''.join(field_chars), True))
            # skip comma
            if i < len(line) and line[i] == ',':
                i += 1
        else:
            # Convert values like ="01" to "01"
            if line[i] == '=' and i + 1 < len(line) and line[i+1] == '"':
                    i += 2  # skip ="

            # Unquoted field
            end = line.find(',', i)
            if end == -1:
                fields.append((line[i:], False))
                break
            else:
                fields.append((line[i:end], False))
                i = end + 1
    
    # If line ends with a comma, add empty field for trailing column
    if line and line[-1] == ',':
        fields.append(('""', False))
    
    return fields

def csv_fix_quotes(source_path: str, target_path: str, file_name: str) -> str:
    input_path = f"{source_path}/{file_name}"
    output_path = f"{target_path}/{file_name}"

    # Detect encoding
    print(f"Detecting encoding for {file_name}...")
    with open(input_path, 'rb') as f:
        result = chardet.detect(f.read())
        encoding = result['encoding']

    # Clean each line
    print(f"Cleaning quotes in {file_name}...")
    with open(input_path, 'r', newline='', encoding=encoding) as infile:
        lines = infile.readlines()

    with open(output_path, 'w', newline='', encoding=encoding) as outfile:
        for line in lines:
            clean_line = fix_embedded_quotes(line)
            fields = process_csv_line(clean_line)
            out_fields = []
            for value, was_quoted in fields:
                if was_quoted:
                    # Escape any " inside the value as "", then wrap in quotes
                    escaped = value.replace('"', '""')
                    out_fields.append(f'"{escaped}"')
                else:
                    out_fields.append(value)
            outfile.write(','.join(out_fields) + '\n')

    return encoding
