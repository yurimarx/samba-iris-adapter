Class dc.samba.SambaCreateFileService Extends Ens.BusinessService
{

Parameter ADAPTER = "Ens.InboundAdapter";

Method OnProcessInput(pInput As dc.samba.CreateFileMessage, pOutput As Ens.StringResponse) As %Status
{
    Set tSC=$$$OK
    If pInput '= "" {
        Set tSC = ..SendRequestSync("SambaBusinessOperation", pInput, .pResp, 100)
    }
    //Set pOutput = pResp
    Quit tSC
}

}
