console.log("comment JS 입성~!");

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
    const result = resp.json();
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
        cmtText += `<button class="btn btn-sm btn-outline-warning cmtModify" data-cno="${cvo.cno}" style="margin-right: 7px" data-bs-toggle="modal" data-bs-target="#exampleModal">Modify</button>`;
        cmtText += `<button class="btn btn-sm btn-outline-danger cmtDelete" data-cno="${cvo.cno}">Delete</button>`;
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
        cmtText += `<button type="button" class="btn btn-warning cmtDetailModify" data-bs-dismiss="modal" data-cno="${result.cno}">Modify</button>`;
        cmtText += `<button type="button" class="btn btn-danger cmtDelete" data-cno="${result.cno}">Delete</button>`;
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
      spreadCommentList(bnoVal);
    })

  }

})

async function getCommentDetail(cnoVal){
  try {
    const url = "/comment/detail/" + cnoVal;
    const resp = await fetch(url);
    const result = resp.json();
    return result;
  } catch (error) {
    console.log(error);
  }
}

async function deleteCommentToServer(cnoVal){
  try {
    const url = "/comment/detail/" + cnoVal;
    const resp = await fetch(url);
    const result = resp.text();
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