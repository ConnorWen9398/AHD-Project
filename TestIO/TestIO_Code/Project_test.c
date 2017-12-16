#include<stdio.h>
typedef unsigned long int WORD;
#define w    32
#define r    12
#define b    16
#define c    4
#define t    26
WORD S[t];
WORD P = 0xb7e15163, Q=0x9e3779b9;

#define ROTL(x,y) (((x)<<(y&(w-1)))|((x)>>(w-(y&(w-1)))))
#define ROTR(x,y) (((x)>>(y&(w-1)))|((x)<<(w-(y&(w-1)))))

void RC5_ENCRYPT(WORD *pt, WORD *ct)
{
	WORD i, A=pt[0]+S[0],B=pt[1]+S[1];
	printf("\n Encrypt--Din %08x %08x  \n",A,B);
	for(i=1;i<=r; i++)
	{
		A=ROTL(A^B,B)+S[2*i];
		B=ROTL(B^A,A)+S[2*i+1];
		/*printf("\n Encrypt-- %d----- A %08x  B %08x  \n",i,A,B);*/
	}
	ct[0]=A; ct[1]=B;

}


void RC5_DECRYPT(WORD *ct, WORD *pt)
{
	WORD i, B=ct[1], A=ct[0];
	printf("\n Decrypt--Din %08x %08x  \n",A,B);
	for(i=r;i>0;i--)
	{
		B=ROTR(B-S[2*i+1],A)^A;
		A=ROTR(A-S[2*i],B)^B;
		/*printf("\n Decrypt-- %d----- A %08x  B %08x  \n",i,A,B);*/
	}
    pt[1]=B-S[1];pt[0]=A-S[0];
}

void RC5_SETUP(unsigned char *K)
{
	WORD i, j, k, u=w/8, A, B, L[c];
	for(i=b-1,L[c-1]=0;i!=-1;i--)
    {
        L[i/u] = (L[i/u]<<8)+K[b-i-1];
        /*L[b-1-i] =K[i];*/
        /*printf("K---%02x \n",K[b-i]);
        printf("L--Second %d ---%02x \n",i,L[i/u]); */
    }

	for(S[0]=P,i=1;i<t;i++) S[i]=S[i-1]+Q;
	for(A=B=i=j=k=0;k<3*t;k++,i=(i+1)%t,j=(j+1)%c)
	{
		A=S[i]=ROTL(S[i]+(A+B),3);
        /*printf("\n Key--S [%d]----- %08x    \n",i,A);
		printf("\n Key--L [%d]----- %08x    \n",j,L[j]); */
		B=L[j]=ROTL(L[j]+(A+B),(A+B));
		/*printf("\n Key--L [%d]----- %08x    \n",i,B);*/
	}
}

void main()
{
	WORD i, j, pt1[2], pt2[2], ct[2]={0,0};
	unsigned char key[b];
/*	unsigned char key[b]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0x0};
    WORD pt1[2]={0,0};*/
	if (sizeof(WORD)!=4)
		printf("RC5 error: WORD has %d bytes.\n",sizeof(WORD));
	printf("RC5-32/12/16 examples:\n");
	FILE *f_1 = fopen("ukey.txt", "w");
	FILE *f_2 = fopen("Din.txt", "w");
	FILE *f_3 = fopen("Dout.txt","w");
	FILE *f_4 = fopen("nah.txt","w");
	FILE *f_5 = fopen("Encryption.txt","w");
	FILE *f_6 = fopen("Decryption.txt","w");
	FILE *f_7 = fopen("RoundKey.txt","w");
if (f_1 == NULL)
{
    printf("Error opening ukey file!\n");
    exit(1);
}
if (f_2 == NULL)
{
    printf("Error opening Din file!\n");
    exit(1);
}
if (f_3 == NULL)
{
    printf("Error opening Dout file!\n");
    exit(1);
}
if (f_4 == NULL)
{
    printf("Error opening whole file!\n");
    exit(1);
}
if (f_5 == NULL)
{
    printf("Error opening whole file!\n");
    exit(1);
}
	for(i=1;i<1002;i++)
	{
		pt1[0]=ct[0]; pt1[1]=ct[1];
		for(j=0;j<b;j++) key[j]=ct[0]%(255-j);


	    RC5_SETUP(key);
		RC5_ENCRYPT(pt1,ct);
		RC5_DECRYPT(ct,pt2);
		/*printf("\n%d. key=",i);
		for (j=0;j<b;j++)printf("%.2X ",key[j]);*/
		fprintf(f_5, "%08x%08x %02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x %08x%08x\n",pt1[0],pt1[1],key[0],key[1],key[2],key[3],key[4],key[5],key[6],key[7],key[8],key[9],key[10],key[11],key[12],key[13],key[14],key[15],ct[0],ct[1]);
		fprintf(f_6, "%08x%08x %02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x %08x%08x\n",ct[0],ct[1],key[0],key[1],key[2],key[3],key[4],key[5],key[6],key[7],key[8],key[9],key[10],key[11],key[12],key[13],key[14],key[15],pt1[0],pt1[1]);
		fprintf(f_7, "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x\n",key[0],key[1],key[2],key[3],key[4],key[5],key[6],key[7],key[8],key[9],key[10],key[11],key[12],key[13],key[14],key[15],S[0],S[1],S[2],S[3],S[4],S[5],S[6],S[7],S[8],S[9],S[10],S[11],S[12],S[13],S[14],S[15],S[16],S[17],S[18],S[19],S[20],S[21],S[22],S[23],S[24],S[25]); 
		fprintf(f_1,"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x\n",key[0],key[1],key[2],key[3],key[4],key[5],key[6],key[7],key[8],key[9],key[10],key[11],key[12],key[13],key[14],key[15],S[0],S[1],S[2],S[3],S[4],S[5],S[6],S[7],S[8],S[9],S[10],S[11],S[12],S[13],S[14],S[15],S[16],S[17],S[18],S[19],S[20],S[21],S[22],S[23],S[24],S[25]);
		fprintf(f_2,"%08x%08x\n",pt1[0],pt1[1]);
		fprintf(f_3,"%08x%08x\n",ct[0],ct[1]);
		fprintf(f_4,"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x %08x%08x %08x%08x\n",key[0],key[1],key[2],key[3],key[4],key[5],key[6],key[7],key[8],key[9],key[10],key[11],key[12],key[13],key[14],key[15],pt1[0],pt1[1],ct[0],ct[1]); 
	    if(pt1[0]!=pt2[0]||pt1[1]!=pt2[1])
	    	printf("Decryption error!");
	}



/* print some text */

/*fprintf(f, "Some text: %s\n", text);*/
}
