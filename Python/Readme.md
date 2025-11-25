
# Python Basics - Complete README

## Math Operators (Arithmetic Operators)
Operators used to perform calculations.

| Operator | Example | Meaning |
|---------|---------|---------|
| + | 5 + 3 | Addition |
| - | 5 - 3 | Subtraction |
| * | 5 * 3 | Multiplication |
| / | 5 / 3 | Division (returns float) |
| // | 5 // 3 | Floor division (removes decimal) |
| % | 5 % 3 | Modulus (remainder) |
| ** | 5 ** 3 | Exponentiation |

### Rounding
```
result = 10 + 3.7     
rounded_result = round(result)   # 14
```

---

## Strings
A string is a sequence of characters enclosed in quotes.

```
name = 'hello'
greeting = "Hello World"
number_text = "12345"
password = "@mypassword123!"
```

### Indexing
```
name = "Python"
name[0]   # P
name[1]   # y
name[2]   # t
name[5]   # n
```

### String Methods
```
text.upper()
text.lower()
text.title()
text.capitalize()
text.strip()
text.replace("old", "new")
text.split()
"-".join(list)
text.find("word")
text.count("a")
```

---

## Slicing
Extract part of a string or list.

```
text = "HELLO"
text[1:4]     # ELL
text[:3]      # HEL
text[2:]      # LLO
text[::-1]    # reverse
```

List slicing:
```
lst = [10, 20, 30, 40, 50]
lst[1:4]      # [20, 30, 40]
lst[::-1]     # reversed list
```

---

## Functions
Functions are reusable blocks of code.

---

## Variable Scope
### Local Scope
Variable created inside a function.

### Global Scope
Variable created outside all functions.

```
x = 20   # global

def my_func():
    print(x)

my_func()
print(x)
```

---

## Comparison Operators
```
x == y
x != y
x > y
x < y
x >= y
y <= 2
```

---

## Conditional Statements
### If Statement
```
x = 10
if x > 5:
    print("x is greater than 5")
```

---

## Using del with Lists
```
fruits = ["apple", "banana", "cherry", "mango", "orange"]
del fruits[1]  
del fruits[-1]
del fruits[1:4]
del fruits[:2]
```
Delete entire list:
```
nums = [1, 2, 3]
del nums
```

---

## Dictionaries
```
person = {
    "name": "naman",
    "age": 25,
    "city": "Delhi"
}
person["age"]
```

Useful methods:
```
student.keys()
student.values()
student.items()
student.get("age")
student["age"] = 22
```

---

## type()
Shows datatype.
```
type(10)
type("hello")
type([1,2,3])
```

---

## str()
Convert value to string.
```
x = 100
s = str(x)
type(s)
```

---

## len()
```
len("hello")
```

---

## .format()
```
name = "Jash"
age = 21
"My name is {} and I am {} years old".format(name, age)
```

---

## List Methods
```
append()

```bash
list = [1,2,3]
list.append(4)
print(list)

```

insert()
remove()
pop()
extend()
sort()
sort(reverse=True)

```
bash
list = [1,2,3]
list.append(4)

list.insert(1,12)
print(list)

list.pop(3)
print(list)

numbers = [1, 2, 3]
numbers.extend([4, 5, 6])

print(numbers)
# Output: [1, 2, 3, 4, 5, 6]

nums = [5, 1, 4, 2, 3]
nums.sort()

print(nums)
# Output: [1, 2, 3, 4, 5]

list.sort(reverse=True)

s = {10, 20, 30, 40}
print(s)
```
---

## Lists vs Strings

| Feature | List | String |
|---------|------|--------|
| Mutable | Yes | No |
| Data Types | Many | Characters only |
| Methods | append, pop, sort | lower, split, replace |
| Slicing | Yes | Yes |

---

## Tuples
Immutable, faster, use less memory.

```
t = (10, 20, 30)
t[1] = 99   # error
```

---

## Sets
Unordered, no duplicates.

```
s = {10, 20, 30, 20}
```

---