Class dc.samba.SambaBusinessOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "Ens.OutboundAdapter";

Parameter INVOCATION = "Queue";

Parameter SETTINGS = "Server:Basic,Port:Basic,Share:Basic,Folder:Basic,Credentials:Basic";

Property Server As %String;

Property Port As %Integer;

Property Share As %String;

Property Credentials As %String;

/// Create Remote Folders using SMB
Method CreateFolder(pReq As dc.samba.CreateFolderMessage, Output pResponse As Ens.StringResponse) As %Status
{
    Set sc = $$$OK
    
    Set cred = ##class(Ens.Config.Credentials).%OpenId(..Credentials)
    Set username = cred.Username
    Set password = cred.Password  
    Set server = ..Server
    Set port = ..Port
    Set share = ..Share
    Set folder = pReq.Folder

    Set sc = ##class(dc.samba.SambaService).CreateFolder(server, port, share, username, password, folder)

    Return sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="dc.samba.CreateFolderMessage">
    <Method>CreateFolder</Method>
  </MapItem>
</MapItems>
}

}
