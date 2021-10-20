% Group 2: Raj Patel, Zachary Rouviere, Evan Waxman
% Experiement 7 Part 1
% 10/24/21
%
% Description:
%	This matlab script will take the .hex file and strip away the header 
%   and checksum information
%   then it will convert it from hex to binary to produce the signatures.
%   This script also will find the
%   total number of bit, the mean, the percentage of 0's and 1's, and will
%   calcuate the intra Hamming Distance.

% Converts the .hex file to binary
[S1,hexS1] = binary('3_3ram1.hex');
[S2,hexS2] = binary('3ram1.hex');
[S3,hexS3] = binary('2_7ram1.hex');

% Calclates the mean, total bit, percentage of 0 bits and percentage of 1
% bits for S1.
[S1meanvalue,S1totalbits,S1zerobitper,S1onebitper] = meanvalues(S1);

% Calculates the Intra hamming distance and the number of different bit
% between S1, S2 and S1, S3. 
[diffbitsS1S2,IntraHDS1S2] = HD(S1,S2,S1totalbits);
[diffbitsS1S3,IntraHDS1S3] = HD(S1,S3,S1totalbits);


% This function strip away the header and checksum information then it
% will convert it from hex to binary
function [binaryvalues,hexvalues] = binary(name)

    fid = fopen(name, 'r'); % open file with read only permission
    hexvalues = [];
    
    for i = 1:64    % number of bytes for signature
        hexpadding= fgetl(fid); % get line information and move to next
        hexvalue = eraseBetween(hexpadding,1,9); % removing header
        hexvalue= eraseBetween(hexvalue,3,4);   % removing checksum
        hexvalues = [hexvalues;hexvalue];   
    end

    binaryvalues = hexToBinaryVector(hexvalues);    % converts to binary

end


% This function finds the total number of bit, the mean, and
% the percentage of 0's and 1's,
function [meanvalue,sumbits,zerobitper,onebitper] = meanvalues(binaryvalues)

    cnt0 = 0; % counter for 0 bits
    cnt1 = 0; % counter for 1 bits
    meanvalue = 0;

    for bvalue = 1:64 % 64 bytes
       for bit = 1:8   % each byte 8 bits
           bitvalue = binaryvalues(bvalue,bit); % gets the bit value
           meanvalue = meanvalue + bitvalue; % adds it to the mean
           if(bitvalue == 1)
               cnt1 = cnt1 + 1; % increment cnt1 if bit is 1
           else
               cnt0 = cnt0 + 1; % increment cnt0 if bit is 0
           end
       end
    end
    
    sumbits = cnt1+cnt0; % total number of bits
    zerobitper = (cnt0/sumbits)*100; % Percentatge of 0 bits
    onebitper = (cnt1/sumbits)*100; % percentage of 1 bits
    meanvalue = meanvalue/sumbits; % mean of signature

end


% This function will find the number of different bit between 2 signatures
% and will calcuate the intra-HD
function[diffbits, intraHD] = HD(data1,data2,totalbits)
    diffbits = 0;
    
	for bvalue = 1:64
       for bit = 1:8
          if(data1(bvalue,bit) ~= data2(bvalue,bit)) % determines if bits are the same
              diffbits= diffbits +1; % if not add 1 to the diffbits sum
          end
        end
    end
     
    intraHD= diffbits/totalbits; % calculation for intraHD total of diffbits divided 
                                 % by the total number of bits in siguature
end

