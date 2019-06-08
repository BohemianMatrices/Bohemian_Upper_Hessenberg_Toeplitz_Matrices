# ======================================================================= #
# ======================================================================= #
#                                                                         #
# Compute_UHT_Maximum_Characteristic_Height.mpl                           #
#                                                                         #
# AUTHOR .... Steven E. Thornton                                          #
#                Under the supervision of                                 #
#                Robert M. Corless                                        #
# EMAIL ..... sthornt7@uwo.ca                                             #
# UPDATED ... Sept. 14/2018                                               #
#                                                                         #
# Let M be an upper Hessenberg matrix with upper triangular entries       #
# (including the diagonal) fixed at -1 and subdiagonal entries fixed at   #
# 1. This file will compute the characteristic height and the degree of   #
# the term from the characteristic polynomial corresponding to the        #
# characteristic height for all matrices M of dimensions 0 up to n.       #
#                                                                         #
# Three files are created:                                                #
#   maxCharHeight_n.txt ...... A text file where line i (starting at 1)   #
#                              contains the characteristic height of M    #
#                              for dimension i-1.                         #
#   logMaxCharHeight_n.txt ... A text file where line i (starting at 1)   #
#                              contains the natural logarithm of the      #
#                              characteristic height of M for dimension   #
#                              i-1.                                       #
#   argmaxCharHeight_n.txt ... A text file where line i (starting at 1)   #
#                              contains the degree of the term of the     #
#                              characteristic polynomial of M             #
#                              corresponding to the characteristic height #
#                              for dimension i-1.                         #
#                                                                         #
# ======================================================================= #
# ======================================================================= #

with(LinearAlgebra):

# ----------------------------------------------------------------------- #
# Compute the coefficient of the degree k term of the characteristic      #
# polynomial M for dimension n. The coefficient is computed by the        #
# hypergeometric function for the coefficients from the paper. i.e.       #
#   q[n,k] = F(k+2, k-n+1; 2; -1)                                         #
#                                                                         #
# INPUT                                                                   #
#   n ... Dimension of matrix                                             #
#   k ... Degree of term in characteristic polynomial to compute          #
#                                                                         #
# OUTPUT                                                                  #
#   The degree k term of the characteristic polynomial of M for dimension #
#   n.                                                                    #
# ----------------------------------------------------------------------- #
q_n_k_hypergeom := proc(n::posint, k::posint, $)
    (k+1)*hypergeom([k+2, k-n+1], [2], -1);
end proc:


# ----------------------------------------------------------------------- #
# Computes the characteristic height and the degree of the term from the  #
# characteristic polynomial corresponding to the characteristic height    #
# for all matrices M of dimensions 0 up to n.                             #
#                                                                         #
# INPUT                                                                   #
#   n ... Maximal dimension of matrix                                     #
#                                                                         #
# OUTPUT                                                                  #
#   Sequence maxCharHeight, argmaxCharHeight where                        #
#       maxCharHeight ...... An array of dimension n+1 (indexed starting  #
#                            at 0) such that the ith entry is the         #
#                            characteristic height of M for dimension i.  #
#       argmaxCharHeight ... An array of dimension n+1 (indexed starting  #
#                            at 0) such that the ith entry is the degree  #
#                            of the term from the characteristic          #
#                            polynomial corresponding to the              #
#                            characteristic height of M for dimension i.  #
#                                                                         #
# ----------------------------------------------------------------------- #
computeMaxCharHeight := proc(n::posint, $)

    local maxCharHeight :: Array,
          argmaxCharHeight :: Array,
          prev_argmax :: posint,
          i :: posint,
          m1 :: posint,
          m2 :: posint;
    
    maxCharHeight := Array(0..n, datatype = integer);
    argmaxCharHeight := Array(0..n, datatype = integer);
    
    maxCharHeight[0] := 1;
    argmaxCharHeight[0] := 0;
    maxCharHeight[1] := 1;
    argmaxCharHeight[1] := 1;
    
    # phi := (1 + sqrt(5))/2;
    
    prev_argmax := 1;
    for i from 2 to n do
        if `mod`(i, 100) = 0 then
            printf("%d of %d\n", i, n);
        end if;
        
        # Approximate the number of digits of precision required
        # nDigits := evalf[16](floor(log10(floor((50000+327)/(phi+2))-90)))+1000;
        
        # Update the number of digits to use in computation
        # Digits := nDigits
        
        m1 := floor(evalf(q_n_k_hypergeom(i, prev_argmax)));
        m2 := floor(evalf(q_n_k_hypergeom(i, prev_argmax+1)));
        
        if m1 > m2 then
            maxCharHeight[i] := m1;
            argmaxCharHeight[i] := prev_argmax;
        elif m2 > m1 then
            maxCharHeight[i] := m2;
            argmaxCharHeight[i] := prev_argmax+1;
            prev_argmax := prev_argmax+1;
        else
            print("Error Argmax decreased");
            break;
        end if;
    end do;
    
    return maxCharHeight, argmaxCharHeight;
    
end proc:


# Precision of computation, if n is higher this needs to be increased.
# To determine an appropriate number of digits, run the computation for the
# maximal dimension only and test that maxCharHeight is an integer such that
# log10(maxCharHeight) < Digits.
Digits := 25000:

# Compute the max char height up to dimension n
n := 50000:

maxCharHeight, argmaxCharHeight := computeMaxCharHeight(n):

# Save max char height
fd := fopen(cat("../Data/maxCharHeight_", n, ".csv"), WRITE, TEXT):
writedata(fd, convert(maxCharHeight, list)):
fclose(fd):

# Compute and save log max char height
logMaxCharHeight := map(log10, maxCharHeight):
fd := fopen(cat("../Data/logMaxCharHeight_", n, ".csv"), WRITE, TEXT):
writedata(fd, convert(evalf[16](logMaxCharHeight), list)):
fclose(fd):

# Save argmax char height
fd := fopen(cat("../Data/argmaxCharHeight_", n, ".csv"), WRITE, TEXT):
writedata(fd, convert(argmaxCharHeight, list)):
fclose(fd):
