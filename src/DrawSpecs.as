package {
	public final class DrawSpecs {
		/*  General
		=====================================================================*/
		public static const GENERAL_BORDER_COLOR:uint = 0x444444;
		public static const GENERAL_BORDER_WIDTH:Number = 4;
		public static const GENERAL_BACKGROUND:uint = 0xB2D2FF;
		public static const STAGE_WIDTH:Number = 800;
		public static const STAGE_HEIGHT:Number = 600;
		
		/*  Buttons
		=====================================================================*/
		public static const BUTTON_RUN_WIDTH:Number = ITEM_BUTTON_WIDTH * 2;
		public static const BUTTON_RUN_HEIGHT:Number = 64;
		public static const BUTTON_BACKGROUND:uint = GENERAL_BACKGROUND;
		public static const BUTTON_STOP_BACKGROUND:uint = 0xFFA198;
		public static const BUTTON_HOVER_BACKGROUND:uint = 0xA0C0ED;
		public static const BUTTON_STOP_HOVER_BACKGROUND:uint = 0xED8F86;
		public static const BUTTON_RESET_WIDTH:Number = ITEM_BUTTON_WIDTH * 2;
		public static const BUTTON_RESET_HEIGHT:Number = 48;
		public static const BUTTON_RESET_Y:Number = BUTTON_RUN_HEIGHT + 12;
		
		/*  Nodes
		=====================================================================*/
		public static const NODE_WIDTH:Number = 48;
		public static const NODE_BORDER_THICKNESS:Number = GENERAL_BORDER_WIDTH;
		public static const NODE_BORDER_COLOR:uint = GENERAL_BORDER_COLOR;
		public static const NODE_BASIC_OFFSET:Number = 9;
		public static const NODE_GOAL_OFFSET:Number = -4;
		public static const NODE_CANDIDATE_ALPHA:Number = .25;
		
		/*  Edges
		=====================================================================*/
		public static const EDGE_COLOR:uint = 0x243996;
		public static const EDGE_WIDTH:Number = 5;
		public static const BREAK_COLOR:uint = 0x962439;
		
		/*  Text
		=====================================================================*/
		public static const TEXT_TITLE_SIZE:Object = 36;
		public static const TEXT_NODE_SIZE:Object = 24;
		public static const TEXT_BUTTON_SIZE:Object = 24;
		public static const TEXT_BUTTON_LG_SIZE:Object = 32;
		public static const TEXT_COLOR:uint = 0x444444;
		
		/*  Windows
		=====================================================================*/
		public static const FIELD_WINDOW_BACKGROUND:uint = 0xB2D2FF;
		public static const FIELD_WINDOW_WIDTH:Number = 625;
		public static const FIELD_WINDOW_HEIGHT:Number = 525;
		public static const FIELD_WINDOW_X:Number = 25;
		public static const FIELD_WINDOW_Y:Number = 50;
		public static const ITEM_WINDOW_X:Number = 665;
		public static const ITEM_WINDOW_Y:Number = 285;
		public static const GAME_OPTIONS_WINDOW_X:Number = ITEM_WINDOW_X;
		public static const GAME_OPTIONS_WINDOW_Y:Number = FIELD_WINDOW_Y;
		public static const POPUP_WINDOW_WIDTH:Number = 400;
		public static const POPUP_WINDOW_HEIGHT:Number = 300;
		
		/*  Item Window Elements
		=====================================================================*/
		public static const ITEM_BUTTON_BACKGROUND:uint = GENERAL_BACKGROUND;
		public static const ITEM_BUTTON_WIDTH:Number = 56;
		public static const ITEM_BUTTON_HEIGHT:Number = ITEM_BUTTON_WIDTH;
		public static const ITEM_BUTTON_EDGE_X1:Number = 15;
		public static const ITEM_BUTTON_EDGE_Y1:Number = 15;
		public static const ITEM_BUTTON_EDGE_X2:Number = 40;
		public static const ITEM_BUTTON_EDGE_Y2:Number = 40;
		public static const ITEM_BUTTON_ITEM_ALPHA:Number = .6;
		public static const ITEM_BUTTON_SCALE:Number = .7;
	}
}