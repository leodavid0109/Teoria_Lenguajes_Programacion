import itertools
from datetime import datetime

# Define the constraints
letters = 'ABCDE'
digits = '45678'

# Generate all combinations of 2 letters and 6 digits
letter_combinations = itertools.product(letters, repeat=2)
digit_combinations = itertools.product(digits, repeat=6)

# Calculate all possible combinations
all_combinations = ['PAS-' + ''.join(l) + ''.join(d) + '-' + datetime.now().strftime('%H:%M')
                    for l in letter_combinations for d in digit_combinations]

# Return the size of the list
total = len(all_combinations)

print(total)