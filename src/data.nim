import
  nimgame2 / [
    assets,
    audio,
    scene,
    texturegraphic,
    truetypefont,
  ]


const
  GameWidth* = 640
  GameHeight* = 360
  GameTitle* = "Nimgame 2 Bounce"


var
  titleScene*, mainScene*: Scene
  defaultFont*, bigFont*: TrueTypeFont
  gfxData*: Assets[TextureGraphic]
  score1*, score2*: int
  sfxData*: Assets[Sound]


proc loadData*() =
  defaultFont = newTrueTypeFont()
  if not defaultFont.load("data/fnt/FSEX300.ttf", 16):
    echo "ERROR: Can't load font"
  bigFont = newTrueTypeFont()
  if not bigFont.load("data/fnt/FSEX300.ttf", 32):
    echo "ERROR: Can't load font"

  gfxData = newAssets[TextureGraphic](
    "data/gfx",
    proc(file: string): TextureGraphic = newTextureGraphic(file))

  sfxData = newAssets[Sound](
    "data/sfx",
    proc(file: string): Sound = newSound(file))


proc freeData*() =
  defaultFont.free()
  bigFont.free()
  for graphic in gfxData.values:
    graphic.free()
  for sound in sfxData.values:
    sound.free()

