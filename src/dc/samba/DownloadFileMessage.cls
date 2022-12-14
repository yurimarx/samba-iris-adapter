Class dc.samba.DownloadFileMessage Extends dc.samba.SambaMessage
{

Property Folder As %String;

Property Filename As %String(MAXLEN = "");

Storage Default
{
<Data name="DownloadFileMessageDefaultData">
<Subscript>"DownloadFileMessage"</Subscript>
<Value name="1">
<Value>Filename</Value>
</Value>
</Data>
<DefaultData>DownloadFileMessageDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
