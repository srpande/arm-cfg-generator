#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
	unsigned int real;
	unsigned int imag;
} complex;

void bitreverse_krukar_512(int N, complex* complex_data) {}

int int_log2 (int n)
{
    int k = 1;
    int log = 0;
    for(/*k=1*/; k < n; k *= 2, log++);
    if (n != (1 << log))
    {
      printf("FFT: Data length is not a power of 2!: %d.\n",n);
      exit(1);
    }
    return log; 
}

void bitreverse_gold_rader_ref (int N, double *data) {
	
	int n = N/2;
	int nm1 = n-1;
	int i = 0;
	int j = 0;
    
	for (; i < nm1; i++) {
		/*int ii = 2*i; */
		int ii = i << 1;
		/*int jj = 2*j; */
		int jj = j << 1;
		/* int k = n / 2 ; */
		int k = n >> 1;

		if (i < j) {
			double tmp_real = data[ii];
			double tmp_imag = data[ii+1];
			data[ii]   = data[jj];
			data[ii+1] = data[jj+1];
			data[jj]   = tmp_real;
			data[jj+1] = tmp_imag;
		}

		while (k <= j) {
			/*j = j - k ; */
			j -= k;
			/*k = k / 2 ;  */
			k >>= 1 ; 
		}
		j += k ;
	}
}


void bitreverse_hein (int N, complex *data) {
	
	int i = 0;
	int j = 0;
	int m;	
	int n2 = N >> 1;
	complex ctmp;
	
	while (i < N) { /*i*/
		if (i < j) {
			ctmp = data[j];
			data[j] = data[i];
			data[i] = ctmp;
		}
		
		m = n2;
    
		while ((j > m-1) && (m >= 2)) {
			j = j - m;
			m = m >> 1;
		}
		
		j = j + m;
		i = i + 1;
	}
}

#define SWAP(a,b) tempr=(a);(a)=(b);(b)=tempr;

void bitreverse_ransom (int N, complex *data) {
    
    int i, j, m, n;
    complex tempr;

    data--;
    
    n = N << 1;
    j = 1;
    
    for (i = 1; i < n; i += 2) {
		if (j > i) {
			SWAP(data[j], data[i]);
			SWAP(data[j + 1], data[i + 1]);
		}
		m = n >> 1;
		while (m >= 2 && j > m) {
			j -= m;
			m >>= 1;
		}
		j += m;
    }
}

void bitreverse_gold_rader (int N, complex *data) {
	
	int n = N;
	int nm1 = n-1;
	int i = 0;
	int j = 0;
    
	for (; i < nm1; i++) {

		int k = n >> 1;

		if (i < j) {
			complex temp = data[i];
			data[i] = data[j];
			data[j] = temp;
		}

		while (k <= j) {
			j -= k;
			k >>= 1 ; 
		}
		j += k ;
	}
}

void bitreverse_rodriguez (int N, complex *data, int p) {

	complex temp;
	
    int i;
    int j;
    int k;
    
    int NV2 = N >> 1;
    int last = (N-1) - (1 << ((p+1) >> 1));
    
    j = 0;
    
    for(i = 1; i <= last; i++) {
		
		for(k = NV2; k <= j; k >>= 1)
			j -= k;
		
		j += k;
	
		if (i < j) {
			temp = data[i];
			data[i] = data[j];
			data[j] = temp;
		}
	}
}
	
void bitreverse_nbrv (int N, complex *data, int M) {

    register int i, j, ixor, jxor;
    
    static int seed[16] = {0,1,3,5,9,27,33,65,195,365,633,1161,2193,4257,9009,16385};
    
    ixor = seed[M];
    jxor = ixor + N;
    
    i = ixor;
    j = ixor;
    
    while(1) {
    
		i >>= 1;
		j <<= 1;
    
		if (j >= N) {		
			if(j == N) break;	
			i ^= ixor;
			j ^= jxor;
		}
		
		if (i > j) {
			complex temp = data[i];
			data[i] = data[j];
			data[j] = temp;
		}
	}
}

#define swap(i,j) {complex temp=data[i];data[i]=data[j];data[j]=temp;}

void bitreverse_nbrv2 (int N, complex *data, int M) {

    register int ih, il, jh, jl, hxor, lxor;
    int i, j;
    
    static int seed[16] = {0,1,3,5,9,27,33,65,195,365,633,1161,2193,4257,9009,16385};
    
    lxor = seed[M/2];
    hxor = lxor << ((M+1)/2);
    ih = hxor;
    jl = lxor;
    
    hxor += N;
    
    while(1) {
		swap(ih,jl);
		
		il = jl;
		jh = ih;
		while(1){
			il >>= 1;
			jh <<= 1;
			if(jh >= N) {
				if(jh == N) break;
				il ^= lxor;
				jh ^= hxor;
			}
			i = ih + il;
			j = jh + jl;
			swap(i,j);
		}
		ih <<= 1;
		jl >>= 1;
		if(ih >= N) {
			if(ih == N) break;
			jl ^= lxor;
			ih ^= hxor;
		}
	}
}


	
void bitreverse_bloodworth (int N, complex *data) {
	
	int Index, xednI, k;
	xednI = 0;
	
	for (Index = 0; Index < N; Index++) {
		
		k = N/2;
		
		if (xednI > Index) {
			complex temp = data[xednI];
			data[xednI] = data[Index];
			data[Index] = temp;
		}
		
		while ((k <= xednI) && (k >= 1)) {
			xednI -= k;
			k /= 2;
		}
		
		xednI += k;
	}
}

void bitreverse_krukar (int N, complex* complex_data) {
	
	int i, irev, j, bits;
	unsigned int temp, *ptr1, *ptr2;
    
	if(N <= 512) {
		bitreverse_krukar_512(N, complex_data);
		return;
	}
    
    unsigned int *data = (unsigned int*)complex_data;
    
	for(i = 0; i < N; i++) {
        
		irev = 0;
        
		for(j = 1, bits = (N >> 1); j < N; (j = j << 1), (bits = bits >> 1))
			if(i & j)
				irev |= bits;
        
		if(i < irev) {
			ptr1 = &(data[i << 1]);
			ptr2 = &(data[irev << 1]);
            
			temp = *ptr1;
			*ptr1 = *ptr2;
			*ptr2 = temp;
            
			ptr1++;
			ptr2++;
            
			temp = *ptr1;
			*ptr1 = *ptr2;
			*ptr2 = temp;
		}
	}
}
