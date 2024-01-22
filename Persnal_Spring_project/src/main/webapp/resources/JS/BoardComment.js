console.log("comment JS 입성~!");
console.log(authEmail);

document.getElementById('cmtRegBtn').addEventListener('click',()=>{
  let email = document.getElementById('floatingEmail').value;
  let writerNick = document.getElementById('floatingNickname').value;
  let content = document.getElementById('floatingTextarea2');
  if(content.value == null || content.value == ''){
    alert("댓글을 입력해주세요.");
    content.focus();
    return false;
  } else {
    let cmtData = {
      bno: bnoVal,
      writer: email,
      writerNickname: writerNick,
      content: content.value
    }
    console.log(cmtData);
    
    commentRegistToServer(cmtData).then(result => {
      console.log(result);
      if(result == '1'){
        alert("댓글 등록 성공~!!");
        content.value = "";
      }
      // 화면에 뿌리기
      spreadCommentList(bnoVal);
    })
  }
});

async function commentRegistToServer(cmtData){
  try {
    const url = "/comment/register";
    const config = {
      method: 'post',
      headers: {
        'content-type':'application/json; charset=UTF-8'
      },
      body: JSON.stringify(cmtData)
    }
    const resp = await fetch(url, config);
    const result = await resp.text();
    return result;
  } catch (error) {
    console.log(error);
  }
}

async function getCommentListFromServer(bnoVal){
  try {
    const url = "/comment/list/" + bnoVal;
    const resp = await fetch(url);
    const result = await resp.json();
    return result;
  } catch (error) {
    console.log(error);
  }
}

function spreadCommentList(bnoVal){
  getCommentListFromServer(bnoVal).then(result => {
    console.log(result);
    const spreadDiv = document.getElementById('commentSpreadZone');
    spreadDiv.innerHTML = "";
    if(result.length > 0){
      for(const cvo of result){
        let writer = `${cvo.writer}`;
        let cmtText = `<div class="accordion accordion-flush" id="accordionFlushExample">`;
        cmtText += `<div class="accordion-item">`;
        cmtText += `<h2 class="accordion-header">`;
        if(cvo.regDate != cvo.modDate){
          cmtText += `<button class="accordion-button collapsed" type="button"
                      data-bs-toggle="collapse" data-bs-target="#flush-collapse${cvo.cno}"
                      aria-expanded="false" aria-controls="flush-collapse${cvo.cno}">
                      #${cvo.cno}. 작성자[닉네임] : ${cvo.writer}[${cvo.writerNickname}] / 작성일 : ${cvo.modDate}
                      </button></h2>`;
        } else {
          cmtText += `<button class="accordion-button collapsed" type="button"
                      data-bs-toggle="collapse" data-bs-target="#flush-collapse${cvo.cno}"
                      aria-expanded="false" aria-controls="flush-collapse${cvo.cno}">
                      #${cvo.cno}. 작성자[닉네임] : ${cvo.writer}[${cvo.writerNickname}] / 작성일 : ${cvo.regDate}
                      </button></h2>`;
        }
        cmtText += `<div id="flush-collapse${cvo.cno}" class="accordion-collapse collapse" data-bs-parent="#accordionFlushExample">`;
        cmtText += `<div class="accordion-body">`;
        cmtText += `<textarea class="form-control" name="content" id="floatingTextarea2"
        style="height: 100px; margin-bottom: 15px;" disabled>${cvo.content}</textarea>`;
        if(authEmail == writer){
        cmtText += `<button class="btn btn-sm btn-outline-warning cmtModify" data-cno="${cvo.cno}" style="margin-right: 7px" data-bs-toggle="modal" data-bs-target="#exampleModal">Modify</button>`;
        cmtText += `<button class="btn btn-sm btn-outline-danger cmtDelete" data-cno="${cvo.cno}">Delete</button>`;
        }
        cmtText += `</div></div></div></div>`;
        spreadDiv.innerHTML += cmtText;
      }
    } else {
      spreadDiv.innerHTML = `<div> 등록된 댓글이 없습니다. </div>`;
    }

  })
}

document.addEventListener('click', (e)=>{
  console.log(e.target);
  console.log(e.target.classList);
  if(e.target.classList.contains('cmtModify')){
    let modal = document.querySelector(".modal");
    getCommentDetail(e.target.dataset.cno).then(result => {
      let cmtText = "";
      let writer = `${result.writer}`;
      if(result != null){
        cmtText += `<div class="modal-dialog">`;
        cmtText += `<div class="modal-content">`;
        cmtText += `<div class="modal-header">`;
        cmtText += `<h1 class="modal-title fs-5" id="exampleModalLabel" style="color: black;">${result.writer} [${result.nickName}] / ${result.modDate}</h1>`;
        cmtText += `<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>`;
        cmtText += `</div><div class="modal-body" style="color: black;">`;
        cmtText += `<input type="text" class="form-control" name="content" id="modalContent" value="${result.content}">`;
        cmtText += `</div>`;
        cmtText += `<div class="modal-footer">`;
        if(authEmail == writer){
          cmtText += `<button type="button" class="btn btn-warning cmtDetailModify" data-bs-dismiss="modal" data-cno="${result.cno}">Modify</button>`;
          cmtText += `<button type="button" class="btn btn-danger cmtDelete" data-cno="${result.cno}">Delete</button>`;
        }
        cmtText += `</div></div></div></div>`;
      } else {
        cmtText += `<div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body" style="color: black;">
            댓글 불러오기 실패
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary">Save changes</button>
          </div>
        </div>
      </div>`;
      }
      modal.innerHTML = cmtText;
    })

  } else if(e.target.classList.contains('cmtDetailModify')){
    let modalContent = document.getElementById('modalContent').value;
    let cno = e.target.dataset.cno;
    const cmtDate = {
      cno: cno,
      content: modalContent
    };

    modifyCommentToServer(cmtDate).then(result => {
      console.log(result);
      if(result == '1'){
        alert("댓글 수정 성공~!");
      } 
      spreadCommentList(bnoVal);
    })

  } else if(e.target.classList.contains('cmtDelete')){
    let cnoVal = e.target.dataset.cno;
    deleteCommentToServer(cnoVal).then(result => {
      console.log(result);
      if(result == '1'){
        alert("댓글 삭제 성공~!");
      }
      document.querySelector('.btn-close').click();
      spreadCommentList(bnoVal);
    })

  } else if(e.target.classList.contains('btn-outline-danger') || e.target.classList.contains('btn-outline-dark')){
    let path = "";
    if(e.target.classList.contains('btn-outline-danger')){
      path = "commendUp";
    } else {
      path = "commendDown";
    }
    updateCommentrecommendToServer(bnoVal,path).then(result => {
      console.log(result);
      if(path == "commendUp"){
        document.getElementById('commend-up').innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
			  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
			  </svg> 추천 ${result}`;
      } else {
        document.getElementById('commend-down').innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heartbreak-fill" viewBox="0 0 16 16">
			  <path d="M8.931.586 7 3l1.5 4-2 3L8 15C22.534 5.396 13.757-2.21 8.931.586ZM7.358.77 5.5 3 7 7l-1.5 3 1.815 4.537C-6.533 4.96 2.685-2.467 7.358.77Z"/>
			  </svg> 비추천 ${result}`;
      }

    })
  }

})

async function getCommentDetail(cnoVal){
  try {
    const url = "/comment/detail/" + cnoVal;
    const resp = await fetch(url);
    const result = await resp.json();
    return result;
  } catch (error) {
    console.log(error);
  }
}

async function deleteCommentToServer(cnoVal){
  try {
    const url = "/comment/delete/" + cnoVal;
    const resp = await fetch(url);
    const result = await resp.text();
    return result;
  } catch (error) {
    console.log(error);
  }
}

async function modifyCommentToServer(cmtData){
  try {
    const url = "/comment/modify";
    const config = {
      method: 'post',
      headers: {
        'content-type':'application/json; charset=UTF-8'
      },
      body: JSON.stringify(cmtData)
    }
    const resp = await fetch(url, config);
    const result = await resp.text();
    return result;
  } catch (error) {
    console.log(error);
  }
}

async function updateCommentrecommendToServer(bnoVal, path){
  try {
    const url = "/board/"+path+"/"+bnoVal;
    const resp = await fetch(url);
    const result = await resp.text();
    return result;
  } catch (error) {
    console.log(error);
  }
}