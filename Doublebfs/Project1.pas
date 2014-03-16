program Project1;
var
   a,b:array[0..1,0..11]of string;
   t,w:array[0..1]of integer;
   dui:array[0..1,0..1100]of string;
   time:array[0..1,0..1100]of integer;
   aa,bb:string;
   
   time1,ge:integer;
   
procedure init;
var
s:string;p:integer;
begin
     readln(s);
     p:=pos(' ',s);
     aa:=copy(s,1,p-1);
     bb:=copy(s,p+1,length(s));
     ge:=0;
     while not eof do
     begin
     inc(ge);
     readln(s);
     p:=pos(' ',s);
     a[0,ge]:=copy(s,1,p-1);
     b[0,ge]:=copy(s,p+1,length(s));
     a[1,ge]:=b[0,ge];
     b[1,ge]:=a[0,ge];
     end;
     close(input);
end;

function min:integer;
var
   a,b:longint;
begin
     if t[0]=w[0]+1 then a:=maxlongint else a:=w[0]-t[0];
     if t[1]=w[1]+1 then b:=maxlongint else b:=w[1]-t[1];
     if a<b then exit(0) else exit(1);
end;

function check(s:string;x:integer):boolean;
var
   i:integer;
begin
     for i:=1 to w[x] do
     if dui[x,i]=s then
     begin
          writeln(time1+time[x,i]+1);
          close(output);halt;
     end;
     exit(false);
end;

procedure kuo(x:integer;s:string);
var
   i,p,pp,j:integer;
   ss,bs,bbs:string;
begin
     bs:=s;
     for i:=1 to ge do
     begin
          p:=pos(a[x,i],s);
          while p<>0 do
          begin
               ss:=s;
               delete(ss,p,length(a[x,i]));
               insert(b[x,i],ss,p);
                   if not check(ss,1-x) then
                   begin
                        inc(w[x]);
                        time[x,w[x]]:=time1+1;
                        dui[x,w[x]]:=ss;
                   end;
               bbs:=copy(s,p+1,length(s)-p);
               pp:=pos(a[x,i],bbs);
               if pp<>0 then inc(p,pp) else p:=0;
          end;
     end;
end;

procedure dbfs;
var
   tt:integer;
   s:string;
begin
     t[0]:=1;w[0]:=1;
     dui[0,t[0]]:=aa;
     t[1]:=1;w[1]:=1;
     dui[1,t[1]]:=bb;
     time[0,1]:=0;time[1,1]:=0;
     while(t[0]<=w[0])or(t[1]<=w[1])do
     begin
          tt:=min;
          s:=dui[tt,t[tt]];
          time1:=time[tt,t[tt]];
          kuo(tt,s);
          inc(t[tt]);
          if time[0,t[0]]+time[1,t[1]]>10 then
          begin
          writeln('NO ANSWER!');
          close(output);halt;
          end;
     end;
end;

begin
     assign(input,'b.in');assign(output,'b.out');
     reset(input);rewrite(output);
     init;
     dbfs;
end.

