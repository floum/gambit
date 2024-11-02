function syncShapes(e,t,s){const n=new Map,h=[];for(const t of e)n.set(t.hash,false);let o,a=t.firstElementChild;while(a){o=a.getAttribute("cgHash");n.has(o)?n.set(o,true):h.push(a);a=a.nextElementSibling}for(const e of h)t.removeChild(e);for(const h of e)n.get(h.hash)||t.appendChild(s(h))}export{syncShapes};
//# sourceMappingURL=sync.js.map
