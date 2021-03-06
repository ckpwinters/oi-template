program Project1;
var
   tmp,a,b:array[1..299948]of longint;
   n,i:integer;

procedure qsort(i,j:longint);
var
   l,r,x,t:longint;
begin
     l:=i;r:=j;x:=b[(i+j)shr 1];
     repeat
           while b[i]<x do inc(i);
           while b[j]>x do dec(j);
           if i<=j then
           begin
                t:=b[i];b[i]:=b[j];b[j]:=t;
                t:=a[i];a[i]:=a[j];a[j]:=t;
                inc(i);dec(j);
           end;
     until i>j;
     if l<j then qsort(l,j);
     if i<r then qsort(i,r);
end;

procedure merge(p,q,r:longint;var ans:longint);
var
   tt,tl,tr,i:longint;
begin
     tt:=p;
     tl:=p;
     tr:=q+1;
     while tt<=r  do
     if (tl<=q)and((tr>r)or (a[tl]<=a[tr])) then
     begin
          tmp[tt]:=a[tl];
          inc(tl); inc(tt);
          inc(ans,tr-q-1);
     end
     else
     begin
          tmp[tt]:=a[tr];

          inc(tr);inc(tt);
     end;
     for i:=p to r do
     a[i]:=tmp[i];
end;

function  ms(p,r:longint):longint;
var ans,q:longint;
begin
     ans:=0;
     if p<>r then
     begin
          q:=(p+r-1)shr 1;
          ans:=ans+ms(p,q);
          ans:=ans+ms(q+1,r);
          merge(p,q,r,ans);
     end;
     ms:=ans;
end;

begin
     assign(input,'overtaking.in');assign(output,'overtaking.out');
     reset(input);rewrite(output);
     readln(n);
     for i:=1 to n do
     read(b[i],a[i]);
     qsort(1,n);
     writeln(ms(1,n));
     close(input);close(output);
end.

