def encode_instruction(instruction):
    parts = instruction.split()
    opcode = parts[0].lower()
    print(parts)

    if opcode == 'ld':
        reg1 = int(parts[1][1])
        reg2 = int(parts[2][1])
        return f'0000{reg1:03b}{reg2:02b}'
    elif opcode == 'str':
        return ""
    elif opcode == 'xor':
        reg1 = int(parts[1][1])
        reg2 = int(parts[2][1])
        return f'01000{reg1:02b}{reg2:02b}'
    elif opcode == 'add':
        reg1 = int(parts[1][1])
        reg2 = int(parts[2][1])
        return f'01001{reg1:02b}{reg2:02b}'
    elif opcode == 'sub':
        reg1 = int(parts[1][1])
        reg2 = int(parts[2][1])
        return f'01010{reg1:02b}{reg2:02b}'
    elif opcode == 'sign':
        return ""
    elif opcode == 'flip_bit':
        return ""
# LEFT OFF HERE
    elif opcode == 'mov':
        reg1 = int(parts[1][1])
        reg2 = int(parts[2][1])
        return f'001{reg1:03b}{reg2:03b}'

    elif opcode == 'beq':
        reg1 = int(parts[1][1])
        reg2 = int(parts[2][1])
        return f'110_{reg1:03b}_{reg2:03b}'

    elif opcode == 'brc_comp':
        return '100_0_00000'  # Assuming 'brc_comp' has a fixed encoding

    else:
        raise ValueError(f"Unknown instruction: {instruction}")


def assemble_code(assembly_code):
    machine_code = []
    for instruction in assembly_code.splitlines():
        instruction = instruction.strip()
        # Ignore empty lines and labels
        if instruction and not instruction.endswith(':'):
            machine_code.append(encode_instruction(instruction))
    return machine_code


def read_assembly_file(file_path):
    with open(file_path, 'r') as file:
        return file.read()


def write_machine_code(file_path, machine_code):
    with open(file_path, 'w') as file:
        for code in machine_code:
            file.write(code + '\n')


if __name__ == "__main__":
    assembly_file = 'sample_assembly.txt'
    output_file = 'output.txt'

    assembly_code = read_assembly_file(assembly_file)
    machine_code = assemble_code(assembly_code)
    write_machine_code(output_file, machine_code)
