import{initial as e,read as t}from"./fen.js";import{timer as o}from"./util.js";import"./types.js";function defaults(){return{pieces:t(e),orientation:"white",turnColor:"white",coordinates:true,coordinatesOnSquares:false,ranksPosition:"right",autoCastle:true,viewOnly:false,disableContextMenu:false,addPieceZIndex:false,blockTouchScroll:false,pieceKey:false,trustAllEvents:false,highlight:{lastMove:true,check:true},animation:{enabled:true,duration:200},movable:{free:true,color:"both",showDests:true,events:{},rookCastle:true},premovable:{enabled:true,showDests:true,castle:true,events:{}},predroppable:{enabled:false,events:{}},draggable:{enabled:true,distance:3,autoDistance:true,showGhost:true,deleteOnDropOff:false},dropmode:{active:false},selectable:{enabled:true},stats:{dragged:!("ontouchstart"in window)},events:{},drawable:{enabled:true,visible:true,defaultSnapToValidMove:true,eraseOnClick:true,shapes:[],autoShapes:[],brushes:{green:{key:"g",color:"#15781B",opacity:1,lineWidth:10},red:{key:"r",color:"#882020",opacity:1,lineWidth:10},blue:{key:"b",color:"#003088",opacity:1,lineWidth:10},yellow:{key:"y",color:"#e68f00",opacity:1,lineWidth:10},paleBlue:{key:"pb",color:"#003088",opacity:.4,lineWidth:15},paleGreen:{key:"pg",color:"#15781B",opacity:.4,lineWidth:15},paleRed:{key:"pr",color:"#882020",opacity:.4,lineWidth:15},paleGrey:{key:"pgr",color:"#4a4a4a",opacity:.35,lineWidth:15},purple:{key:"purple",color:"#68217a",opacity:.65,lineWidth:10},pink:{key:"pink",color:"#ee2080",opacity:.5,lineWidth:10},white:{key:"white",color:"white",opacity:1,lineWidth:10}},prevSvgHash:""},hold:o()}}export{defaults};
//# sourceMappingURL=state.js.map
