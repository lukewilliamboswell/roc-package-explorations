app "example"
    packages {
        cli: "https://github.com/roc-lang/basic-cli/releases/download/0.3.2/tE4xS_zLdmmxmHwHih9kHWQ7fsXtJr7W7h3425-eZFk.tar.br",
        json: "../packages/json/main.roc",
    }
    imports [
        cli.Stdout,
        json.Core.{ jsonWithOptions },
        Decode.{ DecodeResult, fromBytesPartial },
    ]
    provides [main] to cli

main =
    requestBody = Str.toUtf8 "{\"Image\":{\"Animated\":false,\"Height\":600,\"Ids\":[116,943,234,38793],\"Thumbnail\":{\"Height\":125,\"Url\":\"http:\\/\\/www.example.com\\/image\\/481989943\",\"Width\":100},\"Title\":\"View from 15th Floor\",\"Width\":800}}"

    decoder = jsonWithOptions { fieldNameMapping: PascalCase }

    decoded : DecodeResult ImageRequest
    decoded = fromBytesPartial requestBody decoder

    when decoded.result is
        Ok record -> Stdout.line "Successfully decoded image, title:\"\(record.image.title)\""
        Err _ -> crash "Error, failed to decode image"

ImageRequest : {
    image : {
        width : I64,
        height : I64,
        title : Str,
        thumbnail : {
            url : Str,
            height : F32,
            width : F32,
        },
        animated : Bool,
        ids : List U32,
    },
}
