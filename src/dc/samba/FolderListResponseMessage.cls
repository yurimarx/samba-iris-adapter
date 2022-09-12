Class dc.samba.FolderListResponseMessage Extends Ens.Response
{

Property SambaFiles As list Of %String;

Storage Default
{
<Data name="FolderListResponseMessageDefaultData">
<Subscript>"FolderListResponseMessage"</Subscript>
<Value name="1">
<Value>SambaFiles</Value>
</Value>
</Data>
<DefaultData>FolderListResponseMessageDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
