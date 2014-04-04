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
                    <tbody>
                      {many}
                        <tr>
                          <td>{$tipo}{/.*/}{/$tipo}</td>
                          <td>{$denominacion}{/.*/}{/$denominacion}</td>
                          <td>{$numero}{/.*/}{/$numero}</td>
                          <td>{$fecha}{/.*/}{/$fecha}</td>
                          <td>{$medio_y_fecha}{/.*/}{/$medio_y_fecha}</td>
                          <td>{$ultimo_update}{/.*/}{/$ultimo_update}</td>
                          <td>{$efectos}{/.*/}{/$efectos}</td>
                          <td>{$descripcion}{/.*/}{/$descripcion}</td>
                          {...}
                        </tr>
                      {/many}
                    </tbody>
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
    puts "#{scope['tipo']},#{scope['denominacion']},#{scope['numero']},#{scope['fecha']},#{scope['medio_y_fecha']},#{scope['ultimo_update']},#{scope['efectos']},\"#{scope['descripcion']}\""
  end
end

result, scope = easy_parser.run File.read 'sample.html'
# result, scope = easy_parser.run open('http://www.consejotransparencia.cl/actos-y-resoluciones-con-efectos-sobre-terceros/consejo/2012-12-18/195924.html')
p result
