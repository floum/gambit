import{key2pos as e}from"./util.js";import"./types.js";const t={hilitePrimary:{key:"hilitePrimary",color:"#3291ff",opacity:1,lineWidth:1},hiliteWhite:{key:"hiliteWhite",color:"#ffffff",opacity:1,lineWidth:1}};function createDefs(){const e=createElement("defs");const t=setAttributes(createElement("filter"),{id:"cg-filter-blur"});t.appendChild(setAttributes(createElement("feGaussianBlur"),{stdDeviation:"0.019"}));e.appendChild(t);return e}function renderSvg(t,r,i){var n;const o=t.drawable,s=o.current,l=s&&s.mouseSq?s:void 0,a=new Map,h=t.dom.bounds(),c=o.autoShapes.filter((e=>!e.piece));for(const r of o.shapes.concat(c).concat(l?[l]:[])){if(!r.dest)continue;const i=(n=a.get(r.dest))!==null&&n!==void 0?n:new Set,o=pos2user(orient(e(r.orig),t.orientation),h),s=pos2user(orient(e(r.dest),t.orientation),h);i.add(moveAngle(o,s));a.set(r.dest,i)}const u=o.shapes.concat(c).map((e=>({shape:e,current:false,hash:shapeHash(e,isShort(e.dest,a),false,h)})));l&&u.push({shape:l,current:true,hash:shapeHash(l,isShort(l.dest,a),true,h)});const d=u.map((e=>e.hash)).join(";");if(d===t.drawable.prevSvgHash)return;t.drawable.prevSvgHash=d;const f=r.querySelector("defs");syncDefs(o,u,f);syncShapes(u,r.querySelector("g"),i.querySelector("g"),(e=>renderShape(t,e,o.brushes,a,h)))}function syncDefs(e,t,r){var i;const n=new Map;let o;for(const r of t.filter((e=>e.shape.dest&&e.shape.brush))){o=makeCustomBrush(e.brushes[r.shape.brush],r.shape.modifiers);((i=r.shape.modifiers)===null||i===void 0?void 0:i.hilite)&&n.set(hilite(o).key,hilite(o));n.set(o.key,o)}const s=new Set;let l=r.firstElementChild;while(l){s.add(l.getAttribute("cgKey"));l=l.nextElementSibling}for(const[e,t]of n.entries())s.has(e)||r.appendChild(renderMarker(t))}function syncShapes(e,t,r,i){const n=new Map;for(const t of e)n.set(t.hash,false);for(const e of[t,r]){const t=[];let r,i=e.firstElementChild;while(i){r=i.getAttribute("cgHash");n.has(r)?n.set(r,true):t.push(i);i=i.nextElementSibling}for(const r of t)e.removeChild(r)}for(const o of e.filter((e=>!n.get(e.hash))))for(const e of i(o))e.isCustom?r.appendChild(e.el):t.appendChild(e.el)}function shapeHash({orig:e,dest:t,brush:r,piece:i,modifiers:n,customSvg:o,label:s},l,a,h){var c,u;return[h.width,h.height,a,e,t,r,l&&"-",i&&pieceHash(i),n&&modifiersHash(n),o&&`custom-${textHash(o.html)},${(u=(c=o.center)===null||c===void 0?void 0:c[0])!==null&&u!==void 0?u:"o"}`,s&&`label-${textHash(s.text)}`].filter((e=>e)).join(",")}function pieceHash(e){return[e.color,e.role,e.scale].filter((e=>e)).join(",")}function modifiersHash(e){return[e.lineWidth,e.hilite&&"*"].filter((e=>e)).join(",")}function textHash(e){let t=0;for(let r=0;r<e.length;r++)t=(t<<5)-t+e.charCodeAt(r)>>>0;return t.toString()}function renderShape(t,{shape:r,current:i,hash:n},o,s,l){var a,h;const c=pos2user(orient(e(r.orig),t.orientation),l),u=r.dest?pos2user(orient(e(r.dest),t.orientation),l):c,d=r.brush&&makeCustomBrush(o[r.brush],r.modifiers),f=s.get(r.dest),p=[];if(d){const e=setAttributes(createElement("g"),{cgHash:n});p.push({el:e});c[0]!==u[0]||c[1]!==u[1]?e.appendChild(renderArrow(r,d,c,u,i,isShort(r.dest,s))):e.appendChild(renderCircle(o[r.brush],c,i,l))}if(r.label){const e=r.label;(a=e.fill)!==null&&a!==void 0?a:e.fill=r.brush&&o[r.brush].color;const t=r.brush?void 0:"tr";p.push({el:renderLabel(e,n,c,u,f,t),isCustom:true})}if(r.customSvg){const e=(h=r.customSvg.center)!==null&&h!==void 0?h:"orig";const[t,i]=e==="label"?labelCoords(c,u,f).map((e=>e-.5)):e==="dest"?u:c;const o=setAttributes(createElement("g"),{transform:`translate(${t},${i})`,cgHash:n});o.innerHTML=`<svg width="1" height="1" viewBox="0 0 100 100">${r.customSvg.html}</svg>`;p.push({el:o,isCustom:true})}return p}function renderCircle(e,t,r,i){const n=circleWidth(),o=(i.width+i.height)/(4*Math.max(i.width,i.height));return setAttributes(createElement("circle"),{stroke:e.color,"stroke-width":n[r?0:1],fill:"none",opacity:opacity(e,r),cx:t[0],cy:t[1],r:o-n[1]/2})}function hilite(e){return["#ffffff","#fff","white"].includes(e.color)?t.hilitePrimary:t.hiliteWhite}function renderArrow(e,t,r,i,n,o){var s;function renderLine(s){var l;const a=arrowMargin(o&&!n),h=i[0]-r[0],c=i[1]-r[1],u=Math.atan2(c,h),d=Math.cos(u)*a,f=Math.sin(u)*a;return setAttributes(createElement("line"),{stroke:s?hilite(t).color:t.color,"stroke-width":lineWidth(t,n)+(s?.04:0),"stroke-linecap":"round","marker-end":`url(#arrowhead-${s?hilite(t).key:t.key})`,opacity:((l=e.modifiers)===null||l===void 0?void 0:l.hilite)?1:opacity(t,n),x1:r[0],y1:r[1],x2:i[0]-d,y2:i[1]-f})}if(!((s=e.modifiers)===null||s===void 0?void 0:s.hilite))return renderLine(false);const l=createElement("g");const a=setAttributes(createElement("g"),{filter:"url(#cg-filter-blur)"});a.appendChild(filterBox(r,i));a.appendChild(renderLine(true));l.appendChild(a);l.appendChild(renderLine(false));return l}function renderMarker(e){const t=setAttributes(createElement("marker"),{id:"arrowhead-"+e.key,orient:"auto",overflow:"visible",markerWidth:4,markerHeight:4,refX:e.key.startsWith("hilite")?1.86:2.05,refY:2});t.appendChild(setAttributes(createElement("path"),{d:"M0,0 V4 L3,2 Z",fill:e.color}));t.setAttribute("cgKey",e.key);return t}function renderLabel(e,t,r,i,n,o){var s;const l=.4,a=l*.75**e.text.length,h=labelCoords(r,i,n),c=o==="tr"?.4:0,u=setAttributes(createElement("g"),{transform:`translate(${h[0]+c},${h[1]-c})`,cgHash:t});u.appendChild(setAttributes(createElement("circle"),{r:l/2,"fill-opacity":o?1:.8,"stroke-opacity":o?1:.7,"stroke-width":.03,fill:(s=e.fill)!==null&&s!==void 0?s:"#666",stroke:"white"}));const d=setAttributes(createElement("text"),{"font-size":a,"font-family":"Noto Sans","text-anchor":"middle",fill:"white",y:.13*.75**e.text.length});d.innerHTML=e.text;u.appendChild(d);return u}function orient(e,t){return t==="white"?e:[7-e[0],7-e[1]]}function isShort(e,t){return true===(e&&t.has(e)&&t.get(e).size>1)}function createElement(e){return document.createElementNS("http://www.w3.org/2000/svg",e)}function setAttributes(e,t){for(const r in t)Object.prototype.hasOwnProperty.call(t,r)&&e.setAttribute(r,t[r]);return e}function makeCustomBrush(e,t){return t?{color:e.color,opacity:Math.round(e.opacity*10)/10,lineWidth:Math.round(t.lineWidth||e.lineWidth),key:[e.key,t.lineWidth].filter((e=>e)).join("")}:e}function circleWidth(){return[3/64,4/64]}function lineWidth(e,t){return(e.lineWidth||10)*(t?.85:1)/64}function opacity(e,t){return(e.opacity||1)*(t?.9:1)}function arrowMargin(e){return(e?20:10)/64}function pos2user(e,t){const r=Math.min(1,t.width/t.height);const i=Math.min(1,t.height/t.width);return[(e[0]-3.5)*r,(3.5-e[1])*i]}function filterBox(e,t){const r={from:[Math.floor(Math.min(e[0],t[0])),Math.floor(Math.min(e[1],t[1]))],to:[Math.ceil(Math.max(e[0],t[0])),Math.ceil(Math.max(e[1],t[1]))]};return setAttributes(createElement("rect"),{x:r.from[0],y:r.from[1],width:r.to[0]-r.from[0],height:r.to[1]-r.from[1],fill:"none",stroke:"none"})}function moveAngle(e,t,r=true){const i=Math.atan2(t[1]-e[1],t[0]-e[0])+Math.PI;return r?(Math.round(i*8/Math.PI)+16)%16:i}function dist(e,t){return Math.sqrt([e[0]-t[0],e[1]-t[1]].reduce(((e,t)=>e+t*t),0))}function labelCoords(e,t,r){let i=dist(e,t);const n=moveAngle(e,t,false);if(r){i-=33/64;if(r.size>1){i-=10/64;const n=moveAngle(e,t);(r.has((n+1)%16)||r.has((n+15)%16))&&n&1&&(i-=.4)}}return[e[0]-Math.cos(n)*i,e[1]-Math.sin(n)*i].map((e=>e+.5))}export{createDefs,createElement,renderSvg,setAttributes};
//# sourceMappingURL=svg.js.map
