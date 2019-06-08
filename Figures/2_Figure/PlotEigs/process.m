inFile = '../../../Data/UHT_1_Subdiag_0_Diag_n1_0_1_CharPolys_14x14.csv';
outFile = 'Data/BHIME_1.mat';
n = 14;
has_weights = true;
sep = ', ';

processPolyFile(inFile, outFile, n, has_weights, sep);
