if (location.pathname.match("tweets/new")){
  document.addEventListener("DOMContentLoaded", () => {
    const pref = document.getElementById("tweet_prefecture_id");
    pref.addEventListener("change", (e) => {
      const formData = new FormData(document.getElementById("form"));   
      const XHR = new XMLHttpRequest();
      XHR.open("POST", "/tweets", true);
      XHR.responseType = "json";
      console.log(formData);
      XHR.send(formData);
      XHR.onload = () => {
        if (XHR.status != 200) {
          alert(`Error ${XHR.status}: ${XHR.statusText}`);
          return null;
        }
        const item = XHR.response.post;
        const city_select = document.getElementById("city_select");
        
        const HTML = `
            <select name="city">
              
              <option value="選択肢">選択肢2</option>
            </select>
          `;
        city_select.insertAdjacentHTML("afterend", HTML);
      }


    });
    
  });
};