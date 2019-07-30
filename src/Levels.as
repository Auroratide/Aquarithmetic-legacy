package {
	public final class Levels {
		public static const LEVEL_INVENTORY:Array = [T01, T02];
		
		public static const T01:Object = {
            "name": "Welcome to Aquarithmetic!",
            "difficulty": "tutorial",
            "nodes": [{
                "type": "basic",
                "state": 12,
                "x": 100,
                "y": 100
            }, {
                "type": "goal",
                "state": 0,
                "goalState": 4,
                "x": 100,
                "y": 300
            }, {
                "type": "goal",
                "state": 0,
                "goalState": 3,
                "x": 300,
                "y": 100
            }, {
                "type": "basic",
                "state": 0,
                "x": 200,
                "y": 200
            }],
            "edges": [{
                "type": "basicL",
                "begin": 0,
                "end": 3
            }, {
                "type": "basicL",
                "begin": 3,
                "end": 2
            }, {
                "type": "basicL",
                "begin": 2,
                "end": 0
            }, {
                "type": "breakL",
                "begin": 0,
                "end": 1
            }],
            "items": {
                "basicRelay": 0,
                "basicLine": 0,
                "multiplyRelay": 0,
                "breakLine": 0
            }
        };
		
		public static const T02:Object = {
            "name": "Making Pipes",
            "difficulty": "tutorial",
            "nodes": [{
                "type": "basic",
                "state": 2,
                "x": 150,
                "y": 250
            }, {
                "type": "goal",
                "state": 0,
                "goalState": 1,
                "x": 400,
                "y": 250
            }],
            "edges": [],
            "items": {
                "basicRelay": 0,
                "basicLine": 1,
                "multiplyRelay": 0,
                "breakLine": 0
            }
        };
		
		public static const T03:Object = {
            "name": "Making More Pipes",
            "difficulty": "tutorial",
            "nodes": [{
                "type": "basic",
                "state": 3,
                "x": 150,
                "y": 150
            }, {
                "type": "goal",
                "state": 0,
                "goalState": 1,
                "x": 150,
                "y": 300
            }, {
                "type": "goal",
                "state": 0,
                "goalState": 1,
                "x": 300,
                "y": 150
            }],
            "edges": [],
            "items": {
                "basicRelay": 0,
                "basicLine": 2,
                "multiplyRelay": 0,
                "breakLine": 0
            }
        };
		
		public static const T04:Object = {
            "name": "Must Divide Evenly!",
            "difficulty": "tutorial",
            "nodes": [{
                "type": "basic",
                "state": 9,
                "x": 200,
                "y": 200
            }, {
                "type": "goal",
                "state": 0,
                "goalState": 3,
                "x": 400,
                "y": 200
            }],
            "edges": [{
                "type": "basicL",
                "begin": 0,
                "end": 1
            }],
            "items": {
                "basicRelay": 1,
                "basicLine": 1,
                "multiplyRelay": 0,
                "breakLine": 0
            }
        };
		
		public static const T05:Object = {
            "name": "Redistribution",
            "difficulty": "tutorial",
            "nodes": [{
                "type": "basic",
                "state": 10,
                "x": 200,
                "y": 200
            }, {
                "type": "basic",
                "state": 0,
                "x": 400,
                "y": 350
            }, {
                "type": "goal",
                "state": 4,
                "goalState": 7,
                "x": 400,
                "y": 200
            }],
            "edges": [],
            "items": {
                "basicRelay": 0,
                "basicLine": 2,
                "multiplyRelay": 0,
                "breakLine": 0
            }
        };
		
		public static const T06:Object = {
            "name": "Water Station Teamwork",
            "difficulty": "tutorial",
            "nodes": [{
                "type": "basic",
                "state": 2,
                "x": 400,
                "y": 200
            }, {
                "type": "basic",
                "state": 2,
                "x": 200,
                "y": 350
            }, {
                "type": "goal",
                "state": 0,
                "goalState": 2,
                "x": 400,
                "y": 350
            }],
            "edges": [],
            "items": {
                "basicRelay": 0,
                "basicLine": 2,
                "multiplyRelay": 0,
                "breakLine": 0
            }
        };
		
		public static const N01:Object = {
            "name": "Now You're Ready",
            "difficulty": "novice",
            "nodes": [{
                "type": "basic",
                "state": 3,
                "x": 200,
                "y": 350
            }, {
                "type": "basic",
                "state": 2,
                "x": 400,
                "y": 275
            }, {
                "type": "goal",
                "state": 0,
                "goalState": 2,
                "x": 200,
                "y": 200
            }],
            "edges": [],
            "items": {
                "basicRelay": 1,
                "basicLine": 3,
                "multiplyRelay": 0,
                "breakLine": 0
            }
        };
		
		public static const N02:Object = {
            "name": "Patience",
            "difficulty": "novice",
            "nodes": [{
                "type": "basic",
                "state": 8,
                "x": 200,
                "y": 200
            }, {
                "type": "goal",
                "state": 0,
                "goalState": 7,
                "x": 400,
                "y": 350
            }],
            "edges": [],
            "items": {
                "basicRelay": 2,
                "basicLine": 6,
                "multiplyRelay": 0,
                "breakLine": 0
            }
        };
		
		public static const N03:Object = {
            "name": "Town Trouble",
            "difficulty": "novice",
            "nodes": [{
                "type": "goal",
                "state": 9,
                "goalState": 3,
                "x": 200,
                "y": 350
            }, {
                "type": "goal",
                "state": 4,
                "goalState": 5,
                "x": 300,
                "y": 200
            }, {
                "type": "goal",
                "state": 6,
                "goalState": 11,
                "x": 400,
                "y": 350
            }],
            "edges": [],
            "items": {
                "basicRelay": 2,
                "basicLine": 7,
                "multiplyRelay": 0,
                "breakLine": 0
            }
        };
		
		public static const N04:Object = {
            "name": "Kinda Backwards",
            "difficulty": "novice",
            "nodes": [{
                "type": "basic",
                "state": 12,
                "x": 200,
                "y": 200
            }, {
                "type": "basic",
                "state": 0,
                "x": 400,
                "y": 200
            }, {
                "type": "goal",
                "state": 0,
                "goalState": 4,
                "x": 400,
                "y": 350
            }],
            "edges": [{
                "type": "basicL",
                "begin": 2,
                "end": 0
            }, {
                "type": "basicL",
                "begin": 2,
                "end": 1
            }],
            "items": {
                "basicRelay": 2,
                "basicLine": 6,
                "multiplyRelay": 0,
                "breakLine": 0
            }
        };
		
		public static const N05:Object = {
            "name": "Loops",
            "difficulty": "novice",
            "nodes": [{
                "type": "basic",
                "state": 10,
                "x": 200,
                "y": 200
            }, {
                "type": "basic",
                "state": 14,
                "x": 200,
                "y": 350
            }, {
                "type": "goal",
                "state": 6,
                "goalState": 11,
                "x": 400,
                "y": 275
            }],
            "edges": [],
            "items": {
                "basicRelay": 0,
                "basicLine": 3,
                "multiplyRelay": 0,
                "breakLine": 0
            }
        };
		
		public static const A01:Object = {
            "name": "The Multiplier",
            "difficulty": "apprentice",
            "nodes": [{
                "type": "basic",
                "state": 4,
                "x": 200,
                "y": 200
            }, {
                "type": "basic",
                "state": 9,
                "x": 200,
                "y": 350
            }, {
                "type": "multiply",
                "state": 1,
                "x": 300,
                "y": 275
            }, {
                "type": "goal",
                "state": 0,
                "goalState": 3,
                "x": 400,
                "y": 275
            }],
            "edges": [{
                "type": "basicL",
                "begin": 0,
                "end": 2
            }, {
                "type": "basicL",
                "begin": 1,
                "end": 2
            }],
            "items": {
                "basicRelay": 1,
                "basicLine": 4,
                "multiplyRelay": 0,
                "breakLine": 0
            }
        };
		
		public static const A02:Object = {
            "name": "Triangulation",
            "difficulty": "apprentice",
            "nodes": [{
                "type": "basic",
                "state": 18,
                "x": 200,
                "y": 200
            }, {
                "type": "multiply",
                "state": 4,
                "x": 200,
                "y": 375
            }, {
                "type": "goal",
                "state": 0,
                "goalState": 16,
                "x": 400,
                "y": 350
            }],
            "edges": [{
                "type": "basicL",
                "begin": 1,
                "end": 2
            }],
            "items": {
                "basicRelay": 2,
                "basicLine": 8,
                "multiplyRelay": 1,
                "breakLine": 0
            }
        };
		
		public static const A03:Object = {
            "name": "Last Level So Far",
            "difficulty": "apprentice",
            "nodes": [{
                "type": "basic",
                "state": 24,
                "x": 200,
                "y": 200
            }, {
                "type": "goal",
                "state": 0,
                "goalState": 4,
                "x": 200,
                "y": 350
            }, {
                "type": "goal",
                "state": 0,
                "goalState": 7,
                "x": 400,
                "y": 350
            }],
            "edges": [],
            "items": {
                "basicRelay": 3,
                "basicLine": 12,
                "multiplyRelay": 1,
                "breakLine": 2
            }
        };
		
		/*  */
	}
}