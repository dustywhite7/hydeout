import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Round


-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { n : String
  , q1 : String
  , q2 : String
  , q3 : String
  }


init : Model
init =
  { n = ""
  , q1 = ""
  , q2 = ""
  , q3 = ""
  }



-- UPDATE


type Msg
  = UpdateN String | UpdateQ1 String | UpdateQ2 String | UpdateQ3 String


update : Msg -> Model -> Model
update msg model =
  case msg of
    UpdateN newN ->
      { model | n = newN }
    UpdateQ1 newQ1 ->
      { model | q1 = newQ1 }
    UpdateQ2 newQ2 ->
      { model | q2 = newQ2 }
    UpdateQ3 newQ3 ->
      { model | q3 = newQ3 }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [
    div [classList [
        ("title", True)
    ]] [text "Market Equilibrium Game"]
    , div [classList [
        ("students", True)
        , ("invalid", (Maybe.withDefault 0 (String.toFloat model.n)) > 0 )
    ]] [text "Number of Participants: "
            , input [ placeholder "Total Number of Students", value model.n, onInput UpdateN ] []
            , div [classList [
        ("space", True)
    ]] [ br [] [] ]
    ] 
    , div [classList [
        ("industry", True)
        , ("invalid", (Maybe.withDefault 0 (String.toFloat model.q1)) > 0 )
    ]] [div [] [img [src "apples.png", width 300] [] ]
            , text "Producers in Apple Market: "
            , input [ placeholder "Students in Industry 1", value model.q1, onInput UpdateQ1 ] []
            , div [] [ text ("Apple Profit: " ++ (Round.round 0 ( (Maybe.withDefault 0 (String.toFloat model.n)) * sqrt (5/(Maybe.withDefault 0 (String.toFloat model.q1))) - (Maybe.withDefault 0 (String.toFloat model.n))/2) ) )  ]
            , div [classList [
        ("titspacele", True)
    ]] [ br [] [] ]
    ]
    , div [classList [
        ("industry", True)
        , ("invalid", (Maybe.withDefault 0 (String.toFloat model.q2)) > 0 )
    ]] [div [] [img [src "oranges.png", width 300] [] ]
            , text "Producers in Orange Market: "
            , input [ placeholder "Students in Industry 2", value model.q2, onInput UpdateQ2 ] []
            , div [] [ text ("Microsoft Profit: " ++ (Round.round 0 ( (Maybe.withDefault 0 (String.toFloat model.n))/20 * cos ((pi/(Maybe.withDefault 0 (String.toFloat model.n))) * (Maybe.withDefault 0 (String.toFloat model.q2)) ) + (Maybe.withDefault 0 (String.toFloat model.n))/20 ) ) ) ]
            , div [classList [
        ("space", True)
    ]] [ br [] [] ]
    ]
    , div [classList [
        ("industry", True)
        , ("invalid", (Maybe.withDefault 0 (String.toFloat model.q3)) > 0 )
    ]] [div [] [img [src "bananas.png", width 300] [] ]
            , text "Producers in Banana Market: "
            , input [ placeholder "Students in Industry 3", value model.q3, onInput UpdateQ3 ] []
            , div [] [ text ("Samsung Profit: " ++ (Round.round 0 ( (3/4) * (Maybe.withDefault 0 (String.toFloat model.n)) - (Maybe.withDefault 0 (String.toFloat model.q3))) ) ) ]
    ]

    ]