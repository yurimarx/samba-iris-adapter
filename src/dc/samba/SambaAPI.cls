Class dc.samba.SambaAPI Extends %CSP.REST
{

Parameter CHARSET = "utf-8";

Parameter CONVERTINPUTSTREAM = 1;

Parameter CONTENTTYPE = "application/json";

Parameter Version = "1.0.0";

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>

<!-- Create Folder -->
<Route Url="/CreateFolder" Method="POST" Call="CreateFolder" />

<!-- Download remote file -->
<Route Url="/DownloadFile" Method="POST" Call="DownloadFile" />


<!-- Post File into a Folder -->
<Route Url="/CreateFile/:Folder" Method="POST" Call="CreateFile" />

<!-- Delete Folder -->
<Route Url="/DeleteFolder" Method="DELETE" Call="DeleteFolder" />

<!-- List Files Into Folder -->
<Route Url="/ListFilesIntoFolder/:Folder" Method="GET" Call="ListFilesIntoFolder" />


</Routes>
}

ClassMethod CreateFolder() As %Status
{
    Set tSC = $$$OK
    
    Set data = {}.%FromJSON(%request.Content)

    Do ##class(Ens.Director).CreateBusinessService("SambaBusinessService", .tBS)
    Set req = ##class(dc.samba.CreateFolderMessage).%New()
    Set req.Folder = data.Folder
    Set tSC = tBS.ProcessInput(req, .resp)
      
	quit tSC
}

ClassMethod DownloadFile() As %Status
{
	Set tSC = $$$OK 
    
    Set data = {}.%FromJSON(%request.Content)

    Do ##class(Ens.Director).CreateBusinessService("SambaBusinessService", .tBS)
    Set req = ##class(dc.samba.DownloadFileMessage).%New()
    Set req.Folder = data.Folder
    Set req.Filename = data.Filename
    Set tSC = tBS.ProcessInput(req, .resp)
    
    Set %response.ContentType = ..GetContentType(data.Filename)
    Do %response.SetHeader("Content-Disposition","attachment;filename=""" + data.Filename + """")
    Set %response.NoCharSetConvert=1
    Set %response.Headers("Access-Control-Allow-Origin")="*"
    
    Set stream=##class(%Stream.FileBinary).%New()
    Set sc=stream.LinkToFile(resp.Filepath)
    Do stream.OutputToDevice()
    
	quit tSC
}

ClassMethod DeleteFolder() As %Status
{
	Set tSC = $$$OK
    
    Set data = {}.%FromJSON(%request.Content)

    Do ##class(Ens.Director).CreateBusinessService("SambaBusinessService", .tBS)
    Set req = ##class(dc.samba.DeleteFolderMessage).%New()
    Set req.Folder = data.Folder
    Set tSC = tBS.ProcessInput(req, .resp)
      
	quit tSC
}

ClassMethod CreateFile(Folder As %String) As %Status
{
   
    //try to do the actions
    try {
        Set info = {}
        Set source = %request.GetMimeData("file")
        Set destination=##class(%Stream.FileBinary).%New()
        Set destination.Filename="/tmp/"_source.FileName
        set tSC=destination.CopyFrom(source) //reader open the file
        set result=destination.%Save()
        Set req=##class(dc.samba.CreateFileMessage).%New()
        Set req.Folder = Folder
        Set req.Filepath = "/tmp/"_source.FileName
        Set req.Filename = source.FileName
        Do ##class(Ens.Director).CreateBusinessService("SambaBusinessService", .tBS)
        Set tSC = tBS.ProcessInput(req, .resp)
    
        set info.message = "File saved"
       
        Set %response.ContentType = ..#CONTENTTYPEJSON
        Set %response.Headers("Access-Control-Allow-Origin")="*"
 
        Write info.%ToJSON()
 
        Set tSC=$$$OK
   
    //returns error message to the user
    } catch e {
        Set tSC=e.AsStatus()
        Set pOutput = tSC
    }
 
    Quit tSC
}

ClassMethod ListFilesIntoFolder(Folder As %String) As %Status
{
	//HANG 15
    Set tSC = $$$OK
    
    Do ##class(Ens.Director).CreateBusinessService("SambaBusinessService", .tBS)
    Set req = ##class(dc.samba.ListIntoFolderMessage).%New()
    Set req.Folder = Folder
    Set tSC = tBS.ProcessInput(req, .sambaResponse)
    Set resp = []
    for i = 1:1:sambaResponse.SambaFiles.Count() {
        Do resp.%Push(sambaResponse.SambaFiles.GetAt(i))
    }
    
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Set %response.Headers("Access-Control-Allow-Origin")="*"

    Write resp.%ToJSON()
    
	quit tSC
}

/// Get ContentType for file extension
ClassMethod GetContentType(Filename As %String) As %String
{
    Set resp = "application/octet-stream"
    
    If $FIND(Filename, ".jpg") {
        Set resp = "image/jpeg"
    } ElseIf $FIND(Filename, ".jpeg") {
        Set resp = "image/jpeg"
    } ElseIf $FIND(Filename, ".png") {
        Set resp = "image/png"
    } ElseIf $FIND(Filename, ".gif") {
        Set resp = "image/gif"
    } ElseIf $FIND(Filename, ".pdf") {
        Set resp = "application/pdf"
    } ElseIf $FIND(Filename, ".avi") {
        Set resp = "video/x-msvideo"
    } ElseIf $FIND(Filename, ".csv") {
        Set resp = "text/csv"
    } ElseIf $FIND(Filename, ".doc") {
        Set resp = "application/msword"
    } ElseIf $FIND(Filename, ".htm") {
        Set resp = "text/html"
    } ElseIf $FIND(Filename, ".jar") {
        Set resp = "application/java-archive"
    } ElseIf $FIND(Filename, ".json") {
        Set resp = "application/json"
    } ElseIf $FIND(Filename, ".mpeg") {
        Set resp = "video/mpeg"
    } ElseIf $FIND(Filename, ".ppt") {
        Set resp = "application/vnd.ms-powerpoint"
    } ElseIf $FIND(Filename, ".tif") {
        Set resp = "image/tiff"
    } ElseIf $FIND(Filename, ".xls") {
        Set resp = "application/vnd.ms-excel"
    } ElseIf $FIND(Filename, ".xml") {
        Set resp = "application/xml"
    } ElseIf $FIND(Filename, ".zip") {
        Set resp = "application/zip"
    } ElseIf $FIND(Filename, ".wav") {
        Set resp = "audio/x-wav"
    }

    Return resp
}

}
