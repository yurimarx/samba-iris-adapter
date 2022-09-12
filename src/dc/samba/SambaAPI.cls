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

    Do ##class(Ens.Director).CreateBusinessService("SambaCreateFolderService", .tBS)
    Set req = ##class(dc.samba.CreateFolderMessage).%New()
    Set req.Folder = data.Folder
    Set tSC = tBS.ProcessInput(req, .resp)
      
	quit tSC
}

ClassMethod DeleteFolder() As %Status
{
	Set tSC = $$$OK
    
    Set data = {}.%FromJSON(%request.Content)

    Do ##class(Ens.Director).CreateBusinessService("SambaDeleteFolderService", .tBS)
    Set req = ##class(dc.samba.DeleteFolderMessage).%New()
    Set req.Folder = data.Folder
    Set tSC = tBS.ProcessInput(req, .resp)
      
	quit tSC
}

ClassMethod ListFilesIntoFolder(Folder As %String) As %Status
{
	//HANG 15
    Set tSC = $$$OK
    
    Do ##class(Ens.Director).CreateBusinessService("SambaListIntoFolderService", .tBS)
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

}
