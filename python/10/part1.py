inp = 'XXXXXXXX'

# Loop 40 times
for i in xrange(40):
    new_sequence = ''
    # Prime it with the first letter
    prev_char = inp[0]
    # Number of the previous char in a row there's been.
    in_a_row = 1
    # Loop over chars, we can skip the first one
    for char in inp[1:]:
        # Add to the total.
        if char == prev_char:
            in_a_row += 1
            continue
        # Otherwise we need to put it in the new sequence
        else:
            new_sequence += str(in_a_row) + prev_char
            prev_char = char
            in_a_row = 1
    # After the loop is done we need to finish the last number.
    new_sequence += str(in_a_row) + prev_char
    prev_char = char
    in_a_row = 1
    inp = new_sequence

print len(new_sequence)
