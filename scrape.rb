# encoding: UTF-8

require 'easyparser'
require 'open-uri'

ep_source = '
  <html>
    <head>{...}</head>
    <body>
      {...}
      <div id="wrapper-int">
        {...}
        <div id="main">
          {...}
          <div class="auxi-art">
            {...}
              <div class="cuerpo">
                {...}
                {many}
                  <table>
                    {many}
                      <tbody>
                        {many}
                          <tr>
                            <td>{$tipo}{/.*/}{/$tipo}</td>
                            {either}
                              <td>
                                {$denominacion}{/.*/}{/$denominacion}
                              </td>
                            {or}
                              <td>
                                <p>{$denominacion}{/.*/}{/$denominacion}</p>
                              </td>
                            {/either}
                            <td>{$numero}{/.*/}{/$numero}</td>
                            <td>{$fecha}{/.*/}{/$fecha}</td>
                            {either}
                              <td>
                                {$medio_y_fecha}{/.*/}{/$medio_y_fecha}
                              </td>
                            {or}
                              <td>
                                <p>{$medio_y_fecha}{/.*/}{/$medio_y_fecha}</p>
                              </td>
                            {/either}
                            <td>{$ultimo_update}{/.*/}{/$ultimo_update}</td>
                            <td>{$efectos}{/.*/}{/$efectos}</td>
                            <td>{$descripcion}{/.*/}{/$descripcion}</td>
                            {...}
                          </tr>
                        {/many}
                      </tbody>
                    {/many}
                  </table>
                  {...but}<table>{...}</table>{/...but}
                {/many}
                {...}
              </div>
            {...}
          </div>
        </div>
      </div>
      {...}
    </body>
  </html>
'

easy_parser = EasyParser.new ep_source do |on|
  on.descripcion do |scope|
    puts "#{scope['tipo']},\"#{scope['denominacion']}\",#{scope['numero']},#{scope['fecha']},\"#{scope['medio_y_fecha']}\",\"#{scope['ultimo_update']}\",\"#{scope['efectos']}\",\"#{scope['descripcion']}\""
  end
end

result, scope = easy_parser.run open('http://www.consejotransparencia.cl/actos-y-resoluciones-con-efectos-sobre-terceros/consejo/2012-12-18/195924.html')
