function viewCertificate( idCedulaNit, codigoCuenta, actualElement )
{
    var childsT = actualElement.parentNode.parentNode.childNodes;
    
    var monthTD = childsT[ 1 ];
    
    var selectMonthSelect = monthTD.childNodes;
    
    var fechaExtracto = selectMonthSelect[ 0 ].options[ selectMonthSelect[ 0 ].selectedIndex ].value;
   
    //xhr = createXhr;
    
    document.getElementById('reportPlaceHolder').src = "Certificado_Generar.jsp?codigoCuenta=" + codigoCuenta + "&idCedulaNit=" + idCedulaNit + "&fechaemision=" + fechaExtracto;

    return false;
} // end function viewReport

function downloadCertificate( idCedulaNit, codigoCuenta, actualElement )
{
    
    var childsT = actualElement.parentNode.parentNode.childNodes;
    
    var monthTD = childsT[ 1 ];
    
    var selectMonthSelect = monthTD.childNodes;
    
    var fechaExtracto = selectMonthSelect[ 0 ].options[ selectMonthSelect[ 0 ].selectedIndex ].value;
    
    document.getElementById('reportPlaceHolder').src = "Certificado_Descargar.jsp?codigoCuenta=" + codigoCuenta + "&idCedulaNit=" + idCedulaNit + "&fechaemision=" + fechaExtracto;

    return false;
} // end function viewReport