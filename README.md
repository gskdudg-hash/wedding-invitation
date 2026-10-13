# 상필 ♥ 나영 모바일 청첩장

싸이월드 미니홈피의 파랑·하양·분홍 감성을 참고한 모바일 우선 React + Vite 청첩장입니다. Framer Motion으로 스크롤 등장·편지·사진 모달을 구성했습니다.

## 실행
1. Node.js 20.19+ 또는 22.12+ 설치
2. 프로젝트 폴더에서 `npm install`
3. `.env.example`을 `.env.local`로 복사하고 Supabase URL 및 publishable/anon key 입력
4. `supabase.sql`을 Supabase SQL Editor에서 실행
5. Supabase Authentication에서 관리자 계정을 만들고 해당 UUID를 `public.invitation_admins`에 추가
6. `npm run dev` 실행

Supabase가 설정되지 않으면 RSVP 저장을 성공한 것처럼 표시하지 않습니다. service-role 키는 브라우저 코드에 넣지 마세요.

## 내용 수정
`src/data.js`에서 날짜·시간·장소·이름·편지·사진 경로·개인정보 안내·지도 검색어를 수정합니다. `public/images/polaroid-1.svg`부터 `polaroid-5.svg`까지는 현재 싸이월드풍 일러스트 임시 이미지입니다. 실제 사진으로 교체해 주세요. `map-placeholder.svg`도 장식용 일러스트이며 실제 약도가 아닙니다. 실제 약도 파일을 넣고 `src/data.js`의 `mapImage` 경로를 변경하세요.

## 지도
예식장 명칭과 주소는 검색 결과의 MH컨벤션, 대구 동구 동대구로 418과 일치합니다. 네이버·카카오 버튼은 해당 명칭과 주소의 검색 결과를 엽니다. TMAP은 앱 URI 검색을 사용하므로 기기에 TMAP이 설치되어 있어야 하며, 이 환경에서 실제 앱 열림 여부는 검증할 수 없습니다.

## 배포 전 확인
- 실제 커플 사진 5장과 예식장 공식 약도로 교체
- Supabase SQL/RLS 적용, 관리자 UUID 등록, 로그인·응답 저장·삭제 테스트
- 개인정보 보관 기간과 안내 문구 확인
- iOS Safari와 Android Chrome 실기기 테스트
- 배포 후 HTTPS 공개 URL과 Open Graph 미리보기 확인

이 환경에서는 패키지 설치/브라우저 실행을 아직 검증하지 못했으므로, 이 README만으로 실제 배포가 완료된 것은 아닙니다.
