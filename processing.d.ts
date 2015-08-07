
declare var Processing :
{
    new (canvas: any, callback: (p:IProcessing) => any ) : void;
}

interface IProcessing
{
    CENTER : number;
    CLOSE  : number;

    setup : Function;
    loadXML(xml: string) : IXML;
    PShapeSVG : IShapeSVG;
    size(width: number, height: number);
    background(red: number, green: number, blue: number);
    translate(x: number, y:number);
    scale(x: number, y:number);
    rectMode(mode: number);
    pushStyle();
    popStyle();
    noStroke();
    fill(red: number, green: number, blue: number, alpha: number);
    rect(left: number, top: number, width: number, height: number);
    beginShape();
    endShape(mode: number);
    vertex(x: number, y:number);
}

interface IXML
{
}

interface IShapeSVG
{
    new (xml: IXML);
}

