# ElmDocs Roadmap

A Google Sheets–style spreadsheet built in Elm as a learning project.
Repo: `mwright2/elmdocs`. Each stage is built in small steps that can be run and checked in the browser.

## Done

| Stage | Feature | Elm concepts covered |
|---|---|---|
| 0a | Static grid: column letters, row numbers, sticky headers, dark theme | `Html`, lists, `List.map`/`List.range`, Tailwind classes in Elm |
| 0b | Click to select a cell (blue outline), Name Box, active row/column headers, `columnLabel` past Z (AA…) | The Elm Architecture with `Browser.sandbox`, records and type aliases, custom types, `case`, `onClick`, `Html msg` vs `Html Msg`, `classList`, partial application, `let`, recursion |

## Next

| # | Feature | Main Elm concepts |
|---|---|---|
| 1 | **Keyboard navigation**: arrow keys, Tab and Enter move the selection, stopping at the grid edges | `Browser.element`, `Cmd`, `Sub`, `Browser.Events.onKeyDown`, `Json.Decode`, `clamp` |
| 2 | **Cell contents and editing**: type to edit, Enter to commit, Escape to cancel, double-click to edit | `Dict`, `Maybe`, modes as custom types (`Navigating \| Editing Cell String`), `Html.input`/`onInput`, `Browser.Dom.focus` (`Task`) |
| 3 | **Formula bar** next to the Name Box, showing a cell's raw content | Passing data down; deriving view data instead of storing it twice |
| 4 | **Worksheets**: tab bar at the bottom; add, rename, delete and switch sheets; each sheet keeps its own cells and selection | Ordered collections (`List` vs `Array` vs `Dict`), a zipper `{ before, current, after }` so a current sheet always exists, reusing the editing pattern for renaming |
| 5 | **Formulas**: `=A1+B2`, `=SUM(A1:A5)`, cross-sheet references (`Sheet2!A1`), `#REF!` and circular-reference errors | `elm/parser`, recursive custom types for an expression tree, `Result` |
| 6 | **Split into modules**: `Cell`, `Sheet`, `Workbook`, `Formula` | Modules, opaque types, exposing lists |
| 7 | **Tests** for the formula parser and evaluator | `elm-test`, fuzz tests |
| 8 | **Persistence** of the whole workbook to `localStorage` | Ports, JSON encoding and decoding |
| 9 | **Performance** as the grid grows | `Html.Lazy`, `Html.Keyed` |

**Why worksheets come before formulas:** once the model holds several sheets, a cell address has to say which sheet it belongs to. Doing that first means the formula parser handles `Sheet2!A1` from the start instead of being retrofitted.

## Conventions

- Tailwind CSS v4: class names are complete literal strings (never built with `++`); no conflicting utilities on one element; shared and specific classes combined with multiple `class` attributes. To switch between alternatives (e.g. two backgrounds), pick one class with `if`, not `classList`.
- Colours are named tokens in `@theme` in `src/main.css`. Dark mode is the default.
- Workflow: `npm start` (elm reactor), `npm run build`, then refresh `http://localhost:8000/public/index.html`.
