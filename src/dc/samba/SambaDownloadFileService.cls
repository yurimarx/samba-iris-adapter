Class dc.samba.SambaDownloadFileService Extends Ens.BusinessService
{

Parameter ADAPTER = "Ens.InboundAdapter";

Method OnProcessInput(pInput As dc.samba.DownloadFileMessage, pOutput As dc.samba.DownloadFileResponseMessage) As %Status
{
    Set tSC=$$$OK
    
    If pInput '= "" {
        Set tSC = ..SendRequestSync("SambaBusinessOperation", pInput, .pResp, 1000)
        Set pOutput = pResp
    }
    
    Quit tSC
}

}
