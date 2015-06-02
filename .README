==================================================

TextureUtils
--------------------------------------

Haxe - Openfl library to help merge images or small atlases into one atlas.

Based on the [as3 TextureUtils](https://github.com/treefortress/TextureUtils) library from TreeFortress.


Features
--------------------------------------

- Merge dynamically images into one atlas with Sparrow xml format.
- Merge dynamically small Sparrow atlases into one atlas.



--------------------------------------

Merge two or more Sparrow atlases
```haxe
//prepare assets
var atlas1:TextureAtlas = TextureAtlas.loadFromLibrary("img/pack1.png", "img/pack1.xml");
var atlas2:TextureAtlas = TextureAtlas.loadFromLibrary("img/pack2.png", "img/pack2.xml");
var list:Array<TextureAtlas> = [atlas1, atlas2];
var builder:AtlasBuilder = new AtlasBuilder();
//build from atlases
var finalAtlas:TextureAtlas = builder.buildFromAtlas(list);
```

Or create an atlas from images
```haxe
var finalAtlas:TextureAtlas = builder.buildFromIndividual([new Bitmap(Assets.getBitmapData("img/image1.png")), new Bitmap(Assets.getBitmapData("img/image2.png"))] );
```

Then you can use with [tilelayer](https://github.com/elsassph/openfl-tilelayer)
```haxe
var tilesheet = new SparrowTilesheet(finalAtlas.atlas, finalAtlas.fileRaw);
var layer:TileLayer = new TileLayer(tilesheet);
```

TODO
--------------------------------------

- do something when atlas bigger than expected
- other file format