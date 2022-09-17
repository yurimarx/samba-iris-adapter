Class dc.samba.SambaOutboundAdapter Extends (Ens.OutboundAdapter, dc.samba.SambaCommonAdapter)
{

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
    Set message = "Username: "_username_", Password: xxxx, Server: "_server_", Port:"_port_", Share: "_share_" Folder: "_folder 
    Do ##class(Ens.Util.Log).LogInfo($CLASSNAME(),"CreateFolder", message)
     
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

}
