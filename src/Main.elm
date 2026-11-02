module Main exposing (main)

import Browser
import Html exposing (Attribute, Html, div, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (class, classList)
import Html.Events exposing (onClick)



-- CONSTANTS


numColumns : Int
numColumns =
    30


numRows : Int
numRows =
    100



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Cell =
    { column : Int
    , row : Int
    }


type alias Model =
    { selected : Cell
    }


init : Model
init =
    { selected = Cell 1 1 }



-- UPDATE


type Msg
    = CellClicked Cell


update : Msg -> Model -> Model
update msg model =
    case msg of
        CellClicked cell ->
            { model | selected = cell }



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "flex h-screen flex-col font-sheet text-[13px]" ]
        [ nameBox model.selected
        , div [ class "min-h-0 flex-1 overflow-auto" ]
            [ table [ class "border-separate border-spacing-0" ]
                [ thead [] [ headerRow model.selected ]
                , tbody [] (List.map (bodyRow model.selected) (List.range 1 numRows))
                ]
            ]
        ]


nameBox : Cell -> Html msg
nameBox selected =
    div [ class "flex shrink-0 items-center border-b border-header-line bg-header px-2 py-1" ]
        [ div [ class "w-24 rounded border border-header-line bg-sheet px-2 py-0.5" ]
            [ text (cellName selected) ]
        ]


headerRow : Cell -> Html msg
headerRow selected =
    tr [] (cornerCell :: List.map (columnHeader selected.column) (List.range 1 numColumns))


cornerCell : Html msg
cornerCell =
    th [ headerBase, class "top-0 left-0 z-20 bg-corner" ] []


columnHeader : Int -> Int -> Html msg
columnHeader selectedColumn columnNumber =
    th
        [ headerBase
        , class "top-0 z-10 min-w-25 bg-header"
        , headerBackground (columnNumber == selectedColumn)
        ]
        [ text (columnLabel columnNumber) ]


bodyRow : Cell -> Int -> Html Msg
bodyRow selected rowNumber =
    let
        cellAt columnNumber =
            dataCell selected (Cell columnNumber rowNumber)
    in
    tr [] (rowHeader selected.row rowNumber :: List.map cellAt (List.range 1 numColumns))


rowHeader : Int -> Int -> Html msg
rowHeader selectedRow rowNumber =
    th
        [ headerBase
        , class "left-0 z-10 min-w-12 bg-header"
        , headerBackground (rowNumber == selectedRow)
        ]
        [ text (String.fromInt rowNumber) ]


dataCell : Cell -> Cell -> Html Msg
dataCell selected cell =
    td
        [ class "h-5 px-1 border-r border-b border-gridline"
        , classList [ ( "outline-2 -outline-offset-1 outline-selection", cell == selected ) ]
        , onClick (CellClicked cell)
        ]
        []


headerBase : Attribute msg
headerBase =
    class "sticky h-5 px-1 border-r border-b border-header-line text-header-ink text-[11px] font-normal"


headerBackground : Bool -> Attribute msg
headerBackground isActive =
    if isActive then
        class "bg-header-active"

    else
        class "bg-header"



-- HELPERS


columnLabel : Int -> String
columnLabel columnNumber =
    let
        index =
            columnNumber - 1

        letter =
            String.fromChar (Char.fromCode (Char.toCode 'A' + modBy 26 index))
    in
    if index < 26 then
        letter

    else
        columnLabel (index // 26) ++ letter


cellName : Cell -> String
cellName cell =
    columnLabel cell.column ++ String.fromInt cell.row
