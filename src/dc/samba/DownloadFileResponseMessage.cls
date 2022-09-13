Class dc.samba.DownloadFileResponseMessage Extends Ens.Response
{

Property Filepath As %String(MAXLEN = "");

Storage Default
{
<Data name="DownloadFileResponseMessageDefaultData">
<Subscript>"DownloadFileResponseMessage"</Subscript>
<Value name="1">
<Value>Filepath</Value>
</Value>
</Data>
<DefaultData>DownloadFileResponseMessageDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
