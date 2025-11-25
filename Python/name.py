# i = 0
# while i < 15:
#     print(i)
#     i +=1

# type(i)

# to_slice = "Just do it!"
# print(to_slice[10])   # prints "!"
# print(to_slice[5:7])  # prints "do"
# print(to_slice[8:])   # prints "it!"
# print(to_slice[:4])   # prints "Just"
# print("Don't " + to_slice[5:])  # prints "Don't do it!"

# x = 3.14159
# print(round(x))


# def add(a, b):
#     return a + b

# result = add(5,3)
# print(result)

# def my_func():
#     x = 10   # local variable
#     print(x)

# my_func(x)
#    # Error: x is not defined

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
