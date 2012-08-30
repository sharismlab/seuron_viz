var cnvs = document.createElement("canvas");
cnvs.setAttribute("style", "display:none;");
cnvs.setAttribute("id", "check");
cnvs.setAttribute("data-processing-sources", "../../CheckSources/check.pde");
if(document.body!=null) document.body.appendChild(cnvs);