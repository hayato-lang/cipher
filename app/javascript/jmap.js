$(function(){
  const d = new jpmap.japanMap(document.getElementById("japan-map"), {
    areas: [
    ],
    lineWidth: 0,
    color: "#0178cb", 
    width: 800,
    left: 50,
    onSelect: function(data){
      alert(data.name);
    }
  });
});