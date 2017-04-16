import
  nimgame2 / [
    nimgame,
    scene,
    types,
  ],
  data


type
  TitleScene = ref object of Scene


proc init*(scene: TitleScene) =
  init Scene(scene)


proc free*(scene: TitleScene) =
  discard


proc newTitleScene*(): TitleScene =
  new result, free
  init result


method event*(scene: TitleScene, event: Event) =
  if event.kind == KeyDown:
    game.scene = mainScene

