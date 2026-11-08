return {
	s('pyin', {
		t({ 'nama = input("' }),
		i(1, 'Masukkan nama'),
		t({ '")' }),
		i(0),
	}),

	s('pyint', {
		t({ 'nilai = int(input("' }),
		i(1, 'Masukkan nilai'),
		t({ '"))' }),
		i(0),
	}),

	s('pyflt', {
		t({ 'nilai = float(input("' }),
		i(1, 'Masukkan nilai'),
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
		i(1, 'kondisi'),
		t({ ':', '    ' }),
		i(2, 'pass'),
		t({ 'else:', '    ' }),
		i(3, 'pass'),
		i(0),
	}),

	s('pygrd', {
		t({
			'if nilai >= 85:',
			"    grade = 'A'",
			'elif nilai >= 70:',
			"    grade = 'B'",
			'elif nilai >= 60:',
			"    grade = 'C'",
			'elif nilai >= 50:',
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
		i(1, 'kondisi'),
		t({ ':', '    ' }),
		i(2, 'pass'),
		i(0),
	}),

	s('pywht', {
		t({ 'while True:', '    ' }),
		i(1, 'pass'),
		t({ '    if ' }),
		i(2, 'kondisi'),
		t({ ':', '        break' }),
		i(0),
	}),

	s('pytry', {
		t({
			'try:',
			'    ',
		}),
		i(1, 'nilai = int(input("Masukkan nilai: "))'),
		t({
			'except ValueError:',
			'    print("Input bukan angka!")',
		}),
		i(0),
	}),

	s('pyvld', {
		t({
			'nilai = -1',
			'while nilai < 0 or nilai > 100:',
			'    try:',
			'        nilai = int(input("Masukkan nilai (0-100): "))',
			'    except ValueError:',
			'        print("Input bukan angka!")',
			'        continue',
			'    if nilai < 0 or nilai > 100:',
			'        print("Nilai tidak valid!")',
		}),
		i(0),
	}),

	s('pyfn', {
		t({ 'def ' }),
		i(1, 'nama_fungsi'),
		t({ '(' }),
		i(2, 'param'),
		t({ '):', '    return ' }),
		i(3, 'param'),
		i(0),
	}),

	s('pycnt', {
		t({
			'genap = 0',
			'ganjil = 0',
			'for x in data:',
			'    if x % 2 == 0:',
			'        genap += 1',
			'    else:',
			'        ganjil += 1',
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
			'    rata = total / n',
			'    print(f"Rata-rata: {rata:.2f}")',
			'else:',
			'    print("Tidak ada bilangan positif")',
		}),
		i(0),
	}),

	s('pyprm', {
		t({
			'def cek_prima(x):',
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
			'n = int(input("Berapa jumlah data? "))',
			'data = []',
			'for i in range(1, n + 1):',
			'    x = int(input(f"Bilangan ke-{i}: "))',
			'    data.append(x)',
		}),
		i(0),
	}),

	s('pymm', {
		t({
			'maks = data[0]',
			'minim = data[0]',
			'for x in data:',
			'    if x > maks:',
			'        maks = x',
			'    if x < minim:',
			'        minim = x',
		}),
		i(0),
	}),

	s('pymn', {
		t({
			'while True:',
			'    print("1. ...")',
			'    print("2. ...")',
			'    print("3. Keluar")',
			'    pilihan = input("Pilih: ")',
			'    if pilihan == "1":',
			'        pass',
			'    elif pilihan == "3":',
			'        break',
			'    else:',
			'        print("Pilihan tidak valid")',
		}),
		i(0),
	}),

	s('pypln', {
		t({
			'kata = input("Masukkan kata: ").lower()',
			'if kata == kata[::-1]:',
			'    print("Palindrom: Ya")',
			'else:',
			'    print("Palindrom: Tidak")',
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
