function   [ap]=dezoom(lena,resh,scala,in,Lor,Hir)

le1=size(lena,1);
le2=size(lena,2);

if (in==0)
    ap=resh(1:le1/2^scala,1:le2/2^scala);
    ap=imresize(ap,[le1 le2]);
else
    lmax=scala;
    rit=[resh(1:2*le1/(2^lmax), 1:2*le2/(2^lmax))];
    ll1=size(rit,1);
    ll2=size(rit,2);
    app1=rech2(rit(1:ll1/2,1:ll2/2),rit(1:ll1/2,ll2/2+1:ll2),rit(ll1/2+1:ll1,1:ll2/2),rit(ll1/2+1:ll1,ll2/2+1:ll2),Lor,Hir);
    ap=app1;
    l=2;
while (l<=in)
    rit=[resh(1:2*le1/(2^l), 1:2*le2/(2^l))];
    ll1=size(rit,1);
    ll2=size(rit,2);
    ap=rech2(ap,rit(1:ll1/2,ll2/2+1:ll2),rit(ll1/2+1:ll1,1:ll2/2),rit(ll1/2+1:ll1,ll2/2+1:ll2),Lor,Hir);
    l=l+1;
end
end