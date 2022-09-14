Class dc.samba.SambaBusinessOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "Ens.OutboundAdapter";

Parameter INVOCATION = "Queue";

Parameter SETTINGS = "Server:Basic,Port:Basic,Share:Basic,Credentials:Basic:credentialsSelector";

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

    Try {
      Set sc = ##class(dc.samba.SambaService).CreateFolder(server, port, share, username, password, folder)
    } Catch ex {
      Set sc = ex.AsStatus()
    }

    Return sc
}

/// Create Remote Files using SMB
Method CreateFile(pReq As dc.samba.CreateFileMessage, Output pResponse As Ens.StringResponse) As %Status
{
    Set sc = $$$OK
    
    Set cred = ##class(Ens.Config.Credentials).%OpenId(..Credentials)
    Set username = cred.Username
    Set password = cred.Password  
    Set server = ..Server
    Set port = ..Port
    Set share = ..Share
    Set folder = pReq.Folder
    Set filepath = pReq.Filepath
    Set filename = pReq.Filename

    try {
      Set sc = ##class(dc.samba.SambaService).CreateFile(server, port, share, username, password, folder, filepath, filename)
    } Catch ex {
      Set sc = ex.AsStatus()
    }


    Return sc
}

/// Download Remote Files using SMB
Method DownloadFile(pReq As dc.samba.DownloadFileMessage, Output pResponse As dc.samba.DownloadFileResponseMessage) As %Status
{
    Set sc = $$$OK
    
    Set cred = ##class(Ens.Config.Credentials).%OpenId(..Credentials)
    Set username = cred.Username
    Set password = cred.Password  
    Set server = ..Server
    Set port = ..Port
    Set share = ..Share
    Set folder = pReq.Folder
    Set filename = pReq.Filename

    try {
      Set downloadedFilePath = ##class(dc.samba.SambaService).DownloadFile(server, port, share, username, password, folder, filename)

      Set pResponse = ##class(dc.samba.DownloadFileResponseMessage).%New()
      Set pResponse.Filepath = downloadedFilePath
    } Catch ex {
      Set sc = ex.AsStatus()
    }

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

    try {
      Set sc = ##class(dc.samba.SambaService).DeleteFolder(server, port, share, username, password, folder)
    } Catch ex {
      Set sc = ex.AsStatus()
    }

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

    try {
      Set result = ##class(dc.samba.SambaService).ListFiles(server, port, share, username, password, folder)

      Set pResponse = ##class(dc.samba.FolderListResponseMessage).%New()

      For i = 1:1:result.Count() {
        Do pResponse.SambaFiles.Insert(result.GetAt(i))
      }
    } Catch ex {
      Set sc = ex.AsStatus()
    }
  
    Return sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="dc.samba.CreateFolderMessage">
    <Method>CreateFolder</Method>
  </MapItem>
  <MapItem MessageType="dc.samba.CreateFileMessage">
    <Method>CreateFile</Method>
  </MapItem>
  <MapItem MessageType="dc.samba.DownloadFileMessage">
    <Method>DownloadFile</Method>
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
