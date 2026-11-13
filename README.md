# 원광 캠퍼스 마당 (GitHub Pages용)

로그인 없이 들어온 사람끼리 서로 보이는 3D 캠퍼스입니다.
화면은 GitHub Pages가 보여 주고, 함께 보이기와 광장 게시판은 Supabase가 맡습니다.

## 들어 있는 파일

| 파일 | 하는 일 |
|---|---|
| `index.html` | 게임 전체. `D:\AI\garden\campus\index.html`에서 `node tools/build-web.mjs`로 만든다. 직접 고치지 않는다 |
| `config.js` | Supabase 주소와 공개 키를 적는 곳 |
| `supabase.sql` | 게시판 표를 만드는 명령. Supabase에서 한 번 실행한다 |
| `.nojekyll` | GitHub Pages가 파일을 그대로 내보내게 하는 빈 파일 |

## 1. Supabase 준비 (한 번만)

1. https://supabase.com 에 가입하고 **New project**를 만든다. 지역은 Northeast Asia (Seoul)을 고른다.
2. 왼쪽 **SQL Editor**를 열고 `supabase.sql` 내용을 통째로 붙여 넣은 뒤 **Run**을 누른다.
3. 왼쪽 **Authentication → Sign In / Providers**에서 **Allow anonymous sign-ins**를 켠다.
   - 이것을 켜야 로그인 없이도 "자기 글만 고치고 떼기"가 된다. 끄면 게시판은 읽기만 된다.
4. **Project Settings → API**(또는 **Data API**)에서 두 값을 복사한다.
   - Project URL (예: `https://abcdefgh.supabase.co`)
   - `anon` `public` 키 (긴 글자). `service_role` 키는 쓰지 않는다.
5. `config.js`의 `url`과 `key`에 붙여 넣는다.

## 2. GitHub Pages로 올리기

1. GitHub에서 새 저장소를 **Public**으로 만든다(README 추가 체크는 하지 않는다).
2. 이 폴더의 파일을 저장소에 올린다.
3. 저장소 **Settings → Pages**에서 Source를 **Deploy from a branch**, Branch를 **main / (root)** 로 고르고 Save를 누른다.
4. 1~2분 뒤 `https://<계정>.github.io/<저장소 이름>/` 으로 열린다.

## 운영할 때

- **게시판 글 지우기:** Supabase **Table Editor → notes**에서 줄을 골라 삭제한다. 열려 있는 화면에서도 바로 사라진다.
- **동시 접속:** Supabase 무료 요금제는 동시 200명까지다. 넘으면 새로 들어온 사람은 혼자 둘러보는 화면이 된다.
- **오래 쉬면 멈춤:** 무료 프로젝트는 1주일 동안 아무도 쓰지 않으면 멈춘다. Supabase 화면에서 **Restore**를 누르면 다시 켜진다.
- **게임을 고친 뒤:** `node tools/build-web.mjs`로 `index.html`을 다시 만들고 저장소에 올린다. `config.js`는 그대로 둔다.
- 글 걸러 내기는 전화번호·메일·링크와 몇 가지 욕설만 막는다. 나머지는 위 방법으로 직접 지운다.
