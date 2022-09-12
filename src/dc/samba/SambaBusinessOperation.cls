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

/// Remove Remote Folders using SMB
Method DeleteFolder(pReq As dc.samba.DeleteFolderMessage, Output pResponse As Ens.StringResponse) As %Status
{
    Set sc = $$$OK
    
    Set cred = ##class(Ens.Config.Credentials).%OpenId(..Credentials)
    Set username = cred.Username
    Set password = cred.Password  
    Set server = ..Server
    Set port = ..Port
    Set share = ..Share
    Set folder = pReq.Folder

    Set sc = ##class(dc.samba.SambaService).DeleteFolder(server, port, share, username, password, folder)

    Return sc
}

/// List files into Remote Folders using SMB
Method ListFilesIntoFolder(pReq As dc.samba.ListIntoFolderMessage, pResponse As dc.samba.FolderListResponseMessage) As %Status
{
    Set sc = $$$OK
    
    Set cred = ##class(Ens.Config.Credentials).%OpenId(..Credentials)
    Set username = cred.Username
    Set password = cred.Password  
    Set server = ..Server
    Set port = ..Port
    Set share = ..Share
    Set folder = pReq.Folder

    Set result = ##class(dc.samba.SambaService).ListFiles(server, port, share, username, password, folder)

    Set pResponse = ##class(dc.samba.FolderListResponseMessage).%New()

    for i = 1:1:result.Count() {
      Do pResponse.SambaFiles.Insert(result.GetAt(i))
    }
  
    Return sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="dc.samba.CreateFolderMessage">
    <Method>CreateFolder</Method>
  </MapItem>
  <MapItem MessageType="dc.samba.DeleteFolderMessage">
    <Method>DeleteFolder</Method>
  </MapItem>
  <MapItem MessageType="dc.samba.ListIntoFolderMessage">
    <Method>ListFilesIntoFolder</Method>
  </MapItem>
</MapItems>
}

}
