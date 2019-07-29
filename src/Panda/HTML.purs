module Panda.HTML
  ( module Builders
  , module Exports
  , delegate
  ) where

import Data.Maybe (Maybe)
import Panda.Internal.Types as Types
import Prelude
-- | Exports from the PH namespace.
import Panda.Builders.HTML (a, a', a'_, a_, abbr, abbr', abbr'_, abbr_, acronym, acronym', acronym'_, acronym_, address, address', address'_, address_, applet, applet', applet'_, applet_, area, area_, article, article', article'_, article_, aside, aside', aside'_, aside_, audio, audio', audio'_, audio_, b, b', b'_, b_, base, base_, basefont, basefont', basefont'_, basefont_, bdi, bdi', bdi'_, bdi_, bdo, bdo', bdo'_, bdo_, big, big', big'_, big_, blockquote, blockquote', blockquote'_, blockquote_, br, br_, button, button', button'_, button_, canvas, canvas', canvas'_, canvas_, caption, caption', caption'_, caption_, center, center', center'_, center_, cite, cite', cite'_, cite_, code, code', code'_, code_, col, col_, colgroup, colgroup', colgroup'_, colgroup_, command, command_, datalist, datalist', datalist'_, datalist_, dd, dd', dd'_, dd_, del, del', del'_, del_, details, details', details'_, details_, dfn, dfn', dfn'_, dfn_, dialog, dialog', dialog'_, dialog_, dir, dir', dir'_, dir_, div, div', div'_, div_, dl, dl', dl'_, dl_, dt, dt', dt'_, dt_, em, em', em'_, em_, embed, embed_, fieldset, fieldset', fieldset'_, fieldset_, figcaption, figcaption', figcaption'_, figcaption_, figure, figure', figure'_, figure_, font, font', font'_, font_, footer, footer', footer'_, footer_, form, form', form'_, form_, frame, frame', frame'_, frame_, frameset, frameset', frameset'_, frameset_, h1, h1', h1'_, h1_, head, head', head'_, head_, header, header', header'_, header_, hr, hr_, i, i', i'_, i_, iframe, iframe', iframe'_, iframe_, img, img_, input, input_, ins, ins', ins'_, ins_, kbd, kbd', kbd'_, kbd_, keygen, keygen_, label, label', label'_, label_, legend, legend', legend'_, legend_, li, li', li'_, li_, main, main', main'_, main_, map, map', map'_, map_, mark, mark', mark'_, mark_, menu, menu', menu'_, menu_, menuitem, menuitem_, meter, meter', meter'_, meter_, nav, nav', nav'_, nav_, noframes, noframes', noframes'_, noframes_, noscript, noscript', noscript'_, noscript_, object, object', object'_, object_, ol, ol', ol'_, ol_, optgroup, optgroup', optgroup'_, optgroup_, option, option', option'_, option_, output, output', output'_, output_, p, p', p'_, p_, param, param_, picture, picture', picture'_, picture_, pre, pre', pre'_, pre_, progress, progress', progress'_, progress_, q, q', q'_, q_, rp, rp', rp'_, rp_, rt, rt', rt'_, rt_, ruby, ruby', ruby'_, ruby_, s, s', s'_, s_, samp, samp', samp'_, samp_, script, script', script'_, script_, section, section', section'_, section_, select, select', select'_, select_, small, small', small'_, small_, sort, sortBy, sortWith, source, source_, span, span', span'_, span_, strike, strike', strike'_, strike_, strong, strong', strong'_, strong_, style, style', style'_, style_, sub, sub', sub'_, sub_, summary, summary', summary'_, summary_, sup, sup', sup'_, sup_, table, table', table'_, table_, tbody, tbody', tbody'_, tbody_, td, td', td'_, td_, template, template', template'_, template_, text, textarea, textarea', textarea'_, textarea_, tfoot, tfoot', tfoot'_, tfoot_, th, th', th'_, th_, thead, thead', thead'_, thead_, time, time', time'_, time_, title, title', title'_, title_, tr, tr', tr'_, tr_, track, track_, tt, tt', tt'_, tt_, u, u', u'_, u_, ul, ul', ul'_, ul_, var, var', var'_, var_, video, video', video'_, video_, wbr, wbr_) as Builders
import Panda.Internal.Types (HTML(..), HTMLUpdate) as Exports

-- | Embed an application into a component, allowing for it to exist in a
-- | larger application. This also gives us the opportunity to filter out
-- | events and updates in which we're not so interested.
delegate ::
  forall input message state subinput suboutput submessage substate.
  { input :: input -> Maybe subinput
  , output :: suboutput -> Maybe message
  } ->
  Types.Component subinput suboutput submessage substate ->
  Types.HTML input message state
delegate focus application =
  Types.Delegate
    $ Types.mkHTMLDelegateX
    $ Types.HTMLDelegate { application, focus }
