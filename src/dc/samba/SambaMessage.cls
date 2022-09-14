Class dc.samba.SambaMessage Extends Ens.Request
{

Property Folder As %String;

Storage Default
{
<Data name="SambaMessageDefaultData">
<Subscript>"SambaMessage"</Subscript>
<Value name="1">
<Value>Folder</Value>
</Value>
</Data>
<DefaultData>SambaMessageDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
