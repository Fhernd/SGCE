/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

//var xhr = null;

function viewReport( idCedulaNit, codigoCuenta, actualElement )
{
    var childsT = actualElement.parentNode.parentNode.childNodes;
    
    var monthTD = childsT[ 1 ];
    
    var selectMonthSelect = monthTD.childNodes;
    
    var fechaExtracto = selectMonthSelect[ 0 ].options[ selectMonthSelect[ 0 ].selectedIndex ].value;
    
    //xhr = createXhr;
    
    document.getElementById('reportPlaceHolder').src = "Extracto_Generar.jsp?codigoCuenta=" + codigoCuenta + "&idCedulaNit=" + idCedulaNit + "&fechaExtracto=" + fechaExtracto;

    return false;
} // end function viewReport

function downloadReport( idCedulaNit, codigoCuenta, actualElement )
{
    var childsT = actualElement.parentNode.parentNode.childNodes;
    
    var monthTD = childsT[ 1 ];
    
    var selectMonthSelect = monthTD.childNodes;
    
    var fechaExtracto = selectMonthSelect[ 0 ].options[ selectMonthSelect[ 0 ].selectedIndex ].value;
    
    document.getElementById('reportPlaceHolder').src = "Extracto_Descargar.jsp?codigoCuenta=" + codigoCuenta + "&idCedulaNit=" + idCedulaNit + "&fechaExtracto=" + fechaExtracto;

    return false;
} // end function viewReport

function printReport( idCedulaNit, codigoCuenta, actualElement )
{
    var childsT = actualElement.parentNode.parentNode.childNodes;
    
    var monthTD = childsT[ 1 ];
    
    var selectMonthSelect = monthTD.childNodes;
    
    var fechaExtracto = selectMonthSelect[ 0 ].options[ selectMonthSelect[ 0 ].selectedIndex ].value;
    
    document.getElementById('reportPlaceHolder').src = "Extracto_Generar.jsp?codigoCuenta=" + codigoCuenta + "&idCedulaNit=" + idCedulaNit + "&fechaExtracto=" + fechaExtracto;
    
     var printContents = document.getElementById("printableArea").innerHTML;
     var originalContents = document.body.innerHTML;

     document.body.innerHTML = printContents;

     window.print();

     document.body.innerHTML = originalContents;

    return false;
} // end function viewReport

function createXhr()
{
    if( XMLHttpRequest )
    {
        xhr = new XMLHttpRequest();
    } // end if
    else
    {
         xhr = new ActiveXObject( "Microsoft.XMLHTTP" );
    } // end else
    return xhr;
} // end function createXhr

function getReport()
{
    var myUrl = "Reports.jsp";
    alert( "okeh" );
    xhr.open( "GET", myUrl, true );
    xhr.onreadystatechange = useHttpResponse();
    xhr.send( null );

} // end function getServerTime

function useHttpResponse()
{
    if( xhr.readyState == 4 )
    {
        if( xhr.status == 200 )
        {
            var report = xhr.responseBody;
            
            //window.frames["reportPlaceHolder"].src = report;
            document.getElementById( "reportPlaceHolder" ).innerHTML = report;
        }
        else
        {
            alert( "Error" );
        }// end else
    } // end if
} // end function useHttpResponse

function viewCertificate( idCedulaNit, codigoCuenta, actualElement )
{
    
    alert( idCedulaNit );
    alert( codigoCuenta );
    alert( actualElement );
    
    /*
    var childsT = actualElement.parentNode.parentNode.childNodes;
    
    var monthTD = childsT[ 1 ];
    
    var selectMonthSelect = monthTD.childNodes;
    
    var fechaExtracto = selectMonthSelect[ 0 ].options[ selectMonthSelect[ 0 ].selectedIndex ].value;
    
    //xhr = createXhr;
    
    document.getElementById('reportPlaceHolder').src = "Certificado_Generar.jsp?codigoCuenta=" + codigoCuenta + "&idCedulaNit=" + idCedulaNit + "&fechaemision=" + fechaExtracto;
*/
    //return false;
} // end function viewReport

function downloadCertificate( idCedulaNit, codigoCuenta, actualElement )
{
    var childsT = actualElement.parentNode.parentNode.childNodes;
    
    var monthTD = childsT[ 1 ];
    
    var selectMonthSelect = monthTD.childNodes;
    
    var fechaExtracto = selectMonthSelect[ 0 ].options[ selectMonthSelect[ 0 ].selectedIndex ].value;
    
    document.getElementById('reportPlaceHolder').src = "Certificado_Descargar.jsp?codigoCuenta=" + codigoCuenta + "&idCedulaNit=" + idCedulaNit + "&fechaExtracto=" + fechaExtracto;

    return false;
} // end function viewReport