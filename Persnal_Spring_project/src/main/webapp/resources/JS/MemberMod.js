document.getElementById('pwd').addEventListener('keyup', () => {
     let pwdChekResult = document.getElementById('pwdChekResult');
     let span = `비밀번호 일치여부 확인`;
     if (isPwd() == 1) {
          span = `<span class="badge text-bg-success" id="pwdCheckResult" style="font-weight: 800;"> 비밀번호가 일치합니다. </span>`;
     } else {
          span = `<span class="badge text-bg-danger" id="pwdCheckResult" style="font-weight: 600;"> 비밀번호가 불일치합니다. </span>`;
     }
     pwdChekResult.innerHTML = span;
})

function isPwd() {
     let pwdcheck = document.getElementById('pwdcheck').value;
     let pwd = document.getElementById('pwd').value;
     if (pwdcheck == pwd) {
          return 1;
     } else {
          return 0;
     }
}

document.getElementById('submitModBtn').addEventListener('click', () => {
     if (isPwd() == 0) {
          alert("password 일치 여부를 확인해주세요.");
          pwd.focus();
     } else {
          document.getElementById('modBtn').click();
     }
})