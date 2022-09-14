Class dc.samba.SambaBusinessService Extends Ens.BusinessService
{

Parameter ADAPTER = "Ens.InboundAdapter";

Method OnProcessInput(pInput As dc.samba.SambaMessage, pOutput As Ens.Response) As %Status
{
    Set tSC=$$$OK
    
    If pInput '= "" {
        Set tSC = ..SendRequestSync("SambaBusinessOperation", pInput, .pResp, 100)
        Set pOutput = pResp
    }

    Quit tSC
}

}
