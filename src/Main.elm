module Main exposing (main)

import Html exposing (Attribute, Html, div, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (class)


numColumns : Int
numColumns =
    26


numRows : Int
numRows =
    100


columnLabel : Int -> String
columnLabel columnNumber =
    String.fromChar (Char.fromCode (Char.toCode 'A' + columnNumber - 1))


main : Html msg
main =
    div [ class "h-screen overflow-auto" ]
        [ table [ class "border-separate border-spacing-0 font-sheet text-[13px]" ]
            [ thead [] [ headerRow ]
            , tbody [] (List.map bodyRow (List.range 1 numRows))
            ]
        ]


headerRow : Html msg
headerRow =
    tr [] (cornerCell :: List.map columnHeader (List.range 1 numColumns))


cornerCell : Html msg
cornerCell =
    th [ headerBase, class "top-0 left-0 z-20 bg-corner" ] []


columnHeader : Int -> Html msg
columnHeader columnNumber =
    th [ headerBase, class "top-0 z-10 min-w-25 bg-header" ] [ text (columnLabel columnNumber) ]


bodyRow : Int -> Html msg
bodyRow rowNumber =
    tr [] (rowHeader rowNumber :: List.repeat numColumns emptyCell)


rowHeader : Int -> Html msg
rowHeader rowNumber =
    th [ headerBase, class "left-0 z-10 min-w-12 bg-header" ] [ text (String.fromInt rowNumber) ]


emptyCell : Html msg
emptyCell =
    td [ class "h-5 px-1 border-r border-b border-gridline" ] []


headerBase : Attribute msg
headerBase =
    class "sticky h-5 px-1 border-r border-b border-header-line text-header-ink text-[11px] font-normal"
