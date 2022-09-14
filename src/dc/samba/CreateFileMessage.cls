Class dc.samba.CreateFileMessage Extends dc.samba.SambaMessage
{

Property Folder As %String;

Property Filepath As %String(MAXLEN = "");

Property Filename As %String(MAXLEN = "");

Storage Default
{
<Data name="CreateFileMessageDefaultData">
<Subscript>"CreateFileMessage"</Subscript>
<Value name="1">
<Value>Filepath</Value>
</Value>
<Value name="2">
<Value>Filename</Value>
</Value>
</Data>
<DefaultData>CreateFileMessageDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
