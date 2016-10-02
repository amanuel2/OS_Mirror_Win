
DL=Wscript.Arguments(0) 
DL = mid(DL,1,1)
set wmi = getobject("winmgmts://./root/cimv2")
wql = "select Antecedent , Dependent from Win32_LogicalDiskToPartition"
set results = wmi.execquery(wql)
for each result in results
partition = split(result.Antecedent,"=")(1)
drive = split(result.Dependent,"=")(1)
d = split(drive,":") (0)
d = mid(d,2)
n = split(partition,"#") (1)
n = mid(n,1,1)
'if d = DL then wscript.echo "DRIVE " & DL  & " = DISK " & n & "  (" &  partition & ")"
if d = DL then wscript.echo "SET DN=" & n
next
