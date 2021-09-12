document.addEventListener('DOMContentLoaded', () => {
  if (document.URL.match( '/users' ) || document.URL.match( '/groups')) {

      console.log(Registersubmit);
      
      // 「送信」ボタンの要素にクリックイベントを設定する
      Registersubmit.addEventListener('click', (e) => {
          // デフォルトアクションをキャンセル
          e.preventDefault();
  
          // 「お名前」入力欄の空欄チェック
          // フォームの要素を取得
          const name = document.querySelector('#name');
          // エラーメッセージを表示させる要素を取得
          const errMsgName = document.querySelector('.err-msg-name');
          if(!name.value){
              // クラスを追加(エラーメッセージを表示する)
              errMsgName.classList.add('form-invalid');
              // エラーメッセージのテキスト
              errMsgName.textContent = 'お名前が入力されていません';
              // クラスを追加(フォームの枠線を赤くする)
              name.classList.add('input-invalid');
              // 後続の処理を止める
              return;
          }else{
              // エラーメッセージのテキストに空文字を代入
              errMsgName.textContent ='';
              // クラスを削除
              name.classList.remove('input-invalid');
          }
  
          // 「パスワード」入力欄の形式チェック
          const pass = document.querySelector('#password');
          const errMsgPass = document.querySelector('.err-msg-pass');
          // パスワードが5文字以上の半角英数字であるかどうかのチェック
          if(!pass.value.match(/^([a-zA-Z0-9]{5,})$/)){
              errMsgPass.classList.add('form-invalid');
              errMsgPass.textContent = '半角英数字5文字以上で入力してください';
              pass.classList.add('input-invalid');
              return;
          }else{
              errMsgPass.textContent ='';
              pass.classList.remove('input-invalid');
          }
  
          // 「パスワード」と「パスワード再入力」が一致しているかどうかのチェック
          const passRe = document.querySelector('#pass-re');
          const errMsgPassRe = document.querySelector('.err-msg-passre');
          if(pass.value !== passRe.value){
              errMsgPassRe.classList.add('form-invalid');
              errMsgPassRe.textContent = 'パスワードとパスワード再入力が一致していません';
              passRe.classList.add('input-invalid');
              return;
          }else{
              errMsgPassRe.textContent ='';
              passRe.classList.remove('input-invalid');
          }
      }, false);
  }
});