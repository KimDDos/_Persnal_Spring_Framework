console.log("MemberRegister 입성~!");
let isEmailResult;

// Email 중복 확인 비동기
async function getIsEmailFromServer(email) {
     try {
          const url = "/member/isEmail/" + email;
          const resp = await fetch(url);
          const result = await resp.text();
          return result;
     } catch (error) {
          console.log(error);
     }
}

document.getElementById('isEmailBtn').addEventListener('click', () => {
     const email = document.getElementById('email').value;
     let isEmailBtn = document.getElementById('isEmailBtn');
     if (isEmailBtn.classList.contains("btn-dark")) {
          isEmailBtn.classList.remove("btn-dark");
     } else if (isEmailBtn.classList.contains("btn-danger")) {
          isEmailBtn.classList.remove("btn-danger");
     } else if (isEmailBtn.classList.contains("btn-success")) {
          isEmailBtn.classList.remove("btn-success");
     }
     getIsEmailFromServer(email).then(result => {
          let emailResult = document.getElementById('emailcheckResultText');
          if (result == '1') {
               isEmailBtn.classList.add("btn-danger");
               let text = `<span class="badge text-bg-danger" id="isEmail" value="1"> 중복된 이메일 입니다. 다시 입력해주세요! </span>`;
               emailResult.innerHTML = text;
          } else {
               isEmailBtn.classList.add("btn-success");
               let text = `<span class="badge text-bg-success" id="isEmail" value="0"> 회원가입이 가능한 이메일입니다! </span>`;
               emailResult.innerHTML = text;
          }
     })
});

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

document.getElementById('submitBtn').addEventListener('click', () => {
     let email = document.getElementById('email');
     let pwdcheck = document.getElementById('pwdcheck');
     let pwd = document.getElementById('pwd');
     let nickName = document.getElementById('nickName');
     let isEmailBtn = document.getElementById('isEmailBtn');
     document.getElementById('isEmailBtn').click();
     if (email.value == null || email.value == "") {
          alert("Email은 반드시 입력해주세요.");
          email.focus();
     } else if (pwdcheck.value == null || pwdcheck.value == "") {
          alert("password는 반드시 입력해주세요.");
          pwdcheck.focus();
     } else if (pwd.value == null || pwd.value == "") {
          alert("password는 반드시 입력해주세요.");
          pwd.focus();
     } else if (nickName.value == null || nickName.value == "") {
          alert("nickName은 반드시 입력해주세요.");
          nickName.focus();
     } else if (isPwd() == 0) {
          alert("password 일치 여부를 확인해주세요.");
          pwd.focus();
     } else if (isEmailBtn.classList.contains("btn-danger") || getIsEmailFromServer(email.value) == '1') {
          alert("이메일 중복 여부를 다시 확인해주세요.");
          email.focus();
     } else {
          document.getElementById('hiddenBtn').click();
     }
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
