program picture;
const
     maxn=105000;
type
    tree=object
         cover,len:array[0..maxn*4]of longint;
         procedure build(n,l,r:longint);
         procedure insert(n,l,r,lr,rr:longint);
         procedure delete(n,l,r,lr,rr:longint);
    end;
    node=record
       key,l,r,c:longint;
   end;
var
   q,p:tree;
   a,b:array[0..maxn]of node;
   box:node;
   n:longint;
    
procedure tree.build(n,l,r:longint);
begin
     cover[n]:=0;
     len[n]:=0;
     if l=r-1 then exit;
     build(n*2,l,(l+r)div 2);
     build(n*2+1,(l+r)div 2,r);
end;

procedure tree.insert(n,l,r,lr,rr:longint);
var
   mid:longint;
begin
     if(lr<=l)and(r<=rr)then
     begin
          inc(cover[n]);
          len[n]:=r-l;
     end
     else if l=r-1 then exit else
     begin
          mid:=(l+r)div 2;
          if lr<=mid then insert(n*2,l,mid,lr,rr);
          if mid<=rr then insert(n*2+1,mid,r,lr,rr);
          if cover[n]>0 then
          len[n]:=r-l
          else
          len[n]:=len[n*2]+len[n*2+1];
     end;
end;

procedure tree.delete(n,l,r,lr,rr:longint);
var
   mid:longint;
begin
     if(lr<=l)and(r<=rr)then
     begin
          dec(cover[n]);
          if cover[n]>0 then
          len[n]:=r-l
          else
          len[n]:=len[n*2]+len[n*2+1];
     end
     else if l=r-1 then exit else
     begin
          mid:=(l+r)div 2;
          if lr<=mid then delete(n*2,l,mid,lr,rr);
          if mid<=rr then delete(n*2+1,mid,r,lr,rr);
          if cover[n]>0 then
          len[n]:=r-l
          else
          len[n]:=len[n*2]+len[n*2+1];
     end;
end;

procedure qsort(t,w:longint);
var
i,j,x:int64;
begin
   i:=t;j:=w;
   x:=a[(i+j)div 2].key;
   repeat
         while x<a[j].key do dec(j);
         while x>a[i].key do inc(i);
         if i<=j then
         begin
         box:=a[i];
         a[i]:=a[j];
         a[j]:=box;
         i:=i+1;j:=j-1;
         end;
   until i>j;

   if t<j then qsort(t,j);
   if i<w then qsort(i,w);

end;

procedure qsort1(t,w:longint);
var
i,j,x:int64;
begin
   i:=t;j:=w;
   x:=b[(i+j)>>1].key;
   repeat
         while x<b[j].key do dec(j);
         while x>b[i].key do inc(i);
         if i<=j then
         begin
         box:=b[i];
         b[i]:=b[j];
         b[j]:=box;
         i:=i+1;j:=j-1;
         end;
   until i>j;

   if t<j then qsort1(t,j);
   if i<w then qsort1(i,w);

end;

function min(i,j:longint):longint;
begin
     if i>j then exit(j) else exit(i);
end;
function max(i,j:longint):longint;
begin
     if i<j then exit(j) else exit(i);
end;

procedure init;
var
   i,ans,x1,y1,x2,y2,m1,m2,m3,m4,old:longint;
begin
     ans:=0;
     readln(n);
     m1:=maxlongint;m2:=0;
     m3:=maxlongint;m4:=0;
     for i:=1 to n do
     begin
          readln(x1,y1,x2,y2);
          a[i*2-1].key:=x1; a[i*2-1].l:=y1; a[i*2-1].r:=y2; a[i*2-1].c:=1;
          a[i*2].key:=x2;a[i*2].l:=y1;a[i*2].r:=y2;a[i*2].c:=2;
          b[i*2-1].key:=y1; b[i*2-1].l:=x1; b[i*2-1].r:=x2; b[i*2-1].c:=1;
          b[i*2].key:=y2;b[i*2].l:=x1;b[i*2].r:=x2;b[i*2].c:=2;
          m1:=min(m1,x1); m2:=max(m2,x2);
          m3:=min(m3,y1); m4:=max(m4,y2);
     end;
     qsort(1,n*2);
     qsort1(1,n*2);

     {for i:=1 to n*2 do
     writeln(i,':',a[i].key,' ',a[i].l,' ',a[i].r,' ',a[i].c);
     for i:=1 to n*2 do
     writeln(i,':',b[i].key,' ',b[i].l,' ',b[i].r,' ',b[i].c);  }
     
     
     q.build(1,m3,m4);
     for i:=1 to n*2 do
     begin
          old:=q.len[1];
          if a[i].c=1 then q.insert(1,m3,m4,a[i].l,a[i].r)
          else
          q.delete(1,m3,m4,a[i].l,a[i].r);
          ans:=ans+abs(old-q.len[1]);
     end;
     
     p.build(1,m1,m2);
     for i:=1 to n*2 do
     begin
          old:=p.len[1];
          if b[i].c=1 then p.insert(1,m1,m2,b[i].l,b[i].r)
          else
          p.delete(1,m1,m2,b[i].l,b[i].r);
          ans:=ans+abs(old-p.len[1]);
     end;
     
     writeln(ans);
end;

begin
     assign(input,'picture.in');assign(output,'picture.out');
     reset(input);rewrite(output);

     init;

     close(input);close(output);
end.
