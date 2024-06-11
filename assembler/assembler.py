import re
def encode_instruction(instruction):
    
    parts = instruction.split()

    opcode = parts[0].lower()
    
 
    def check_bound(num_bit, value):
        upper_bound = 2**num_bit - 1
        if(value < 0 or value > upper_bound):
            print(f'instruction: {instruction} is out of range')
            raise ValueError(f"out of range error: {value} is out of range for instruction: {instruction}. Expected value between 0 and {upper_bound}")
    
    def process_operant(anOperant):
        if(anOperant[0] == 'r' or anOperant[0] == 'R' or anOperant[0] == '#'):
            return int(anOperant[1:])
    
    def get_operand_bit(num_bit_first, num_bit_second=None):
        first_operant = process_operant(parts[1])
        check_bound(num_bit_first, first_operant)
        if num_bit_second is None:
            return f'{first_operant:0{num_bit_first}b}'
        else:
            second_operant = process_operant(parts[2])
            check_bound(num_bit_second, second_operant)
            return f'{first_operant:0{num_bit_first}b}{second_operant:0{num_bit_second}b}'
 
    if opcode == 'ld':
        return f'0000{get_operand_bit(3,2)}'
    elif opcode == 'str':
        return f'0001{get_operand_bit(2,3)}'
    elif opcode == 'xor':
        return f'01000{get_operand_bit(2,2)}'
    elif opcode == 'add':
        return f'01001{get_operand_bit(2,2)}'
    elif opcode == 'sub':
        return f'01010{get_operand_bit(2,2)}'
    elif opcode == 'sign':
        return f'0101100{get_operand_bit(2)}'
    elif opcode == 'flip_bit':
        return f'0101110{get_operand_bit(2)}'
    elif opcode == 'cnt_bits':
        return f'0101101{get_operand_bit(2)}'
    elif opcode == 'addr':
        return f'10000{get_operand_bit(2,2)}'
    elif opcode == 'jump':
        return f'1001{get_operand_bit(5)}'
    elif opcode == 'blt':
        return f'101{get_operand_bit(3,3)}'
    elif opcode == 'beq':
        return f'110{get_operand_bit(3,3)}'
    elif opcode == 'mov':
        return f'001{get_operand_bit(3,3)}'
    elif opcode == 'shift_left':
        return f'0110{get_operand_bit(2,3)}'
    elif opcode == 'shift_right':
        return f'0111{get_operand_bit(2,3)}'
    elif opcode == 'addi':
         return f'1110{get_operand_bit(2,3)}'
    elif opcode == 'subi':
        return f'1111{get_operand_bit(2,3)}'
    elif opcode == 'brc_comp':
        return '100000000'  # Assuming 'brc_comp' has a fixed encoding
    else:
        print("Error instructions: ", instruction)
        raise ValueError(f"Unknown instruction: {opcode}")



def assemble_code(assembly_code):
    line_counter = 0
    machine_code = []
    for instruction in assembly_code.splitlines():

        instruction = re.sub(r'^[\t \x80-\xFF]+', '', instruction)
        if instruction:

            semi_index = instruction.find(':')
            if semi_index != -1:
                print(instruction[:semi_index], " starting at instruction memory: ", line_counter)
                instruction =  re.sub(r'^[\t \x80-\xFF]+', '', instruction[semi_index + 1:])
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
    # assembly_file = 'sample_assembly.txt'
    # output_file = 'output.txt'
    # translate(assembly_file, output_file)
    # translate("p1assembly.txt", "generated_machine_code_p1.txt")

    translate("p2assembly.txt", "../tb1_done_progress/m_p2.txt")
    # translate("unit_test.txt", "bin_unit.txt")

    # assembly_code = read_assembly_file(assembly_file)
    # machine_code = assemble_code(assembly_code)
    # write_machine_code(output_file, machine_code)
