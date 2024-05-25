import re
def encode_instruction(instruction):


    parts = instruction.split()
    opcode = parts[0].lower()
    print(parts)

    if opcode == 'ld':
        reg1 = int(parts[1][1])
        reg2 = int(parts[2][1])
        return f'0000{reg1:03b}{reg2:02b}'
    elif opcode == 'str':
        reg1 = int(parts[1][1])
        reg2 = int(parts[2][1])
        return f'0001{reg1:02b}{reg2:03b}'
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
        return f'0101100{int(parts[1][1]):02b}'
    elif opcode == 'flip_bit':
        return f'0101110{int(parts[1][1]):02b}'
    elif opcode == 'cnt_bits':
        return f'0101101{int(parts[1][1]):02b}'
    elif opcode == 'brc_jump':

        return f'1000{int(parts[1][1:]):05b}'
    elif opcode == 'jump':

        return f'1001{int(parts[1][1:]):05b}'
    elif opcode == 'blt':
        return f'101{int(parts[1][1]):03b}{int(parts[2][1]):03b}'
    elif opcode == 'beq':
        reg1 = int(parts[1][1])
        reg2 = int(parts[2][1])
        return f'110{reg1:03b}{reg2:03b}'
    elif opcode == 'mov':
        reg1 = int(parts[1][1])
        reg2 = int(parts[2][1])
        return f'001{reg1:03b}{reg2:03b}'
    elif opcode == 'shift_left':
        return f'0110{int(parts[1][1]):02b}{int(parts[2]):03b}'
    elif opcode == 'shift_right':
        return f'0111{int(parts[1][1]):02b}{int(parts[2]):03b}'
    elif opcode == 'addi':
         return f'1110{int(parts[1][1]):02b}{int(parts[2][1]):03b}'
    
    elif opcode == 'subi':
        reg1 = int(parts[1][1])
        immediate = int(parts[2][1])
        return f'1111{reg1:02b}{immediate:03b}'
    elif opcode == 'brc_comp':
        return '100000000'  # Assuming 'brc_comp' has a fixed encoding

    else:

        print("Error instructions: ", instruction)
        raise ValueError(f"Unknown instruction: {opcode}")

line_counter = 0

def assemble_code(assembly_code):
    global line_counter
    machine_code = []
    for instruction in assembly_code.splitlines():

        instruction = re.sub(r'^[\t \x80-\xFF]+', '', instruction)
        if instruction:
            if instruction.endswith(':'):
                print(instruction[:-1], " starting at instruction memory: ", line_counter)
            else:
                machine_code.append(encode_instruction(instruction))
                line_counter += 1
    return machine_code


def read_assembly_file(file_path):
    with open(file_path, 'r') as file:
        return file.read()


def write_machine_code(file_path, machine_code):
    with open(file_path, 'w') as file:
        for code in machine_code:
            file.write(code + '\n')

def translate(input_file_name, output_file_name):
    assembly_code = read_assembly_file(input_file_name)
    machine_code = assemble_code(assembly_code)
    write_machine_code(output_file_name, machine_code)

if __name__ == "__main__":
    assembly_file = 'sample_assembly.txt'
    output_file = 'output.txt'
    translate(assembly_file, output_file)
    translate("p1assembly.txt", "generated_machine_code_p1.txt")

    # assembly_code = read_assembly_file(assembly_file)
    # machine_code = assemble_code(assembly_code)
    # write_machine_code(output_file, machine_code)
