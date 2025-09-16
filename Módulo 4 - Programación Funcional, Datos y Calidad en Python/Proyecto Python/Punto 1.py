import itertools
from datetime import datetime

# Defino las constantes
letras = 'ABCDE'
digitos = '45678'

# Generar todas las combinaciones posibles
comb_letras = itertools.product(letras, repeat=2) # 2 letras
comb_digitos = itertools.product(digitos, repeat=6) # 6 digitos

# Calcula todas las combinaciones posibles
combinaciones = []
for letra, digito in itertools.product(comb_letras, comb_digitos):
    pasaporte = 'PAS-{}{}{}'.format(''.join(letra), ''.join(digito), ''.join(datetime.now().strftime('%H%M')))
    combinaciones.append(pasaporte)

# Cuenta el total de combinaciones
total = len(combinaciones)
print("El total de combinaciones posibles es: ", total)
