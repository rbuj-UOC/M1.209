#!/usr/bin/python3
import pandas as pd
import getopt, sys
import locale

locale.setlocale(locale.LC_ALL, 'en_US.UTF-8')

argumentList = sys.argv[1:]

options = "f:c:"
long_options = ["File", "Column"]

try:
    arguments, values = getopt.getopt(argumentList, options, long_options)
    for currentArgument, currentValue in arguments:
        if currentArgument in ("-f", "--File"):
            file = currentValue
        elif currentArgument in ("-c", "--Column"):
            column = currentValue

except getopt.error as err:
    print (str(err))

df=pd.read_csv(file)
mean_value=df[column].mean()

print(f"{mean_value:.0f}")
