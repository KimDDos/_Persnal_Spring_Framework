console.log("MemberRegister 입성~!");

// Email 중복 확인 비동기
async function getIsEmailFromServer(email) {
     try {
          const url = "/member/isEmail/" + email;
          const resp = await fetch(url, config);
          const result = await resp.text();
          return result;
     } catch (error) {
          console.log(error);
     }
}

document.getElementById('isEmailBtn').addEventListener('click', () => {
     const email = document.getElementById('email').value;
     console.log(email);
     getIsEmailFromServer(email).then(result => {
          console.log(result);
          let emailResult = document.getElementById('emailChekResult');
          console.log(emailResult);
          if (result == '1') {
               let text = '<button type="button" class="btn btn-danger EmailBtn disable" id="isEmailBtn">이메일 중복 확인</button>';
               text += ` <span class="badge text-bg-danger" id="isEmail" value="true"> 중복된 이메일 입니다. 다시 입력해주세요! </span>`;
               emailResult.innerHTML = text;
          } else {
               let text = '<button type="button" class="btn btn-success EmailBtn disable" id="isEmailBtn">이메일 중복 확인</button>';
               text += ` <span class="badge text-bg-success" id="isEmail" value="false"> 회원가입이 가능한 이메일입니다! </span>`;
               emailResult.innerHTML = text;
          }
     })
});