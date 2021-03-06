program p1038;
const
     maxn=105000;
type
    tree=object
         s,a:array[0..maxn*4]of longint;
         function build(n,l,r:longint):longint;
         function insert(n,l,r,lr,rr:longint):longint;
    end;
    node=record
       key,l,r,c:longint;
   end;
var
   q:tree;
   n,m:longint;
{---------------min max---------------------}
function min(i,j:longint):longint;
begin
     if i>j then exit(j) else exit(i);
end;

function tree.build(n,l,r:longint):longint;
begin
     if l=r then begin s[n]:=a[l];
     //writeln(l,'->',r,':',s[n]);
     exit;end;
     build(n*2,l,(l+r)div 2);
     build(n*2+1,(l+r)div 2+1,r);
     s[n]:=min(s[n*2],s[n*2+1]);
     //writeln(l,'->',r,':',s[n]);
end;

function tree.insert(n,l,r,lr,rr:longint):longint;
var
   mid,x,y:longint;
begin
     if(lr=l)and(r=rr)then
     begin
          exit(s[n])
     end
     else
     begin
          mid:=(l+r)div 2;
          if rr<=mid then exit(insert(n*2,l,mid,lr,rr))else
          if mid+1<=lr then exit(insert(n*2+1,mid+1,r,lr,rr))else
          begin
               x:=insert(n*2,l,mid,lr,mid);
               y:=insert(n*2+1,mid+1,r,mid+1,rr);
               exit(min(x,y));
          end;
     end;
end;



procedure init;
var
   i,x,y:longint;
begin
     readln(n,m);
     for i:=1 to n do
     read(q.a[i]);
     q.build(1,1,n);
     for i:=1 to m do
     begin
          readln(x,y);
          write(q.insert(1,1,n,x,y),' ');
     end;
end;

begin
     assign(input,'a.in');assign(output,'a.out');
     reset(input);rewrite(output);

     init;

     close(input);close(output);
end.

