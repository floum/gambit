import{key2pos as e,distanceSq as n,allKeys as o,samePiece as t}from"./util.js";import"./types.js";const anim=(e,n)=>n.animation.enabled?animate(e,n):render(e,n);function render(e,n){const o=e(n);n.dom.redraw();return o}const makePiece=(n,o)=>({key:n,pos:e(n),piece:o});const closer=(e,o)=>o.sort(((o,t)=>n(e.pos,o.pos)-n(e.pos,t.pos)))[0];function computePlan(e,n){const s=new Map,r=[],i=new Map,a=[],c=[],p=new Map;let f,m,u;for(const[n,o]of e)p.set(n,makePiece(n,o));for(const e of o){f=n.pieces.get(e);m=p.get(e);if(f)if(m){if(!t(f,m.piece)){a.push(m);c.push(makePiece(e,f))}}else c.push(makePiece(e,f));else m&&a.push(m)}for(const e of c){m=closer(e,a.filter((n=>t(e.piece,n.piece))));if(m){u=[m.pos[0]-e.pos[0],m.pos[1]-e.pos[1]];s.set(e.key,u.concat(u));r.push(m.key)}}for(const e of a)r.includes(e.key)||i.set(e.key,e.piece);return{anims:s,fadings:i}}function step(e,n){const o=e.animation.current;if(o===void 0){e.dom.destroyed||e.dom.redrawNow();return}const t=1-(n-o.start)*o.frequency;if(t<=0){e.animation.current=void 0;e.dom.redrawNow()}else{const n=easing(t);for(const e of o.plan.anims.values()){e[2]=e[0]*n;e[3]=e[1]*n}e.dom.redrawNow(true);requestAnimationFrame(((n=performance.now())=>step(e,n)))}}function animate(e,n){const o=new Map(n.pieces);const t=e(n);const s=computePlan(o,n);if(s.anims.size||s.fadings.size){const e=n.animation.current&&n.animation.current.start;n.animation.current={start:performance.now(),frequency:1/n.animation.duration,plan:s};e||step(n,performance.now())}else n.dom.redraw();return t}const easing=e=>e<.5?4*e*e*e:(e-1)*(2*e-2)*(2*e-2)+1;export{anim,render};
//# sourceMappingURL=anim.js.map