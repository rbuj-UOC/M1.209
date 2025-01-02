# Import Pandas library
import pandas as pd
import getopt, sys

argumentList = sys.argv[1:]

options = "n:"
long_options = ["Name"]

try:
    arguments, values = getopt.getopt(argumentList, options, long_options)
    for currentArgument, currentValue in arguments:
        if currentArgument in ("-n", "--Name"):
            name = currentValue

except getopt.error as err:
    print (str(err))

dim_list=[10, 50, 100, 500, 1000, 1500]
for dim in dim_list:
    url=str(name)+'_'+str(dim)+'.csv'
    df=pd.read_csv(url)
    mean_value=df['real'].mean()
    std_value=df['real'].std()
    print(str(dim)+' '+f"{mean_value:.3f}"+' '+f"{std_value:.3f}")
