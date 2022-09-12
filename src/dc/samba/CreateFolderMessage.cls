Class dc.samba.CreateFolderMessage Extends Ens.Request
{

Property Folder As %String;

Storage Default
{
<Data name="CreateFolderMessageDefaultData">
<Subscript>"CreateFolderMessage"</Subscript>
<Value name="1">
<Value>Folder</Value>
</Value>
</Data>
<DefaultData>CreateFolderMessageDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
