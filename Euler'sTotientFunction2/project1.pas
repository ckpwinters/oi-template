var
   su:array[1..20000]of longint;
   hash:array[0..40000]of boolean;
   n,ans,si:longint;
procedure shai(n:longint);
var
   sqrtn,temp,i,j:longint;
begin
     si:=0;
     fillchar(hash,sizeof(hash),true);
     sqrtn:=trunc(sqrt(n));
     for i:=2 to n do
     if hash[i] then
     begin
          inc(si);
          su[si]:=i;
          temp:=i*2;
          while temp<=n do
          begin
               hash[temp]:=false;
               temp:=temp+i;
          end;
     end;
end;

procedure main;
var
   i,j,ge,temp:longint;
begin
     ans:=1;
     for i:=1 to n do
     begin
          ge:=1;
          temp:=i;
          for j:=1 to si do
          begin
               if i mod su[j]=0 then
               begin
                    ge:=ge*(su[j]-1);
                    temp:=temp div su[j];
                    while temp mod su[j]=0 do
                    begin ge:=ge*su[j];temp:=temp div su[j] end;
               end;
               if su[j]>i then break;
          end;
          ans:=ans+ge*2;
     end;
end;

begin
     assign(input,'points.in');
     assign(output,'points.out');
     reset(input);rewrite(output);
     readln(n);
     shai(n);
     main;
     writeln(ans);
     close(input);close(output);
end.

