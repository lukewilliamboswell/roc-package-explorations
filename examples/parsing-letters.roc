app "example"
    packages {
        cli: "https://github.com/roc-lang/basic-cli/releases/download/0.2.1/wx1N6qhU3kKva-4YqsVJde3fho34NqiLD3m620zZ-OI.tar.br",
        parser: "../packages/parser/main.roc",
    }
    imports [
        cli.Stdout,
        parser.ParserCore.{ Parser, buildPrimitiveParser, many },
        parser.ParserStr.{ parseStr },
    ]
    provides [main] to cli

main =
    many letterParser
    |> parseStr inputStr
    |> Result.onErr \_ -> crash "Ooops, something went wrong parsing"
    |> Result.map countLetters
    |> Result.map \countLetterA -> "I counted \(countLetterA) letter A's!"
    |> Result.withDefault ""
    |> Stdout.line

Letter : [A, B, C, Other]

inputStr = "AAAiBByAABBwBtCCCiAyArBBx"

ifLetterA = \l -> l == A

countLetters : List Letter -> Str
countLetters = \letters -> 
    letters
    |> List.keepIf ifLetterA
    |> List.map \_ -> 1
    |> List.sum
    |> Num.toStr

letterParser : Parser (List U8) Letter
letterParser =
    input <- buildPrimitiveParser

    valResult = when input is
        [] -> Err (ParsingFailure "Nothing to parse")
        ['A', ..] -> Ok A
        ['B', ..] -> Ok B
        ['C', ..] -> Ok C
        _ -> Ok Other

    valResult
    |> Result.map \val -> { val, input: List.dropFirst input }

expect
    input = "B"
    parser = letterParser
    result = parseStr parser input
    result == Ok B

expect
    input = "BCXA"
    parser = many letterParser
    result = parseStr parser input
    result == Ok [B, C, Other, A]
