Class dc.samba.SambaBusinessOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "dc.samba.SambaOutboundAdapter";

Parameter INVOCATION = "Queue";

/// Create Remote Folders using SMB
Method CreateFolder(pReq As dc.samba.CreateFolderMessage, Output pResponse As Ens.StringResponse) As %Status
{
    Set sc = $$$OK
    
    Try {
      Set sc = ..Adapter.CreateFolder(pReq, .pResponse)
    } Catch ex {
      Set sc = ex.AsStatus()
    }

    Return sc
}

/// Create Remote Files using SMB
Method CreateFile(pReq As dc.samba.CreateFileMessage, Output pResponse As Ens.StringResponse) As %Status
{
    Set sc = $$$OK
    
    Try {
      Set sc = ..Adapter.CreateFile(pReq, .pResponse)
    } Catch ex {
      Set sc = ex.AsStatus()
    }

    Return sc
}

/// Download Remote Files using SMB
Method DownloadFile(pReq As dc.samba.DownloadFileMessage, Output pResponse As dc.samba.DownloadFileResponseMessage) As %Status
{
    Set sc = $$$OK
    
    Try {
      Set sc = ..Adapter.DownloadFile(pReq, .pResponse)
    } Catch ex {
      Set sc = ex.AsStatus()
    }

    Return sc
}

/// Remove Remote Folders using SMB
Method DeleteFolder(pReq As dc.samba.DeleteFolderMessage, Output pResponse As Ens.StringResponse) As %Status
{
    Set sc = $$$OK
    
    Try {
      Set sc = ..Adapter.DeleteFolder(pReq, .pResponse)
    } Catch ex {
      Set sc = ex.AsStatus()
    }

    Return sc
}

/// List files into Remote Folders using SMB
Method ListFilesIntoFolder(pReq As dc.samba.ListIntoFolderMessage, pResponse As dc.samba.FolderListResponseMessage) As %Status
{
    Set sc = $$$OK
    
    Try {
      Set sc = ..Adapter.ListFilesIntoFolder(pReq, .pResponse)
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
