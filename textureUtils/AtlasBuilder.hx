package textureUtils;
import haxe.xml.Fast;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
#if debug
import openfl.Lib;
#end
import openfl.geom.Matrix;
import openfl.geom.Rectangle;

/**
 * @author based on treefortress code with different purposes (https://github.com/treefortress/TextureUtils/blob/master/src/treefortress/textureutils/AtlasBuilder.as)
 * @author loudo (Ludovic Bas)
 * TODO improve
 */
class AtlasBuilder
{
	public static var packTime:Int;
	public static var atlasBitmap:BitmapData;
	public static var atlasXml:Xml;
	public function new() 
	{
		
	}
	public function buildFromAtlas(atlasList:Array<TextureAtlas>, scale:Float = 1, padding:Int = 2, width:Int = 2048, height:Int = 2048):TextureAtlas
	{
		#if debug
		var t:Int = Lib.getTimer();
		#end
			
		atlasBitmap = new BitmapData(width, height, true, 0x0);
		var packer:MaxRectPacker = new MaxRectPacker(width, height);
		var atlasText:String = "";
		var bitmapdata:BitmapData, fast:Fast, rect:Rectangle, subText:String, m:Matrix = new Matrix();
		
		var len:Int = atlasList.length;
		for(i in 0...len){
			bitmapdata = atlasList[i].atlas;
			rect = packer.quickInsert((bitmapdata.width * scale) + padding * 2, (bitmapdata.height * scale) + padding * 2);
			
			//Add padding
			rect.x += padding;
			rect.y += padding;
			rect.width -= padding * 2;
			rect.height -= padding * 2;
			
			//Apply scale
			//if(!rect){ trace("Texture Limit Exceeded"); continue; }  //TODO but how ?
			m.identity();
			m.scale(scale, scale);
			m.translate(rect.x, rect.y);
			atlasBitmap.draw(bitmapdata, m);
			
			//Create XML line item for TextureAtlas
			fast = new Fast(atlasList[i].file);
			if (fast.hasNode.SubTexture) {
				subText = "";
				for (node in fast.nodes.SubTexture)
				{
					subText += '<SubTexture name="'+node.att.name+'" ' +
						'x="' + (Std.parseInt(node.att.x) + rect.x) + '" y="' + (Std.parseInt(node.att.y) + rect.y) + '" width="' + node.att.width + '" height="' + node.att.height + '"';
						
					if (node.has.frameX) {
						subText += 'frameX="' + node.att.frameX + '" frameWidth="' + node.att.frameWidth + '"';
					}
					if (node.has.frameY) {
						subText += 'frameY="'+node.att.frameY+'" frameHeight="'+node.att.frameHeight+'"';
					}
					subText += '/>';
				}
				atlasText += subText;
			}
		}
		
		//Create XML from text (much faster than working with an actual XML object)
		atlasText = '<TextureAtlas imagePath="atlas.png">' + atlasText + "</TextureAtlas>";
		atlasXml = Xml.parse(atlasText);
		
		//Create the atlas
		var atlas:TextureAtlas =  new TextureAtlas(atlasBitmap, atlasXml);
		
		#if debug
		//Save elapsed time in case we're curious how long this took
		packTime = Lib.getTimer() - t;
		trace(packTime);
		#end
		
		return atlas;
	}
	
	public function buildFromIndividual(bitmapList:Array<Bitmap>, scale:Float = 1, padding:Int = 2, width:Int = 2048, height:Int = 2048):TextureAtlas
	{
		#if debug
		var t:Int = Lib.getTimer();
		#end
			
		atlasBitmap = new BitmapData(width, height, true, 0x0);
		var packer:MaxRectPacker = new MaxRectPacker(width, height);
		var atlasText:String = "";
		var bitmap:Bitmap, name:String, rect:Rectangle, subText:String, m:Matrix = new Matrix();
		
		var len:Int = bitmapList.length;
		for(i in 0...len){
			bitmap = bitmapList[i];
			name = bitmapList[i].name;
			rect = packer.quickInsert((bitmap.width * scale) + padding * 2, (bitmap.height * scale) + padding * 2);
			
			//Add padding
			rect.x += padding;
			rect.y += padding;
			rect.width -= padding * 2;
			rect.height -= padding * 2;
			
			//Apply scale
			//if(!rect){ trace("Texture Limit Exceeded"); continue; } //TODO but how ?
			m.identity();
			m.scale(scale, scale);
			m.translate(rect.x, rect.y);
			atlasBitmap.draw(bitmap, m);
			
			//Create XML line item for TextureAtlas
			subText = '<SubTexture name="'+name+'" ' +
				'x="'+rect.x+'" y="'+rect.y+'" width="'+rect.width+'" height="'+rect.height+'" frameX="0" frameY="0" ' +
				'frameWidth="'+rect.width+'" frameHeight="'+rect.height+'"/>';
			atlasText = atlasText + subText;
		}
		
		//Create XML from text (much faster than working with an actual XML object)
		atlasText = '<TextureAtlas imagePath="atlas.png">' + atlasText + "</TextureAtlas>";
		atlasXml = Xml.parse(atlasText);
		
		//Create the atlas
		var atlas:TextureAtlas =  new TextureAtlas(atlasBitmap, atlasXml);
		
		#if debug
		//Save elapsed time in case we're curious how long this took
		packTime = Lib.getTimer() - t;
		trace(packTime);
		#end
		
		return atlas;
	}
	
}