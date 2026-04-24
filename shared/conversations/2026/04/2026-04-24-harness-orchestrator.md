---
date: 2026-04-24
ai_model: Claude Opus 4.7
topic: 하네스 오케스트레이터 설계
category: 개발-방법론
tags: [하네스, 오케스트레이터, CLAUDE.md, Mermaid, Obsidian, Claude Code]
importance: high
---

# 하네스 오케스트레이터 설계 — 대화 로그

## 📌 대화 요약

1. **주제 시작**: "FDAI 하네스 260424" (FDAI 프로젝트는 이름만 있고 내용 미정)
2. **하네스 개념 확인**: 큰 폴더 안에 전체를 담되, 실행 시 필요 파일만 읽힘. 오케스트레이터 + 계층적 서브에이전트 구조.
3. **오케스트레이터 툴 논의**: Claude Code 수동(CLAUDE.md) → MCP → Semantic Kernel (C#) 단계적 접근 제안
4. **시각화 요구**: 사용자는 md 읽기보다 차트로 보길 원함 → **Mermaid 블록** 도입 결정
5. **파일 구조 결정**: 단일 CLAUDE.md → **분리 파일 구조**로 전환 (최상위 + docs/ 5개)
6. **결과물 생성**: CLAUDE.md + docs/01~05 총 6개 파일

---

## 🎯 주요 결론

### 1. 하네스 5개 레버 (재확인)
- Rules, Tools, Skills, Memory, Feedback Loop

### 2. 오케스트레이터 설계 원칙
- **"판단하지 않는다. 규칙대로 라우팅한다."**
- 명시적 분기 조건 필수
- 불명확 시 반드시 질문

### 3. 3계층 구조
```
최상위 CLAUDE.md (오케스트레이터)
├── Dev Agent (C# 개발)
├── Life PM Agent (프로젝트·인생)
└── Archive Agent (70TB 자료)
```

### 4. 툴 스택 (단계별)
| 단계 | 툴 | 시점 |
|---|---|---|
| 1 | CLAUDE.md 파일 계층 | 지금 |
| 2 | MCP 서버 | 1개월 후 |
| 3 | Semantic Kernel (C#) | 필요 시 |

### 5. 시각화 전략
- **Mermaid**를 md 안에 삽입 → Obsidian에서 자동 렌더링
- 사용 다이어그램: `graph`, `flowchart`, `sequenceDiagram`, `gantt`, `mindmap`
- Claude는 텍스트로 쓰고, 사용자는 차트로 본다

### 6. 파일 분리 구조
- 최상위 CLAUDE.md는 **목차 + 핵심만** (짧게)
- 각 섹션은 `docs/` 하위 별도 파일
- 이유: 컨텍스트 절약 + 직관적 네비게이션 + Obsidian 그래프뷰

---

## 📂 생성된 결과물

```
C:\Claude\YJWOO Life\   ← Obsidian Vault = 하네스 루트
├── CLAUDE.md                    ← 최상위 진입점 (짧은 목차)
└── docs/
    ├── 01-structure.md          ← 🗺️ 전체 구조
    ├── 02-routing.md            ← 🔀 작업 분기 규칙
    ├── 03-rules.md              ← 🔒 절대 규칙
    ├── 04-feedback-loop.md      ← 🔁 검증 절차
    └── 05-roadmap.md            ← 🚀 로드맵
```

---

## ✅ 액션 아이템

- [ ] **FDAI 정체 확정** — 무엇의 약자인지, 어떤 프로젝트인지 설명 필요
- [ ] `shared/ABOUT-ME.md` 작성 (다음 단계)
- [ ] `agents/dev/CLAUDE.md` 작성 (Phase 2)
- [ ] `agents/life/CLAUDE.md` 작성 (Phase 2)
- [ ] `agents/archive/CLAUDE.md` 작성 (Phase 2)
- [ ] Obsidian에서 열어 Mermaid 렌더링 확인
- [ ] 실제 C# 프로젝트에 적용 테스트

---

## ❓ 미해결 질문

1. **FDAI가 무엇인가?** — 제목에만 등장, 내용 미정
2. **Obsidian vault**를 하네스 루트와 동일하게 둘지, 별도로 둘지? → **동일하게 결정됨** (`C:\Claude\YJWOO Life`)
3. **Git 저장소**는 언제부터 시작할지?
4. **ABOUT-ME.md** 에 담을 정체성 범위 어디까지?

---

## 🔗 관련 대화

- 2026-04-23: 하네스 엔지니어링 개념 학습
- 2026-04-23: 40년 자료 정리 PM 논의
- 2026-04-23: Obsidian vs Notion 비교

---

## 💡 다음 세션 제안

다음 세션에서 이어갈 수 있는 선택지:

1. **ABOUT-ME.md 작성** — 사용자 정체성 파일 (하네스 심장부)
2. **agents/dev/CLAUDE.md 작성** — 기존 C# 프로젝트 규칙 통합
3. **FDAI 정의** — 프로젝트 설명 받아 `agents/life/projects/fdai/` 구축
4. **실제 C# 프로젝트에 적용 테스트** — 파일 배치 후 Claude Code 실행
