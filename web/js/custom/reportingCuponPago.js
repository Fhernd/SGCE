


function viewCuponPago( idCedulaNit, codigoInquilino )
{
    
    document.getElementById( 'reportPlaceHolder' ).src = "OpcionesCuponPago/CuponPago_Generar.jsp?codigoInquilino=" + codigoInquilino + "&idCedulaNit=" + idCedulaNit;

    return false;
    
} // end function viewReport


function downloadCuponPago( idCedulaNit, codigoInquilino )
{
    
    document.getElementById('reportPlaceHolder').src = "OpcionesCuponPago/CuponPago_Descargar.jsp?codigoInquilino=" + codigoInquilino + "&idCedulaNit=" + idCedulaNit;

    return false;
} // end function viewReport


