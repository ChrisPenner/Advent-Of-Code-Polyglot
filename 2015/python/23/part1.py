#!/usr/bin/python
# -*- coding: utf-8 -*-

# author coolharsh55
# Harshvardhan J. Pandit

# registers in the computer
# initial value is set to 0
registers = {
    'a': 0,
    'b': 0,
}

# OP instructions
# take a value, and manipulate it
ins_op = {
    'hlf': lambda x: x // 2,
    'inc': lambda x: x + 1,
    'tpl': lambda x: x * 3,
}

# JMP instructions
# manipulate program counter
ins_jmp = {
    # jump to relative offset
    'jmp': lambda x, y: x + y,
    # jump to relative offset if REG is 1, else increment by 1
    'jio': lambda x, y, z: x + z if registers[y] == 1 else x + 1,
    # jump to relative offset if REG is even, else increment by 1
    'jie': lambda x, y, z: x + z if registers[y] % 2 == 0 else x + 1,
}

# hold program code as instructions
instructions = []

# parse instructions from input file
import re
pattern_single_register = re.compile(r'(inc|hlf|tpl) (\w+)')
pattern_jump = re.compile(r'(jmp) ([+|-]{1}\d+)')
pattern_jump_condn = re.compile(r'(ji[o|e]{1}) (\w+), ([+|-]{1}\d+)')

with open('./input.txt', 'r') as f:

    for line in f.readlines():

        # OP instructions
        match = pattern_single_register.findall(line)
        if match:
            instructions.append(match[0])
            continue
        # JMP instructions
        match = pattern_jump.findall(line)
        if match:
            instruction, offset = match[0]
            instructions.append((instruction, (int(offset),)))
            continue
        # JMP on condition instructions
        match = pattern_jump_condn.findall(line)
        if match:
            match = (match[0][0], (match[0][1], int(match[0][2])))
            instructions.append(match)
# convert instructions to tuple to prevent manipulation of code
instructions = tuple(instructions)

# set program counter to 0
# initial start of program is at 0
program_counter = 0

# continue while program is within code boundaries
# assuming it never goes below zero
# if it does, there'll be a runtime error: IndexOutOfBounds
while(program_counter < len(instructions)):

    # get instruction and value from code
    ins, val = instructions[program_counter]

    # if instruction is OP
    if ins in ins_op.keys():
        # set value of register
        registers[val] = ins_op[ins](registers[val])
        # increment program counter by 1
        # go to next instruction
        program_counter += 1
    # if instruction is JMP
    elif ins in ins_jmp.keys():
        # get value of program counter
        program_counter = ins_jmp[ins](program_counter, *val)


print(registers)
