$(function(){
  const d = new jpmap.japanMap(document.getElementById("japan-map"), {
    areas: [
    ],
    lineWidth: 0,
    color: "#0178cb", 
    onSelect: function(data){
      alert(data.name);
    }
  });
});