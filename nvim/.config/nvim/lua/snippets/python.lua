return {
	s('pyin', {
		t({ 'name = input("' }),
		i(1, 'Enter name: '),
		t({ '")' }),
		i(0),
	}),

	s('pyint', {
		t({ 'value = int(input("' }),
		i(1, 'Enter a number: '),
		t({ '"))' }),
		i(0),
	}),

	s('pyflt', {
		t({ 'value = float(input("' }),
		i(1, 'Enter a number: '),
		t({ '"))' }),
		i(0),
	}),

	s('pypr', {
		t({ 'print(f"' }),
		i(1, 'Label: {var}'),
		t({ '")' }),
		i(0),
	}),

	s('pyif', {
		t({ 'if ' }),
		i(1, 'condition'),
		t({ ':', '    ' }),
		i(2, 'pass'),
		t({ '', 'else:', '    ' }),
		i(3, 'pass'),
		i(0),
	}),

	s('pygrd', {
		t({
			'if score >= 85:',
			"    grade = 'A'",
			'elif score >= 70:',
			"    grade = 'B'",
			'elif score >= 60:',
			"    grade = 'C'",
			'elif score >= 50:',
			"    grade = 'D'",
			'else:',
			"    grade = 'E'",
		}),
		i(0),
	}),

	s('pyfor', {
		t({ 'for i in range(' }),
		i(1, '1, n + 1'),
		t({ '):', '    ' }),
		i(2, 'pass'),
		i(0),
	}),

	s('pywhl', {
		t({ 'while ' }),
		i(1, 'condition'),
		t({ ':', '    ' }),
		i(2, 'pass'),
		i(0),
	}),

	s('pywht', {
		t({ 'while True:', '    ' }),
		i(1, 'pass'),
		t({ '', '    if ' }),
		i(2, 'condition'),
		t({ ':', '        break' }),
		i(0),
	}),

	s('pytry', {
		t({
			'try:',
			'    ',
		}),
		i(1, 'value = int(input("Enter a number: "))'),
		t({
			'',
			'except ValueError:',
			'    print("Not a number.")',
		}),
		i(0),
	}),

	s('pyvld', {
		t({
			'value = -1',
			'while value < 0 or value > 100:',
			'    try:',
			'        value = int(input("Enter a value (0-100): "))',
			'    except ValueError:',
			'        print("Not a number.")',
			'        continue',
			'    if value < 0 or value > 100:',
			'        print("Value out of range.")',
		}),
		i(0),
	}),

	s('pyfn', {
		t({ 'def ' }),
		i(1, 'function_name'),
		t({ '(' }),
		i(2, 'params'),
		t({ '):', '    return ' }),
		i(3, 'result'),
		i(0),
	}),

	s('pycnt', {
		t({
			'even = 0',
			'odd = 0',
			'for x in data:',
			'    if x % 2 == 0:',
			'        even += 1',
			'    else:',
			'        odd += 1',
		}),
		i(0),
	}),

	s('pysum', {
		t({
			'total = 0',
			'for x in data:',
			'    total += x',
		}),
		i(0),
	}),

	s('pyavg', {
		t({
			'total = 0',
			'n = 0',
			'for x in data:',
			'    if x > 0:',
			'        total += x',
			'        n += 1',
			'if n > 0:',
			'    average = total / n',
			'    print(f"Average: {average:.2f}")',
			'else:',
			'    print("No positive numbers")',
		}),
		i(0),
	}),

	s('pyprm', {
		t({
			'def is_prime(x):',
			'    if x < 2:',
			'        return False',
			'    for p in range(2, x // 2 + 1):',
			'        if x % p == 0:',
			'            return False',
			'    return True',
		}),
		i(0),
	}),

	s('pylst', {
		t({
			'n = int(input("How many items? "))',
			'data = []',
			'for i in range(1, n + 1):',
			'    x = int(input(f"Item {i}: "))',
			'    data.append(x)',
		}),
		i(0),
	}),

	s('pymm', {
		t({
			'maximum = data[0]',
			'minimum = data[0]',
			'for x in data:',
			'    if x > maximum:',
			'        maximum = x',
			'    if x < minimum:',
			'        minimum = x',
		}),
		i(0),
	}),

	s('pymn', {
		t({
			'while True:',
			'    print("1. Add")',
			'    print("2. Show")',
			'    print("3. Exit")',
			'    choice = input("Choose: ")',
			'    if choice == "1":',
			'        pass',
			'    elif choice == "3":',
			'        break',
			'    else:',
			'        print("Invalid choice")',
		}),
		i(0),
	}),

	s('pypln', {
		t({
			'word = input("Enter a word: ").lower()',
			'if word == word[::-1]:',
			'    print("Palindrome: yes")',
			'else:',
			'    print("Palindrome: no")',
		}),
		i(0),
	}),

	s('pymain', {
		t({ 'def main():', '    ' }),
		i(1, 'pass'),
		t({ '', 'if __name__ == "__main__":', '    main()' }),
		i(0),
	}),

	s('pyinp', {
		i(1, 'variable'),
		t({ ' = input("' }),
		i(2, 'prompt'),
		t({ '")' }),
		i(0),
	}),

	s('pydict', {
		t({ 'data = {' }),
		i(1, '"key": value'),
		t({ '}', '', 'for key, value in data.items():', '    ' }),
		i(2, 'pass'),
		i(0),
	}),

	s('pycls', {
		t({ 'class ' }),
		i(1, 'ClassName'),
		t({ ':', '    def __init__(self, ' }),
		i(2, 'attribute'),
		t({ '):', '        self.' }),
		i(3, 'attribute'),
		t({ ' = ' }),
		i(4, 'attribute'),
		t({ '', '    def ' }),
		i(5, 'method'),
		t({ '(self):', '        ' }),
		i(6, 'pass'),
		i(0),
	}),

	s('pysort', {
		t({
			'data.sort()               # ascending',
			'data.sort(reverse=True)   # descending',
			'ordered = sorted(data)    # returns a copy',
		}),
		i(0),
	}),

	s('pylc', {
		t({ 'result = [' }),
		i(1, 'x'),
		t({ ' for ' }),
		i(2, 'x'),
		t({ ' in ' }),
		i(3, 'data'),
		t({ ' if ' }),
		i(4, 'condition'),
		t({ ']' }),
		i(0),
	}),

	s('pyread', {
		t({ 'with open("' }),
		i(1, 'file.txt'),
		t({ '", "r") as f:', '    ' }),
		i(2, 'content = f.read()'),
		i(0),
	}),

	s('pywr', {
		t({ 'with open("' }),
		i(1, 'file.txt'),
		t({ '", "w") as f:', '    f.write(' }),
		i(2, '"text"'),
		t({ ')' }),
		i(0),
	}),

	s('pyswap', {
		t({ 'a, b = b, a' }),
		i(0),
	}),
}
