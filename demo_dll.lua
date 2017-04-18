

require('luacom')-- luacom

ie = luacom.CreateObject('InternetExplorer.Application')

ie:Navigate2('http://sunxiunan.com')

ie.Visible = true