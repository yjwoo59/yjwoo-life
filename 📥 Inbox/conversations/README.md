# 📥 Inbox — 대화 처리 규칙

## 사용 방법

1. 다른 Claude 대화 내용을 복사하여 이 폴더에 저장
2. 나(Claude Desktop)에게 **"inbox 처리해줘"** 라고 말하면 자동 등록

---

## 파일 형식

파일명은 자유롭게 해도 됩니다. 내가 내용을 읽고 판단합니다.

권장 형식:
```
2026-04-24-주제.md
2026-04-24-주제.txt
```

---

## 처리 결과

내가 아래 정보를 자동 추출합니다:
- 날짜
- 주제 (topic)
- 카테고리 (개발 / 인생 / 아카이브 / 기타)
- 핵심 결론
- 액션 아이템

저장 위치:
```
shared/conversations/YYYY/MM/YYYY-MM-DD-주제.md
```

---

## 처리 후

- Inbox 파일은 삭제 또는 processed/ 로 이동
- GitHub 자동 push (start-sync.bat 실행 중일 때)
