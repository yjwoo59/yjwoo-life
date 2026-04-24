# 🚀 05. 로드맵

> 하네스 구축 장기 계획.
> **돌아가기**: [← CLAUDE.md](../CLAUDE.md)

---

## 전체 일정 (간트 차트)

```mermaid
gantt
    title 하네스 구축 로드맵 (2026)
    dateFormat YYYY-MM-DD
    axisFormat %m-%d

    section Phase 1: 뼈대
    최상위 CLAUDE.md         :done, a1, 2026-04-24, 1d
    분리 문서 5개            :done, a2, 2026-04-24, 1d
    ABOUT-ME.md              :active, a3, 2026-04-25, 2d
    폴더 구조 생성            :a4, after a3, 1d

    section Phase 2: 서브에이전트
    Dev Agent CLAUDE.md      :b1, 2026-05-01, 3d
    Life Agent CLAUDE.md     :b2, after b1, 3d
    Archive Agent CLAUDE.md  :b3, after b2, 2d

    section Phase 3: 실전
    실전 테스트               :c1, 2026-05-11, 7d
    규칙 보정                 :c2, after c1, 7d

    section Phase 4: 확장
    MCP 서버 연결             :d1, 2026-06-01, 7d
    Filesystem MCP           :d2, after d1, 3d
    GitHub MCP               :d3, after d2, 3d

    section Phase 5: 자동화
    Semantic Kernel 검토      :e1, 2026-07-01, 14d
    C# 오케스트레이터 구현    :e2, after e1, 21d
```

---

## 단계별 목표

```mermaid
graph LR
    P1[Phase 1<br/>뼈대<br/>1주] --> P2[Phase 2<br/>서브에이전트<br/>1주]
    P2 --> P3[Phase 3<br/>실전 검증<br/>2주]
    P3 --> P4[Phase 4<br/>MCP 확장<br/>1개월]
    P4 --> P5[Phase 5<br/>코드 자동화<br/>2개월+]

    style P1 fill:#90ee90
    style P2 fill:#ffd700
    style P3 fill:#ffd700
    style P4 fill:#e0e0e0
    style P5 fill:#e0e0e0
```

---

## Phase별 상세

### Phase 1 — 뼈대 (4/24 ~ 4/30)

**목표**: 파일만으로 돌아가는 최소 하네스

- [x] CLAUDE.md (최상위)
- [x] docs/01~05 분리 문서
- [ ] shared/ABOUT-ME.md
- [ ] 실제 폴더 구조 생성

**완료 기준**: Claude Code가 CLAUDE.md만 읽고 작업 분기 가능

---

### Phase 2 — 서브에이전트 (5/1 ~ 5/10)

**목표**: 3개 도메인 에이전트 규칙화

- [ ] `agents/dev/CLAUDE.md` — 기존 시방서·dev.md 연결
- [ ] `agents/life/CLAUDE.md` — FDAI 등 프로젝트 정의
- [ ] `agents/archive/CLAUDE.md` — 70TB 인벤토리 전략

**완료 기준**: 각 에이전트가 독립 작업 가능

---

### Phase 3 — 실전 검증 (5/11 ~ 5/24)

**목표**: 실제 작업으로 규칙 검증·보정

- [ ] 실제 C# 작업 1개 통과
- [ ] 프로젝트 관리 작업 1개 통과
- [ ] 자료 검색 작업 1개 통과
- [ ] 빠진 규칙 추가

**완료 기준**: 컨텍스트 드리프트 없음, 리밋 초과 없음

---

### Phase 4 — MCP 확장 (6월)

**목표**: 외부 도구 연결

- [ ] Filesystem MCP (로컬 파일 직접 접근)
- [ ] GitHub MCP (커밋·PR 자동화)
- [ ] (선택) DB MCP, Jira MCP

---

### Phase 5 — 코드 자동화 (7월+)

**목표**: C# 오케스트레이터 구현

- [ ] Semantic Kernel 학습
- [ ] 플러그인 기반 서브에이전트
- [ ] Claude API 연결
- [ ] .NET 네이티브 운영

---

## 마일스톤 체크포인트

| 시점 | 체크 항목 |
|---|---|
| 4/30 | 파일 기반 하네스 완성 |
| 5/10 | 3개 에이전트 가동 |
| 5/24 | 실전 검증 완료 |
| 6/30 | MCP 2개 이상 연결 |
| 8/31 | Semantic Kernel 전환 여부 결정 |

---

## 관련 문서

- [🗺️ 01. 전체 구조](./01-structure.md)
- [🔁 04. 검증 절차](./04-feedback-loop.md)
