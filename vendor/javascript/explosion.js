function explosion(e,o){e.exploding={stage:1,keys:o};e.dom.redraw();setTimeout((()=>{setStage(e,2);setTimeout((()=>setStage(e,void 0)),120)}),120)}function setStage(e,o){if(e.exploding){o?e.exploding.stage=o:e.exploding=void 0;e.dom.redraw()}}export{explosion};
//# sourceMappingURL=explosion.js.map
