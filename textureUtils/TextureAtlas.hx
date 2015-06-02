package textureUtils;
import openfl.Assets;
import openfl.display.BitmapData;

/**
 * Contains the atlas (image) and the descriptor file associated with it.
 * @author loudo (Ludovic Bas)
 */
class TextureAtlas
{
	/**
	 * Image
	 */
	public var atlas:BitmapData;
	/**
	 * Xml file
	 */
	public var file:Xml;
	/**
	 * raw string of the xml file
	 */
	public var fileRaw:String;
	public function new(atlas:BitmapData, file:Xml) 
	{
		this.atlas = atlas;
		this.file = file;
		this.fileRaw = file.toString();
	}
	public static function loadFromLibrary(atlas:String, file:String):TextureAtlas
	{
		return new TextureAtlas(Assets.getBitmapData(atlas), Xml.parse(Assets.getText(file)).firstElement());
		//return null;
	}
	
}