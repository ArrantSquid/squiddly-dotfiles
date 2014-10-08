#!/usr/bin/env python
# encoding: utf-8
"""Generates a secure password.

.. module:: gen_secure_password.
    :platform: Unix, Linux
        :synopsis: Really basic password generation.

.. moduleauthor:: Johnny P. Neumann <ArrantSquid>

.. note::
    TimeIt output:
        python -mtimeit -s "from gen_secure_password import gen_password" "gen_password(24)"
        10000 loops, best of 3: 143 usec per loop

    cProfile output:
        import cProfile
        pr = cProfile.Profile()
        pr.enable()
        for _ in range(10000):
            gen_password(24)
        pr.disable()
        pr.print_stats()

        4256403 function calls in 2.067 seconds

        Ordered by: standard name

        ncalls  tottime  percall  cumtime  percall filename:lineno(function)
             1    0.000    0.000    0.000    0.000 <stdin>:1(<module>)
         10010    1.029    0.000    2.067    0.000 gen_secure_password.py:34(gen_password)
       1003466    0.352    0.000    0.352    0.000 gen_secure_password.py:62(check_char_type)
        506738    0.400    0.000    0.485    0.000 random.py:272(choice)
             8    0.000    0.000    0.000    0.000 utf_8.py:15(decode)
             8    0.000    0.000    0.000    0.000 {_codecs.utf_8_decode}
       1013476    0.083    0.000    0.083    0.000 {len}
        240240    0.031    0.000    0.031    0.000 {method 'append' of 'list' objects}
             2    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}
         20020    0.010    0.000    0.010    0.000 {method 'join' of 'str' objects}
        506738    0.065    0.000    0.065    0.000 {method 'lower' of 'str' objects}
        506738    0.043    0.000    0.043    0.000 {method 'random' of '_random.Random' objects}
        438946    0.048    0.000    0.048    0.000 {method 'upper' of 'str' objects}
         10012    0.007    0.000    0.007    0.000 {range}

    Based it off of this code I wrote for terseness:
        import string
        from random import choice
        chars = '%s%s%s' % (string.letters, string.digits, string.punctuation)
        gen_password = lambda x: ''.join([choice(chars) for _ in range(x)])
        gen_password(24)

"""
# Built-In
import sys
import string
from random import choice

# Third Party

# Custom

CHARS = '%s%s%s' % (string.letters, string.digits, string.punctuation)

def gen_password(length):
    """Generate a secure password.
	Args:
    	length (str): The length of the password to generate.
    Returns:
		str. The password created.
    """
    tmp_pass = []
    for num in range(length):
        while True:
            tmp = choice(CHARS)
            tmp_type = check_char_type(tmp)
            prev_char_type = None
            if len(tmp_pass) > 0:
                prev_char = tmp_pass[-1]
                prev_char_type = check_char_type(prev_char)
            if tmp.lower() not in tmp_pass and tmp.upper() not in tmp_pass:
                if prev_char_type:
                    if tmp_type != prev_char_type:
                        tmp_pass.append(tmp)
                        break
                else:
                    tmp_pass.append(tmp)
                    break

    print ''.join(tmp_pass)
    return ''.join(tmp_pass)

def check_char_type(char):
    """Checks what the character type is.
	Args:
    	char (str): The character.
    Returns:
		str. The type of character it is.
    """
    if char in string.letters:
        char_type = 'alpha'
    elif char in string.digits:
        char_type = 'integer'
    elif char in string.punctuation:
        char_type = 'punctuation'

    return char_type

def lame_gen(length):
    """Generate a lameass password.
	Args:
    	length (str): The length of the password to generate.
    Returns:
		str. The password created.
    """
    chars = '%s%s%s' % (string.letters, string.digits, string.punctuation)
    gen_password = lambda x: ''.join([choice(chars) for _ in range(x)])
    gen_password(length)
    return gen_password


if __name__ == '__main__':
    if len(sys.argv) < 2:
        sys.exit('You need to specify a password length.')
    try:
        length = int(sys.argv[1])
    except ValueError:
        sys.exit('Only integers are allowed. Try again')
    gen_password(length)
