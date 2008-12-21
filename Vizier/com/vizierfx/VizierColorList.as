/**
 * Copyright 2008, President and Fellows of Harvard College
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *  o Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *  o Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *  o Neither the name of the <ORGANIZATION> nor the names of its contributors may
 *    be used to endorse or promote products derived from this software without specific prior written permission.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

package com.vizierfx
{
	public class VizierColorList
	{
		public static var colorNames:Object;
		
		public static function translateColorName(color:String):String {
			var hex_rx:RegExp = /^#[0-9A-Fa-f]{1,6}$/;
		
			if (color.match(hex_rx)) return color; // it's in a hex format that Flex understands, so spit it back where it came from
			else {
				if (!colorNames)
					_initColorNames();
					
				if (colorNames[color] != null) return colorNames[color];
				
				return null;
			}
		}

		private static function _initColorNames():void {
			colorNames = new Object();
			colorNames["aliceblue"]="#f0f8ff";
			colorNames["antiquewhite"]="#faebd7";
			colorNames["antiquewhite1"]="#ffefdb";
			colorNames["antiquewhite2"]="#eedfcc";
			colorNames["antiquewhite3"]="#cdc0b0";
			colorNames["antiquewhite4"]="#8b8378";
			colorNames["aquamarine"]="#7fffd4";
			colorNames["aquamarine1"]="#7fffd4";
			colorNames["aquamarine2"]="#76eec6";
			colorNames["aquamarine3"]="#66cdaa";
			colorNames["aquamarine4"]="#458b74";
			colorNames["azure"]="#f0ffff";
			colorNames["azure1"]="#f0ffff";
			colorNames["azure2"]="#e0eeee";
			colorNames["azure3"]="#c1cdcd";
			colorNames["azure4"]="#838b8b";
			colorNames["beige"]="#f5f5dc";
			colorNames["bisque"]="#ffe4c4";
			colorNames["bisque1"]="#ffe4c4";
			colorNames["bisque2"]="#eed5b7";
			colorNames["bisque3"]="#cdb79e";
			colorNames["bisque4"]="#8b7d6b";
			colorNames["black"]="#000000";
			colorNames["blanchedalmond"]="#ffebcd";
			colorNames["blue"]="#0000ff";
			colorNames["blue1"]="#0000ff";
			colorNames["blue2"]="#0000ee";
			colorNames["blue3"]="#0000cd";
			colorNames["blue4"]="#00008b";
			colorNames["blueviolet"]="#8a2be2";
			colorNames["brown"]="#a52a2a";
			colorNames["brown1"]="#ff4040";
			colorNames["brown2"]="#ee3b3b";
			colorNames["brown3"]="#cd3333";
			colorNames["brown4"]="#8b2323";
			colorNames["burlywood"]="#deb887";
			colorNames["burlywood1"]="#ffd39b";
			colorNames["burlywood2"]="#eec591";
			colorNames["burlywood3"]="#cdaa7d";
			colorNames["burlywood4"]="#8b7355";
			colorNames["cadetblue"]="#5f9ea0";
			colorNames["cadetblue1"]="#98f5ff";
			colorNames["cadetblue2"]="#8ee5ee";
			colorNames["cadetblue3"]="#7ac5cd";
			colorNames["cadetblue4"]="#53868b";
			colorNames["chartreuse"]="#7fff00";
			colorNames["chartreuse1"]="#7fff00";
			colorNames["chartreuse2"]="#76ee00";
			colorNames["chartreuse3"]="#66cd00";
			colorNames["chartreuse4"]="#458b00";
			colorNames["chocolate"]="#d2691e";
			colorNames["chocolate1"]="#ff7f24";
			colorNames["chocolate2"]="#ee7621";
			colorNames["chocolate3"]="#cd661d";
			colorNames["chocolate4"]="#8b4513";
			colorNames["coral"]="#ff7f50";
			colorNames["coral1"]="#ff7256";
			colorNames["coral2"]="#ee6a50";
			colorNames["coral3"]="#cd5b45";
			colorNames["coral4"]="#8b3e2f";
			colorNames["cornflowerblue"]="#6495ed";
			colorNames["cornsilk"]="#fff8dc";
			colorNames["cornsilk1"]="#fff8dc";
			colorNames["cornsilk2"]="#eee8cd";
			colorNames["cornsilk3"]="#cdc8b1";
			colorNames["cornsilk4"]="#8b8878";
			colorNames["crimson"]="#dc143c";
			colorNames["cyan"]="#00ffff";
			colorNames["cyan1"]="#00ffff";
			colorNames["cyan2"]="#00eeee";
			colorNames["cyan3"]="#00cdcd";
			colorNames["cyan4"]="#008b8b";
			colorNames["darkgoldenrod"]="#b8860b";
			colorNames["darkgoldenrod1"]="#ffb90f";
			colorNames["darkgoldenrod2"]="#eead0e";
			colorNames["darkgoldenrod3"]="#cd950c";
			colorNames["darkgoldenrod4"]="#8b6508";
			colorNames["darkgreen"]="#006400";
			colorNames["darkkhaki"]="#bdb76b";
			colorNames["darkolivegreen"]="#556b2f";
			colorNames["darkolivegreen1"]="#caff70";
			colorNames["darkolivegreen2"]="#bcee68";
			colorNames["darkolivegreen3"]="#a2cd5a";
			colorNames["darkolivegreen4"]="#6e8b3d";
			colorNames["darkorange"]="#ff8c00";
			colorNames["darkorange1"]="#ff7f00";
			colorNames["darkorange2"]="#ee7600";
			colorNames["darkorange3"]="#cd6600";
			colorNames["darkorange4"]="#8b4500";
			colorNames["darkorchid"]="#9932cc";
			colorNames["darkorchid1"]="#bf3eff";
			colorNames["darkorchid2"]="#b23aee";
			colorNames["darkorchid3"]="#9a32cd";
			colorNames["darkorchid4"]="#68228b";
			colorNames["darksalmon"]="#e9967a";
			colorNames["darkseagreen"]="#8fbc8f";
			colorNames["darkseagreen1"]="#c1ffc1";
			colorNames["darkseagreen2"]="#b4eeb4";
			colorNames["darkseagreen3"]="#9bcd9b";
			colorNames["darkseagreen4"]="#698b69";
			colorNames["darkslateblue"]="#483d8b";
			colorNames["darkslategray"]="#2f4f4f";
			colorNames["darkslategray1"]="#97ffff";
			colorNames["darkslategray2"]="#8deeee";
			colorNames["darkslategray3"]="#79cdcd";
			colorNames["darkslategray4"]="#528b8b";
			colorNames["darkslategrey"]="#2f4f4f";
			colorNames["darkturquoise"]="#00ced1";
			colorNames["darkviolet"]="#9400d3";
			colorNames["deeppink"]="#ff1493";
			colorNames["deeppink1"]="#ff1493";
			colorNames["deeppink2"]="#ee1289";
			colorNames["deeppink3"]="#cd1076";
			colorNames["deeppink4"]="#8b0a50";
			colorNames["deepskyblue"]="#00bfff";
			colorNames["deepskyblue1"]="#00bfff";
			colorNames["deepskyblue2"]="#00b2ee";
			colorNames["deepskyblue3"]="#009acd";
			colorNames["deepskyblue4"]="#00688b";
			colorNames["dimgray"]="#696969";
			colorNames["dimgrey"]="#696969";
			colorNames["dodgerblue"]="#1e90ff";
			colorNames["dodgerblue1"]="#1e90ff";
			colorNames["dodgerblue2"]="#1c86ee";
			colorNames["dodgerblue3"]="#1874cd";
			colorNames["dodgerblue4"]="#104e8b";
			colorNames["firebrick"]="#b22222";
			colorNames["firebrick1"]="#ff3030";
			colorNames["firebrick2"]="#ee2c2c";
			colorNames["firebrick3"]="#cd2626";
			colorNames["firebrick4"]="#8b1a1a";
			colorNames["floralwhite"]="#fffaf0";
			colorNames["forestgreen"]="#228b22";
			colorNames["gainsboro"]="#dcdcdc";
			colorNames["ghostwhite"]="#f8f8ff";
			colorNames["gold"]="#ffd700";
			colorNames["gold1"]="#ffd700";
			colorNames["gold2"]="#eec900";
			colorNames["gold3"]="#cdad00";
			colorNames["gold4"]="#8b7500";
			colorNames["goldenrod"]="#daa520";
			colorNames["goldenrod1"]="#ffc125";
			colorNames["goldenrod2"]="#eeb422";
			colorNames["goldenrod3"]="#cd9b1d";
			colorNames["goldenrod4"]="#8b6914";
			colorNames["gray"]="#c0c0c0";
			colorNames["gray0"]="#000000";
			colorNames["gray1"]="#030303";
			colorNames["gray2"]="#050505";
			colorNames["gray3"]="#080808";
			colorNames["gray4"]="#0a0a0a";
			colorNames["gray5"]="#0d0d0d";
			colorNames["gray6"]="#0f0f0f";
			colorNames["gray7"]="#121212";
			colorNames["gray8"]="#141414";
			colorNames["gray9"]="#171717";
			colorNames["gray10"]="#1a1a1a";
			colorNames["gray11"]="#1c1c1c";
			colorNames["gray12"]="#1f1f1f";
			colorNames["gray13"]="#212121";
			colorNames["gray14"]="#242424";
			colorNames["gray15"]="#262626";
			colorNames["gray16"]="#292929";
			colorNames["gray17"]="#2b2b2b";
			colorNames["gray18"]="#2e2e2e";
			colorNames["gray19"]="#303030";
			colorNames["gray20"]="#333333";
			colorNames["gray21"]="#363636";
			colorNames["gray22"]="#383838";
			colorNames["gray23"]="#3b3b3b";
			colorNames["gray24"]="#3d3d3d";
			colorNames["gray25"]="#404040";
			colorNames["gray26"]="#424242";
			colorNames["gray27"]="#454545";
			colorNames["gray28"]="#474747";
			colorNames["gray29"]="#4a4a4a";
			colorNames["gray30"]="#4d4d4d";
			colorNames["gray31"]="#4f4f4f";
			colorNames["gray32"]="#525252";
			colorNames["gray33"]="#545454";
			colorNames["gray34"]="#575757";
			colorNames["gray35"]="#595959";
			colorNames["gray36"]="#5c5c5c";
			colorNames["gray37"]="#5e5e5e";
			colorNames["gray38"]="#616161";
			colorNames["gray39"]="#636363";
			colorNames["gray40"]="#666666";
			colorNames["gray41"]="#696969";
			colorNames["gray42"]="#6b6b6b";
			colorNames["gray43"]="#6e6e6e";
			colorNames["gray44"]="#707070";
			colorNames["gray45"]="#737373";
			colorNames["gray46"]="#757575";
			colorNames["gray47"]="#787878";
			colorNames["gray48"]="#7a7a7a";
			colorNames["gray49"]="#7d7d7d";
			colorNames["gray50"]="#7f7f7f";
			colorNames["gray51"]="#828282";
			colorNames["gray52"]="#858585";
			colorNames["gray53"]="#878787";
			colorNames["gray54"]="#8a8a8a";
			colorNames["gray55"]="#8c8c8c";
			colorNames["gray56"]="#8f8f8f";
			colorNames["gray57"]="#919191";
			colorNames["gray58"]="#949494";
			colorNames["gray59"]="#969696";
			colorNames["gray60"]="#999999";
			colorNames["gray61"]="#9c9c9c";
			colorNames["gray62"]="#9e9e9e";
			colorNames["gray63"]="#a1a1a1";
			colorNames["gray64"]="#a3a3a3";
			colorNames["gray65"]="#a6a6a6";
			colorNames["gray66"]="#a8a8a8";
			colorNames["gray67"]="#ababab";
			colorNames["gray68"]="#adadad";
			colorNames["gray69"]="#b0b0b0";
			colorNames["gray70"]="#b3b3b3";
			colorNames["gray71"]="#b5b5b5";
			colorNames["gray72"]="#b8b8b8";
			colorNames["gray73"]="#bababa";
			colorNames["gray74"]="#bdbdbd";
			colorNames["gray75"]="#bfbfbf";
			colorNames["gray76"]="#c2c2c2";
			colorNames["gray77"]="#c4c4c4";
			colorNames["gray78"]="#c7c7c7";
			colorNames["gray79"]="#c9c9c9";
			colorNames["gray80"]="#cccccc";
			colorNames["gray81"]="#cfcfcf";
			colorNames["gray82"]="#d1d1d1";
			colorNames["gray83"]="#d4d4d4";
			colorNames["gray84"]="#d6d6d6";
			colorNames["gray85"]="#d9d9d9";
			colorNames["gray86"]="#dbdbdb";
			colorNames["gray87"]="#dedede";
			colorNames["gray88"]="#e0e0e0";
			colorNames["gray89"]="#e3e3e3";
			colorNames["gray90"]="#e5e5e5";
			colorNames["gray91"]="#e8e8e8";
			colorNames["gray92"]="#ebebeb";
			colorNames["gray93"]="#ededed";
			colorNames["gray94"]="#f0f0f0";
			colorNames["gray95"]="#f2f2f2";
			colorNames["gray96"]="#f5f5f5";
			colorNames["gray97"]="#f7f7f7";
			colorNames["gray98"]="#fafafa";
			colorNames["gray99"]="#fcfcfc";
			colorNames["gray100"]="#ffffff";
			colorNames["green"]="#00ff00";
			colorNames["green1"]="#00ff00";
			colorNames["green2"]="#00ee00";
			colorNames["green3"]="#00cd00";
			colorNames["green4"]="#008b00";
			colorNames["greenyellow"]="#adff2f";
			colorNames["grey"]="#c0c0c0";
			colorNames["grey0"]="#000000";
			colorNames["grey1"]="#030303";
			colorNames["grey2"]="#050505";
			colorNames["grey3"]="#080808";
			colorNames["grey4"]="#0a0a0a";
			colorNames["grey5"]="#0d0d0d";
			colorNames["grey6"]="#0f0f0f";
			colorNames["grey7"]="#121212";
			colorNames["grey8"]="#141414";
			colorNames["grey9"]="#171717";
			colorNames["grey10"]="#1a1a1a";
			colorNames["grey11"]="#1c1c1c";
			colorNames["grey12"]="#1f1f1f";
			colorNames["grey13"]="#212121";
			colorNames["grey14"]="#242424";
			colorNames["grey15"]="#262626";
			colorNames["grey16"]="#292929";
			colorNames["grey17"]="#2b2b2b";
			colorNames["grey18"]="#2e2e2e";
			colorNames["grey19"]="#303030";
			colorNames["grey20"]="#333333";
			colorNames["grey21"]="#363636";
			colorNames["grey22"]="#383838";
			colorNames["grey23"]="#3b3b3b";
			colorNames["grey24"]="#3d3d3d";
			colorNames["grey25"]="#404040";
			colorNames["grey26"]="#424242";
			colorNames["grey27"]="#454545";
			colorNames["grey28"]="#474747";
			colorNames["grey29"]="#4a4a4a";
			colorNames["grey30"]="#4d4d4d";
			colorNames["grey31"]="#4f4f4f";
			colorNames["grey32"]="#525252";
			colorNames["grey33"]="#545454";
			colorNames["grey34"]="#575757";
			colorNames["grey35"]="#595959";
			colorNames["grey36"]="#5c5c5c";
			colorNames["grey37"]="#5e5e5e";
			colorNames["grey38"]="#616161";
			colorNames["grey39"]="#636363";
			colorNames["grey40"]="#666666";
			colorNames["grey41"]="#696969";
			colorNames["grey42"]="#6b6b6b";
			colorNames["grey43"]="#6e6e6e";
			colorNames["grey44"]="#707070";
			colorNames["grey45"]="#737373";
			colorNames["grey46"]="#757575";
			colorNames["grey47"]="#787878";
			colorNames["grey48"]="#7a7a7a";
			colorNames["grey49"]="#7d7d7d";
			colorNames["grey50"]="#7f7f7f";
			colorNames["grey51"]="#828282";
			colorNames["grey52"]="#858585";
			colorNames["grey53"]="#878787";
			colorNames["grey54"]="#8a8a8a";
			colorNames["grey55"]="#8c8c8c";
			colorNames["grey56"]="#8f8f8f";
			colorNames["grey57"]="#919191";
			colorNames["grey58"]="#949494";
			colorNames["grey59"]="#969696";
			colorNames["grey60"]="#999999";
			colorNames["grey61"]="#9c9c9c";
			colorNames["grey62"]="#9e9e9e";
			colorNames["grey63"]="#a1a1a1";
			colorNames["grey64"]="#a3a3a3";
			colorNames["grey65"]="#a6a6a6";
			colorNames["grey66"]="#a8a8a8";
			colorNames["grey67"]="#ababab";
			colorNames["grey68"]="#adadad";
			colorNames["grey69"]="#b0b0b0";
			colorNames["grey70"]="#b3b3b3";
			colorNames["grey71"]="#b5b5b5";
			colorNames["grey72"]="#b8b8b8";
			colorNames["grey73"]="#bababa";
			colorNames["grey74"]="#bdbdbd";
			colorNames["grey75"]="#bfbfbf";
			colorNames["grey76"]="#c2c2c2";
			colorNames["grey77"]="#c4c4c4";
			colorNames["grey78"]="#c7c7c7";
			colorNames["grey79"]="#c9c9c9";
			colorNames["grey80"]="#cccccc";
			colorNames["grey81"]="#cfcfcf";
			colorNames["grey82"]="#d1d1d1";
			colorNames["grey83"]="#d4d4d4";
			colorNames["grey84"]="#d6d6d6";
			colorNames["grey85"]="#d9d9d9";
			colorNames["grey86"]="#dbdbdb";
			colorNames["grey87"]="#dedede";
			colorNames["grey88"]="#e0e0e0";
			colorNames["grey89"]="#e3e3e3";
			colorNames["grey90"]="#e5e5e5";
			colorNames["grey91"]="#e8e8e8";
			colorNames["grey92"]="#ebebeb";
			colorNames["grey93"]="#ededed";
			colorNames["grey94"]="#f0f0f0";
			colorNames["grey95"]="#f2f2f2";
			colorNames["grey96"]="#f5f5f5";
			colorNames["grey97"]="#f7f7f7";
			colorNames["grey98"]="#fafafa";
			colorNames["grey99"]="#fcfcfc";
			colorNames["grey100"]="#ffffff";
			colorNames["honeydew"]="#f0fff0";
			colorNames["honeydew1"]="#f0fff0";
			colorNames["honeydew2"]="#e0eee0";
			colorNames["honeydew3"]="#c1cdc1";
			colorNames["honeydew4"]="#838b83";
			colorNames["hotpink"]="#ff69b4";
			colorNames["hotpink1"]="#ff6eb4";
			colorNames["hotpink2"]="#ee6aa7";
			colorNames["hotpink3"]="#cd6090";
			colorNames["hotpink4"]="#8b3a62";
			colorNames["indianred"]="#cd5c5c";
			colorNames["indianred1"]="#ff6a6a";
			colorNames["indianred2"]="#ee6363";
			colorNames["indianred3"]="#cd5555";
			colorNames["indianred4"]="#8b3a3a";
			colorNames["indigo"]="#4b0082";
			colorNames["ivory"]="#fffff0";
			colorNames["ivory1"]="#fffff0";
			colorNames["ivory2"]="#eeeee0";
			colorNames["ivory3"]="#cdcdc1";
			colorNames["ivory4"]="#8b8b83";
			colorNames["khaki"]="#f0e68c";
			colorNames["khaki1"]="#fff68f";
			colorNames["khaki2"]="#eee685";
			colorNames["khaki3"]="#cdc673";
			colorNames["khaki4"]="#8b864e";
			colorNames["lavender"]="#e6e6fa";
			colorNames["lavenderblush"]="#fff0f5";
			colorNames["lavenderblush1"]="#fff0f5";
			colorNames["lavenderblush2"]="#eee0e5";
			colorNames["lavenderblush3"]="#cdc1c5";
			colorNames["lavenderblush4"]="#8b8386";
			colorNames["lawngreen"]="#7cfc00";
			colorNames["lemonchiffon"]="#fffacd";
			colorNames["lemonchiffon1"]="#fffacd";
			colorNames["lemonchiffon2"]="#eee9bf";
			colorNames["lemonchiffon3"]="#cdc9a5";
			colorNames["lemonchiffon4"]="#8b8970";
			colorNames["lightblue"]="#add8e6";
			colorNames["lightblue1"]="#bfefff";
			colorNames["lightblue2"]="#b2dfee";
			colorNames["lightblue3"]="#9ac0cd";
			colorNames["lightblue4"]="#68838b";
			colorNames["lightcoral"]="#f08080";
			colorNames["lightcyan"]="#e0ffff";
			colorNames["lightcyan1"]="#e0ffff";
			colorNames["lightcyan2"]="#d1eeee";
			colorNames["lightcyan3"]="#b4cdcd";
			colorNames["lightcyan4"]="#7a8b8b";
			colorNames["lightgoldenrod"]="#eedd82";
			colorNames["lightgoldenrod1"]="#ffec8b";
			colorNames["lightgoldenrod2"]="#eedc82";
			colorNames["lightgoldenrod3"]="#cdbe70";
			colorNames["lightgoldenrod4"]="#8b814c";
			colorNames["lightgoldenrodyellow"]="#fafad2";
			colorNames["lightgray"]="#d3d3d3";
			colorNames["lightgrey"]="#d3d3d3";
			colorNames["lightpink"]="#ffb6c1";
			colorNames["lightpink1"]="#ffaeb9";
			colorNames["lightpink2"]="#eea2ad";
			colorNames["lightpink3"]="#cd8c95";
			colorNames["lightpink4"]="#8b5f65";
			colorNames["lightsalmon"]="#ffa07a";
			colorNames["lightsalmon1"]="#ffa07a";
			colorNames["lightsalmon2"]="#ee9572";
			colorNames["lightsalmon3"]="#cd8162";
			colorNames["lightsalmon4"]="#8b5742";
			colorNames["lightseagreen"]="#20b2aa";
			colorNames["lightskyblue"]="#87cefa";
			colorNames["lightskyblue1"]="#b0e2ff";
			colorNames["lightskyblue2"]="#a4d3ee";
			colorNames["lightskyblue3"]="#8db6cd";
			colorNames["lightskyblue4"]="#607b8b";
			colorNames["lightslateblue"]="#8470ff";
			colorNames["lightslategray"]="#778899";
			colorNames["lightslategrey"]="#778899";
			colorNames["lightsteelblue"]="#b0c4de";
			colorNames["lightsteelblue1"]="#cae1ff";
			colorNames["lightsteelblue2"]="#bcd2ee";
			colorNames["lightsteelblue3"]="#a2b5cd";
			colorNames["lightsteelblue4"]="#6e7b8b";
			colorNames["lightyellow"]="#ffffe0";
			colorNames["lightyellow1"]="#ffffe0";
			colorNames["lightyellow2"]="#eeeed1";
			colorNames["lightyellow3"]="#cdcdb4";
			colorNames["lightyellow4"]="#8b8b7a";
			colorNames["limegreen"]="#32cd32";
			colorNames["linen"]="#faf0e6";
			colorNames["magenta"]="#ff00ff";
			colorNames["magenta1"]="#ff00ff";
			colorNames["magenta2"]="#ee00ee";
			colorNames["magenta3"]="#cd00cd";
			colorNames["magenta4"]="#8b008b";
			colorNames["maroon"]="#b03060";
			colorNames["maroon1"]="#ff34b3";
			colorNames["maroon2"]="#ee30a7";
			colorNames["maroon3"]="#cd2990";
			colorNames["maroon4"]="#8b1c62";
			colorNames["mediumaquamarine"]="#66cdaa";
			colorNames["mediumblue"]="#0000cd";
			colorNames["mediumorchid"]="#ba55d3";
			colorNames["mediumorchid1"]="#e066ff";
			colorNames["mediumorchid2"]="#d15fee";
			colorNames["mediumorchid3"]="#b452cd";
			colorNames["mediumorchid4"]="#7a378b";
			colorNames["mediumpurple"]="#9370db";
			colorNames["mediumpurple1"]="#ab82ff";
			colorNames["mediumpurple2"]="#9f79ee";
			colorNames["mediumpurple3"]="#8968cd";
			colorNames["mediumpurple4"]="#5d478b";
			colorNames["mediumseagreen"]="#3cb371";
			colorNames["mediumslateblue"]="#7b68ee";
			colorNames["mediumspringgreen"]="#00fa9a";
			colorNames["mediumturquoise"]="#48d1cc";
			colorNames["mediumvioletred"]="#c71585";
			colorNames["midnightblue"]="#191970";
			colorNames["mintcream"]="#f5fffa";
			colorNames["mistyrose"]="#ffe4e1";
			colorNames["mistyrose1"]="#ffe4e1";
			colorNames["mistyrose2"]="#eed5d2";
			colorNames["mistyrose3"]="#cdb7b5";
			colorNames["mistyrose4"]="#8b7d7b";
			colorNames["moccasin"]="#ffe4b5";
			colorNames["navajowhite"]="#ffdead";
			colorNames["navajowhite1"]="#ffdead";
			colorNames["navajowhite2"]="#eecfa1";
			colorNames["navajowhite3"]="#cdb38b";
			colorNames["navajowhite4"]="#8b795e";
			colorNames["navy"]="#000080";
			colorNames["navyblue"]="#000080";
			colorNames["oldlace"]="#fdf5e6";
			colorNames["olivedrab"]="#6b8e23";
			colorNames["olivedrab1"]="#c0ff3e";
			colorNames["olivedrab2"]="#b3ee3a";
			colorNames["olivedrab3"]="#9acd32";
			colorNames["olivedrab4"]="#698b22";
			colorNames["orange"]="#ffa500";
			colorNames["orange1"]="#ffa500";
			colorNames["orange2"]="#ee9a00";
			colorNames["orange3"]="#cd8500";
			colorNames["orange4"]="#8b5a00";
			colorNames["orangered"]="#ff4500";
			colorNames["orangered1"]="#ff4500";
			colorNames["orangered2"]="#ee4000";
			colorNames["orangered3"]="#cd3700";
			colorNames["orangered4"]="#8b2500";
			colorNames["orchid"]="#da70d6";
			colorNames["orchid1"]="#ff83fa";
			colorNames["orchid2"]="#ee7ae9";
			colorNames["orchid3"]="#cd69c9";
			colorNames["orchid4"]="#8b4789";
			colorNames["palegoldenrod"]="#eee8aa";
			colorNames["palegreen"]="#98fb98";
			colorNames["palegreen1"]="#9aff9a";
			colorNames["palegreen2"]="#90ee90";
			colorNames["palegreen3"]="#7ccd7c";
			colorNames["palegreen4"]="#548b54";
			colorNames["paleturquoise"]="#afeeee";
			colorNames["paleturquoise1"]="#bbffff";
			colorNames["paleturquoise2"]="#aeeeee";
			colorNames["paleturquoise3"]="#96cdcd";
			colorNames["paleturquoise4"]="#668b8b";
			colorNames["palevioletred"]="#db7093";
			colorNames["palevioletred1"]="#ff82ab";
			colorNames["palevioletred2"]="#ee799f";
			colorNames["palevioletred3"]="#cd6889";
			colorNames["palevioletred4"]="#8b475d";
			colorNames["papayawhip"]="#ffefd5";
			colorNames["peachpuff"]="#ffdab9";
			colorNames["peachpuff1"]="#ffdab9";
			colorNames["peachpuff2"]="#eecbad";
			colorNames["peachpuff3"]="#cdaf95";
			colorNames["peachpuff4"]="#8b7765";
			colorNames["peru"]="#cd853f";
			colorNames["pink"]="#ffc0cb";
			colorNames["pink1"]="#ffb5c5";
			colorNames["pink2"]="#eea9b8";
			colorNames["pink3"]="#cd919e";
			colorNames["pink4"]="#8b636c";
			colorNames["plum"]="#dda0dd";
			colorNames["plum1"]="#ffbbff";
			colorNames["plum2"]="#eeaeee";
			colorNames["plum3"]="#cd96cd";
			colorNames["plum4"]="#8b668b";
			colorNames["powderblue"]="#b0e0e6";
			colorNames["purple"]="#a020f0";
			colorNames["purple1"]="#9b30ff";
			colorNames["purple2"]="#912cee";
			colorNames["purple3"]="#7d26cd";
			colorNames["purple4"]="#551a8b";
			colorNames["red"]="#ff0000";
			colorNames["red1"]="#ff0000";
			colorNames["red2"]="#ee0000";
			colorNames["red3"]="#cd0000";
			colorNames["red4"]="#8b0000";
			colorNames["rosybrown"]="#bc8f8f";
			colorNames["rosybrown1"]="#ffc1c1";
			colorNames["rosybrown2"]="#eeb4b4";
			colorNames["rosybrown3"]="#cd9b9b";
			colorNames["rosybrown4"]="#8b6969";
			colorNames["royalblue"]="#4169e1";
			colorNames["royalblue1"]="#4876ff";
			colorNames["royalblue2"]="#436eee";
			colorNames["royalblue3"]="#3a5fcd";
			colorNames["royalblue4"]="#27408b";
			colorNames["saddlebrown"]="#8b4513";
			colorNames["salmon"]="#fa8072";
			colorNames["salmon1"]="#ff8c69";
			colorNames["salmon2"]="#ee8262";
			colorNames["salmon3"]="#cd7054";
			colorNames["salmon4"]="#8b4c39";
			colorNames["sandybrown"]="#f4a460";
			colorNames["seagreen"]="#2e8b57";
			colorNames["seagreen1"]="#54ff9f";
			colorNames["seagreen2"]="#4eee94";
			colorNames["seagreen3"]="#43cd80";
			colorNames["seagreen4"]="#2e8b57";
			colorNames["seashell"]="#fff5ee";
			colorNames["seashell1"]="#fff5ee";
			colorNames["seashell2"]="#eee5de";
			colorNames["seashell3"]="#cdc5bf";
			colorNames["seashell4"]="#8b8682";
			colorNames["sienna"]="#a0522d";
			colorNames["sienna1"]="#ff8247";
			colorNames["sienna2"]="#ee7942";
			colorNames["sienna3"]="#cd6839";
			colorNames["sienna4"]="#8b4726";
			colorNames["skyblue"]="#87ceeb";
			colorNames["skyblue1"]="#87ceff";
			colorNames["skyblue2"]="#7ec0ee";
			colorNames["skyblue3"]="#6ca6cd";
			colorNames["skyblue4"]="#4a708b";
			colorNames["slateblue"]="#6a5acd";
			colorNames["slateblue1"]="#836fff";
			colorNames["slateblue2"]="#7a67ee";
			colorNames["slateblue3"]="#6959cd";
			colorNames["slateblue4"]="#473c8b";
			colorNames["slategray"]="#708090";
			colorNames["slategray1"]="#c6e2ff";
			colorNames["slategray2"]="#b9d3ee";
			colorNames["slategray3"]="#9fb6cd";
			colorNames["slategray4"]="#6c7b8b";
			colorNames["slategrey"]="#708090";
			colorNames["snow"]="#fffafa";
			colorNames["snow1"]="#fffafa";
			colorNames["snow2"]="#eee9e9";
			colorNames["snow3"]="#cdc9c9";
			colorNames["snow4"]="#8b8989";
			colorNames["springgreen"]="#00ff7f";
			colorNames["springgreen1"]="#00ff7f";
			colorNames["springgreen2"]="#00ee76";
			colorNames["springgreen3"]="#00cd66";
			colorNames["springgreen4"]="#008b45";
			colorNames["steelblue"]="#4682b4";
			colorNames["steelblue1"]="#63b8ff";
			colorNames["steelblue2"]="#5cacee";
			colorNames["steelblue3"]="#4f94cd";
			colorNames["steelblue4"]="#36648b";
			colorNames["tan"]="#d2b48c";
			colorNames["tan1"]="#ffa54f";
			colorNames["tan2"]="#ee9a49";
			colorNames["tan3"]="#cd853f";
			colorNames["tan4"]="#8b5a2b";
			colorNames["thistle"]="#d8bfd8";
			colorNames["thistle1"]="#ffe1ff";
			colorNames["thistle2"]="#eed2ee";
			colorNames["thistle3"]="#cdb5cd";
			colorNames["thistle4"]="#8b7b8b";
			colorNames["tomato"]="#ff6347";
			colorNames["tomato1"]="#ff6347";
			colorNames["tomato2"]="#ee5c42";
			colorNames["tomato3"]="#cd4f39";
			colorNames["tomato4"]="#8b3626";
			colorNames["transparent"]="#fffffe";
			colorNames["turquoise"]="#40e0d0";
			colorNames["turquoise1"]="#00f5ff";
			colorNames["turquoise2"]="#00e5ee";
			colorNames["turquoise3"]="#00c5cd";
			colorNames["turquoise4"]="#00868b";
			colorNames["violet"]="#ee82ee";
			colorNames["violetred"]="#d02090";
			colorNames["violetred1"]="#ff3e96";
			colorNames["violetred2"]="#ee3a8c";
			colorNames["violetred3"]="#cd3278";
			colorNames["violetred4"]="#8b2252";
			colorNames["wheat"]="#f5deb3";
			colorNames["wheat1"]="#ffe7ba";
			colorNames["wheat2"]="#eed8ae";
			colorNames["wheat3"]="#cdba96";
			colorNames["wheat4"]="#8b7e66";
			colorNames["white"]="#ffffff";
			colorNames["whitesmoke"]="#f5f5f5";
			colorNames["yellow"]="#ffff00";
			colorNames["yellow1"]="#ffff00";
			colorNames["yellow2"]="#eeee00";
			colorNames["yellow3"]="#cdcd00";
			colorNames["yellow4"]="#8b8b00";
			colorNames["yellowgreen"]="#9acd32";
		}
	}
}