import time
import math

def extended_gcd(a, b):
    x0, x1, y0, y1 = 1, 0, 0, 1
    while b:
        q, a, b = a // b, b, a % b
        x0, x1 = x1, x0 - q * x1
        y0, y1 = y1, y0 - q * y1
    return a, x0, y0

def encrypt(message, public_key):
    e, n = public_key
    return pow(message, e, n)

def decrypt(ciphertext, private_key):
    d, n = private_key
    return pow(ciphertext, d, n)

def factorize_modulus(n):
    for i in range(2, int(math.sqrt(n)) + 1):
        if n % i == 0:
            return i, n // i
    return None, None

p = int(input("Enter a prime number: "))
q = int(input("Enter another prime number: "))
n = p * q
eulr = (p - 1) * (q - 1)

e = 13
print(f"{e} and {eulr} are co-prime.")

start_time = time.time()

gcd, x, y = extended_gcd(e, eulr)
if gcd == 1:
    d = x % eulr
    if d < 0:
        d += eulr

end_time = time.time()

print(f"Modulus (N): {n}")
print(f"Public key: (n={n}, e={e})")
print(f"Private key: (n={n}, d={d})")
print(f"Runtime: {(end_time - start_time) * 1000} milliseconds")

# Factorize the modulus n back into p and q
factor_p, factor_q = factorize_modulus(n)
if factor_p and factor_q:
    print(f"Factorized modulus: p={factor_p}, q={factor_q}")
else:
    print("Failed to factorize the modulus.")

# Example usage of encryption and decryption
message = int(input("Enter a message to encrypt (as an integer): "))
encrypted = encrypt(message, (e, n))
print(f"Encrypted message: {encrypted}")

decrypted = decrypt(encrypted, (d, n))
print(f"Decrypted message: {decrypted}")
