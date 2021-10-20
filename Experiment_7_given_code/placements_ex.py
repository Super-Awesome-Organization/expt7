import os
import sys

X = 29
X2 = 49
NO = 0
Y = 13

illegalX = [5, 28, 33, 48, 53, 68, 73] #X coordiantes that can not be used
xLimit = 47 #Limit for first set of RO x corrdinates
xLimit2 = 67 #Limit for second set of RO x corrdinates
yLimit = 38 #Limit for y coordiantes


def coordHandeler(node, pos): #generates the placements
    global Y #LAB Y coordinate
    global X #LAB X coordinate for first half of RO 
    global X2 #LAB X coordinate for second half of RO 
    global NO #Coordinate for LUT inside LAB
    if (node ==1): #changes size limit for LAB, is the same for now
        noLimit = 8
    else:
        noLimit = 30
        
    if (pos ==1): #changes to using a LUT
        loc = "LCCOMB_X"
    else:
        loc = "FF_X" #changes to using a register
        noLimit = 31
        if (NO == 0):
            NO = NO+1
        
    placement1 = "set_location_assignment " + loc
    out1 = placement1 + str(X) + "_Y" + str(Y) + '_N' + str(NO) + " -to "
    out2 = placement1 + str(X2) + "_Y" + str(Y) + '_N' + str(NO) + " -to "

    NO = NO + 2
    if NO > noLimit:
        NO = 0
        if (X == xLimit) or (X2 >= xLimit2):
            Y = Y + 1
            X = 29
            X2 = 49
        else:
            for i in range(len(illegalX)):
                if X+1 == illegalX[i]:
                   X = X + 1
                if X2+1 == illegalX[i]:
                   X2 = X2 + 1
            X = X + 1
            X2 = X2 +1
    return out1, out2

def place_RO(ronum, invnum, text_file):
    nodeName1 = "ro:ro_block[" #Name of node in quartus chip planner
    ind1 = "0"
    ind2 = "1"
    for i in range(ronum):
##### Setting coordinates for ROs #####
        stringOut1 = '"' + nodeName1 + str(i) + '].r' + ind1 + '|tmp[' #Construct strings for coordinates
        stringOut2 = '"' + nodeName1 + str(i) + '].r' + ind2 + '|tmp['

        for j in range(invnum):
            out1, out2 = coordHandeler(1,1) #returns coordinates for both set of ROs
            text_file.write(out1 + stringOut1 + str(j) + ']' + '"' + '\n')
            text_file.write(out2 + stringOut2 + str(j) + ']' + '"' + '\n')

def main():
    global NO
    global X
    global X2
    global Y
    flip = 0
    text_file = open("nodePlacement.txt", "w")
    ronum = 256 #number of ROs in PUF
    invnum = 5 #number of inverters in RO
    place_RO(ronum, invnum, text_file)
    text_file.close()

if __name__ == "__main__":
    main()
