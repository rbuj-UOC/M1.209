#!/usr/bin/python3
import pandas as pd
import getopt, sys

argumentList = sys.argv[1:]

options = "f:n:c:"
long_options = ["File", "Number", "Column"]

try:
    arguments, values = getopt.getopt(argumentList, options, long_options)
    for currentArgument, currentValue in arguments:
        if currentArgument in ("-f", "--File"):
            file = currentValue
        elif currentArgument in ("-n", "--Number"):
            number = currentValue
        elif currentArgument in ("-c", "--Column"):
            column = currentValue

except getopt.error as err:
    print (str(err))

# size,sum_time,global_time,sum_result
df=pd.read_csv(file)
mean_value=df[column].mean()
std_value=df[column].std()

print(str(number)+' '+f"{mean_value:.3f}"+' '+f"{std_value:.3f}")
