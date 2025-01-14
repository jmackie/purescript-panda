module Panda.Builders.Properties where

import Data.HTTP.Method as HTTP
import Panda.Internal.Types as Types
import Data.String.CodeUnits (singleton)
import Prelude ((<<<))

-- | A fully-polymorphic property.
type StaticProperty
  = forall message update state.
    Types.Property message update state

-- | Make a property.
make :: String -> String -> StaticProperty
make key setting =
  Types.Fixed
    { key
    , value: setting
    }

accept :: String -> StaticProperty
accept = make "accept"

accesskey :: Char -> StaticProperty
accesskey = make "accesskey" <<< singleton

action :: String -> StaticProperty
action = make "action"

align :: String -> StaticProperty
align = make "align"

alt :: String -> StaticProperty
alt = make "alt"

async :: String -> StaticProperty
async = make "async"

autocomplete :: String -> StaticProperty
autocomplete = make "autocomplete"

autofocus :: String -> StaticProperty
autofocus = make "autofocus"

autoplay :: String -> StaticProperty
autoplay = make "autoplay"

bgcolor :: String -> StaticProperty
bgcolor = make "bgcolor"

border :: String -> StaticProperty
border = make "border"

buffered :: String -> StaticProperty
buffered = make "buffered"

challenge :: String -> StaticProperty
challenge = make "challenge"

charset :: String -> StaticProperty
charset = make "charset"

checked :: String -> StaticProperty
checked = make "checked"

cite :: String -> StaticProperty
cite = make "cite"

className :: String -> StaticProperty
className = make "class"

code :: String -> StaticProperty
code = make "code"

codebase :: String -> StaticProperty
codebase = make "codebase"

color :: String -> StaticProperty
color = make "color"

cols :: String -> StaticProperty
cols = make "cols"

colspan :: String -> StaticProperty
colspan = make "colspan"

content :: String -> StaticProperty
content = make "content"

contextmenu :: String -> StaticProperty
contextmenu = make "contextmenu"

controls :: String -> StaticProperty
controls = make "controls"

coords :: String -> StaticProperty
coords = make "coords"

crossorigin :: String -> StaticProperty
crossorigin = make "crossorigin"

data_ :: String -> StaticProperty
data_ = make "data_"

datetime :: String -> StaticProperty
datetime = make "datetime"

default :: String -> StaticProperty
default = make "default"

defer :: String -> StaticProperty
defer = make "defer"

dirname :: String -> StaticProperty
dirname = make "dirname"

disabled :: Boolean -> StaticProperty
disabled =
  make "disabled"
    <<< if _ then "disabled" else ""

download :: String -> StaticProperty
download = make "download"

enctype :: FormEncodingType -> StaticProperty
enctype =
  make "enctype"
    <<< case _ of
        XWWWFormUrlEncoded -> "x-www-form-urlencoded"
        MultipartFormData -> "multipart/form-data"
        TextPlain -> "text/plain"

data FormEncodingType
  = XWWWFormUrlEncoded
  | MultipartFormData
  | TextPlain

for :: String -> StaticProperty
for = make "for"

form :: String -> StaticProperty
form = make "form"

formaction :: String -> StaticProperty
formaction = make "formaction"

headers :: String -> StaticProperty
headers = make "headers"

height :: String -> StaticProperty
height = make "height"

high :: String -> StaticProperty
high = make "high"

href :: String -> StaticProperty
href = make "href"

hreflang :: String -> StaticProperty
hreflang = make "hreflang"

http :: String -> StaticProperty
http = make "http"

icon :: String -> StaticProperty
icon = make "icon"

integrity :: String -> StaticProperty
integrity = make "integrity"

ismap :: String -> StaticProperty
ismap = make "ismap"

keytype :: String -> StaticProperty
keytype = make "keytype"

kind :: String -> StaticProperty
kind = make "kind"

label :: String -> StaticProperty
label = make "label"

language :: String -> StaticProperty
language = make "language"

list :: String -> StaticProperty
list = make "list"

loop :: String -> StaticProperty
loop = make "loop"

low :: String -> StaticProperty
low = make "low"

manifest :: String -> StaticProperty
manifest = make "manifest"

max :: String -> StaticProperty
max = make "max"

maxlength :: String -> StaticProperty
maxlength = make "maxlength"

minlength :: String -> StaticProperty
minlength = make "minlength"

media :: String -> StaticProperty
media = make "media"

method :: HTTP.Method -> StaticProperty
method =
  make "method"
    <<< case _ of
        HTTP.POST -> "POST"
        _ -> "GET"

min :: String -> StaticProperty
min = make "min"

multiple :: String -> StaticProperty
multiple = make "multiple"

muted :: String -> StaticProperty
muted = make "muted"

name :: String -> StaticProperty
name = make "name"

novalidate :: Boolean -> StaticProperty
novalidate =
  make "novalidate"
    <<< if _ then "novalidate" else ""

open :: String -> StaticProperty
open = make "open"

optimum :: String -> StaticProperty
optimum = make "optimum"

pattern :: String -> StaticProperty
pattern = make "pattern"

ping :: String -> StaticProperty
ping = make "ping"

placeholder :: String -> StaticProperty
placeholder = make "placeholder"

poster :: String -> StaticProperty
poster = make "poster"

preload :: String -> StaticProperty
preload = make "preload"

radiogroup :: String -> StaticProperty
radiogroup = make "radiogroup"

readonly :: String -> StaticProperty
readonly = make "readonly"

rel :: String -> StaticProperty
rel = make "rel"

required :: Boolean -> StaticProperty
required =
  make "required"
    <<< if _ then "required" else ""

reversed :: String -> StaticProperty
reversed = make "reversed"

rows :: String -> StaticProperty
rows = make "rows"

rowspan :: String -> StaticProperty
rowspan = make "rowspan"

sandbox :: String -> StaticProperty
sandbox = make "sandbox"

scope :: String -> StaticProperty
scope = make "scope"

scoped :: String -> StaticProperty
scoped = make "scoped"

seamless :: String -> StaticProperty
seamless = make "seamless"

selected :: String -> StaticProperty
selected = make "selected"

shape :: String -> StaticProperty
shape = make "shape"

size :: String -> StaticProperty
size = make "size"

sizes :: String -> StaticProperty
sizes = make "sizes"

span :: String -> StaticProperty
span = make "span"

src :: String -> StaticProperty
src = make "src"

srcdoc :: String -> StaticProperty
srcdoc = make "srcdoc"

srclang :: String -> StaticProperty
srclang = make "srclang"

srcset :: String -> StaticProperty
srcset = make "srcset"

start :: String -> StaticProperty
start = make "start"

step :: String -> StaticProperty
step = make "step"

summary :: String -> StaticProperty
summary = make "summary"

target :: Target -> StaticProperty
target =
  make "target"
    <<< case _ of
        Self -> "_self"
        Blank -> "_blank"
        Parent -> "_parent"
        Top -> "_top"

data Target
  = Self
  | Blank
  | Parent
  | Top

type_ :: String -> StaticProperty
type_ = make "type"

usemap :: String -> StaticProperty
usemap = make "usemap"

value :: String -> StaticProperty
value = make "value"

width :: String -> StaticProperty
width = make "width"

wrap :: String -> StaticProperty
wrap = make "wrap"
