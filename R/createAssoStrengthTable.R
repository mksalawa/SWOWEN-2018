# Description:
#
# Generate a cue x response table with strengths
#
# Note: the data included with this script cannot be distributed without prior consent
# Author: Simon De Deyne simon2d@gmail.com
# Last changed: 20 February 2018

source('settings.R')
require(igraph)
require(Matrix)

outputR1.file       = './output/strength.SWOW-EN.R1.csv'
outputR2.file       = './output/strength.SWOW-EN.R2.csv'
outputR3.file       = './output/strength.SWOW-EN.R3.csv'
outputR123.file     = './output/strength.SWOW-EN.R123.csv'

# TODO: set the working directory.
setwd('/home/USER/workspace/SWOWEN-2018/')
source('./R/functions/importDataFunctions.R')

# Import the dataset for R1
dataFile          = './data/processed/SWOW-EN.R100.csv'
response          = 'R1' # Options: R1, R2, R3 or R123
X.R1              = importDataSWOW(dataFile,response)

strength.R1       = X.R1 %>% filter(!is.na(response)) %>%  group_by(cue,response) %>%
                    summarise(R1 = n()) %>% select(cue,response,R1)
total.R1          = strength.R1 %>% group_by(cue) %>% summarise(N = sum(R1))
strength.R1       = left_join(strength.R1,total.R1)
strength.R1       = strength.R1 %>% mutate(R1.Strength = R1 / N)
strength.R1       = strength.R1 %>% arrange(cue,-R1.Strength)

# Write cue - asso strength R1
write.table(strength.R1,outputR1.file,row.names = FALSE,sep = '\t',quote = FALSE)


# Import the dataset for R2
response          = 'R2' # Options: R1, R2, R3 or R123
X.R2              = importDataSWOW(dataFile,response)

strength.R2       = X.R2 %>% filter(!is.na(response)) %>%  group_by(cue,response) %>%
                    summarise(R2 = n()) %>% select(cue,response,R2)
total.R2          = strength.R2 %>% group_by(cue) %>% summarise(N = sum(R2))
strength.R2       = left_join(strength.R2,total.R2)
strength.R2       = strength.R2 %>% mutate(R2.Strength = R2 / N)
strength.R2       = strength.R2 %>% arrange(cue,-R2.Strength)

# Write cue - asso strength R2
write.table(strength.R2,outputR2.file,row.names = FALSE,sep = '\t',quote = FALSE)


# Import the dataset for R3
response          = 'R3' # Options: R1, R2, R3 or R123
X.R3              = importDataSWOW(dataFile,response)

strength.R3       = X.R3 %>% filter(!is.na(response)) %>%  group_by(cue,response) %>%
                    summarise(R3 = n()) %>% select(cue,response,R3)
total.R3          = strength.R3 %>% group_by(cue) %>% summarise(N = sum(R3))
strength.R3       = left_join(strength.R3,total.R3)
strength.R3       = strength.R3 %>% mutate(R3.Strength = R3 / N)
strength.R3       = strength.R3 %>% arrange(cue,-R3.Strength)

# Write cue - asso strength R3
write.table(strength.R3,outputR3.file,row.names = FALSE,sep = '\t',quote = FALSE)


# Import the dataset for R123
response          = 'R123'
X.R123            = importDataSWOW(dataFile,response)


strength.R123   = X.R123 %>% filter(!is.na(response)) %>%  group_by(cue,response) %>%
                      summarise(R123 = n()) %>% select(cue,response,R123)
total.R123        = strength.R123 %>% group_by(cue) %>% summarise(N = sum(R123))
strength.R123     = left_join(strength.R123,total.R123)
strength.R123     = strength.R123 %>% mutate(R123.Strength = R123 / N)
strength.R123     = strength.R123 %>% arrange(cue,-R123.Strength)

# Write cue - asso strength R1
write.table(strength.R123,outputR123.file,row.names = FALSE, sep = '\t', quote = FALSE)

