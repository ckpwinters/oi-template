const
	MAXN = 1000000;
	MAXM = 4000000;
var
	a:array[1..MAXN]of longint;
	i,x,y,n,m,l1,l2:longint;
procedure swap(var a,b:longint);
var t:longint;
begin
	t:=a; a:=b; b:=t;
end;

begin
	assign(output,'E.in'); rewrite(output);
	n:=MAXN; m:=MAXM;
	writeln(n,' ',m);
	for i:=1 to n do a[i]:=i;
	randomize;
	for i:=n downto 2 do swap(a[i],a[random(i-1)+1]);
	l1:=random(1000)+5000;
	l2:=random(1000)+50000;
	for i:=2 to n do writeln(a[random(i-1)+1],' ',a[i],' ',random(100)+l1);
	for i:=n to m do begin
		repeat
			x:=a[random(n)+1];
			y:=a[random(n)+1];
		until x<>y;
		writeln(x,' ',y,' ',random(1000)+l2);
	end;
	close(output);
end.

