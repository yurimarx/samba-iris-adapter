Class dc.samba.DeleteFolderMessage Extends Ens.Request
{

Property Folder As %String;

Storage Default
{
<Data name="DeleteFolderMessageDefaultData">
<Subscript>"DeleteFolderMessage"</Subscript>
<Value name="1">
<Value>Folder</Value>
</Value>
</Data>
<DefaultData>DeleteFolderMessageDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
