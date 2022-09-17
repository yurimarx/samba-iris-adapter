/// Class with common properties to inbound and outbound adapters
Class dc.samba.SambaCommonAdapter Extends %RegisteredObject [ Abstract ]
{

Property Server As %String(MAXLEN = "") [ InitialExpression = "samba" ];

Property Port As %Integer [ InitialExpression = 139 ];

Property Share As %String(MAXLEN = "") [ InitialExpression = "BobShare" ];

Parameter SETTINGS = "Server:Basic,Port:Basic,Share:Basic,Credentials:Basic:credentialsSelector";

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

}
