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

- **게시판 규칙:** 한 사람이 포스트잇을 여러 장 붙일 수 있다. 한 장 붙인 뒤 30초가 지나야 다음 장을 붙일 수 있다(화면에서만 막는다). 자기 글은 ✕로 뗀다. 게시판 그림에는 최신 10장, 목록에는 최신 60장이 보인다.
- **게시판 글 지우기:** Supabase **Table Editor → notes**에서 줄을 골라 삭제한다. 열려 있는 화면에서도 바로 사라진다. `owner` 칸이 같은 줄은 같은 사람이 붙인 글이다.
- **예전 "한 사람 한 장" 표에서 옮길 때:** `supabase.sql` 아래쪽 "옮기기" 부분의 `--`를 지우고 그 부분만 한 번 실행한다. 이미 붙은 글은 그대로 남는다.
- **동시 접속:** Supabase 무료 요금제는 동시 200명까지다. 넘으면 새로 들어온 사람은 혼자 둘러보는 화면이 된다.
- **오래 쉬면 멈춤:** 무료 프로젝트는 1주일 동안 아무도 쓰지 않으면 멈춘다. Supabase 화면에서 **Restore**를 누르면 다시 켜진다.
- **게임을 고친 뒤:** `node tools/build-web.mjs`로 `index.html`을 다시 만들고 저장소에 올린다. `config.js`는 그대로 둔다.
- 글 걸러 내기는 전화번호·메일·링크와 몇 가지 욕설만 막는다. 나머지는 위 방법으로 직접 지운다.

---

# 사이버대 발전계획 비교 (`plan/`)

사이버대학교 중장기발전계획을 모아 비교 분석하는 도구입니다. GitHub Pages에서 `https://<계정>.github.io/<저장소>/plan/` 으로 열립니다.

| 파일 | 하는 일 |
|---|---|
| `plan/app.html` | 화면 본문. 고칠 때는 이 파일을 고친다 |
| `plan/build.sh` | `app.html`을 완전한 문서 `plan/index.html`로 감싼다. 고친 뒤 `sh plan/build.sh` 실행 |
| `plan/index.html` | GitHub Pages가 보여 주는 파일 (직접 고치지 않는다) |

- **수합:** 엑셀 양식(기본정보·발전목표·과제·성과지표 시트)을 내려받아 대학별로 작성 → 여러 파일을 한꺼번에 올림. PDF·DOCX·TXT 원문이나 붙여 넣은 글에서 비전·목표·과제·지표 후보를 뽑아 확인 후 저장.
- **분석:** 종합 시사점(자동 작성), 비교표, 8개 영역별 과제 비중(히트맵)과 본교 대비 차이, 성과지표 현재→목표 비교, 키워드(공통·고유).
- **내보내기:** 분석 결과 엑셀(비교표·영역분포·성과지표·과제목록·시사점), 표 복사, JSON 백업/불러오기.
- 자료는 이 브라우저(localStorage)에만 저장되고 서버로 보내지 않는다. 다른 PC로 옮길 때는 JSON 백업을 쓴다.
- 처음 열면 가상 대학 5곳의 **예시 자료**가 들어 있다. 수합·내보내기 화면에서 지운다.
