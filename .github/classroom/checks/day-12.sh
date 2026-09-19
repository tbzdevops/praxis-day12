#!/bin/bash
# PRAXIS Tag 12 — AI in DevOps (eine Lektion).
# Nicht zu verwechseln mit dem gleichnamigen Projekt-Check im Repository
# techstyle. Geprüft wird das Wurzel-Verzeichnis: Spec, Code und Tests liegen
# dort, wo sie im echten Repo auch liegen.
source .github/classroom/grade.sh

DOKU=DOKUMENTATION.md

# pytest wird für "Tests laufen grün" gebraucht. Auf ubuntu-latest fehlt es,
# und pip darf dort nicht ins System-Python installieren — deshalb ein
# eigenes Wegwerf-Venv. Lokal ist pytest oft schon vorhanden.
PYTHON=python3
if ! "$PYTHON" -m pytest --version >/dev/null 2>&1; then
  VENV="${RUNNER_TEMP:-${TMPDIR:-/tmp}}/tag12-praxis-venv"
  [ -x "$VENV/bin/python" ] || python3 -m venv "$VENV" >/dev/null 2>&1
  "$VENV/bin/python" -m pip install --quiet --disable-pip-version-check pytest >/dev/null 2>&1 \
    && PYTHON="$VENV/bin/python"
fi

# Gibt den Text eines Auftrags-Abschnitts aus DOKUMENTATION.md aus — ohne
# HTML-Kommentare und ohne <Platzhalter>. Mit --raw bleiben die Platzhalter
# drin (für die Platzhalter-Prüfung).
# Aufruf: doku_section <nr> [--raw]
doku_section() {
  python3 - "$DOKU" "$1" "${2:-}" <<'PY'
import re, sys

path, nr, raw = sys.argv[1], sys.argv[2], sys.argv[3] == "--raw"
# Gleiche Form wie in has_placeholder.
PLACEHOLDER = r"<[A-Za-zÄÖÜäöü.][^<>\n]*(?:\s|\.\.\.|/)[^<>\n]*>"
try:
    text = open(path, encoding="utf-8").read()
except OSError:
    sys.exit(1)
text = re.sub(r"<!--.*?-->", "", text, flags=re.S)
m = re.search(rf"^##\s+Auftrag\s+{nr}\b.*?(?=^##\s+Auftrag\s+\d|\Z)", text, flags=re.S | re.M | re.I)
if not m:
    sys.exit(1)
section = m.group(0)
if not raw:
    section = re.sub(PLACEHOLDER, "", section)
print(section)
PY
}

# Ein Platzhalter beginnt mit einem Buchstaben oder Punkt und enthält ein
# Leerzeichen, "..." oder "/" — z. B. <Name 1>, <...>, <ja/nein>. Nicht
# gemeint sind Tags wie <diff> oder </diff> und Vergleiche wie "x < 6".
has_placeholder() { grep -qE '<[[:alpha:].][^<>]*([[:space:]]|\.\.\.|/)[^<>]*>'; }

# Anzahl Wörter ausserhalb von Überschriften und Tabellenköpfen.
words() { grep -vE '^[[:space:]]*(#|\|[[:space:]-]*\||$)' | wc -w; }

solution_for_id() {
  case "$1" in
    spec)
      echo "Lege die Spec unter specs/rabattcode.md an (Vorlage in der Tagesplanung, Auftrag 1 Teil A)." ;;
    spec-content)
      echo "Die Spec braucht die vier Abschnitte Ziel, Anforderungen, Akzeptanzkriterien und Out of Scope — als Überschriften (## Ziel usw.)." ;;
    impl)
      echo "Lege die von der AI generierte Implementierung unter discounts/validator.py ab (plus leere discounts/__init__.py)." ;;
    tests)
      echo "Lege tests/test_discount.py an und übernimm jedes Akzeptanzkriterium der Spec als eigene Funktion def test_...()." ;;
    pytest)
      echo "Führe lokal 'python3 -m pytest -q' aus und behebe die roten Tests. Fehlt discounts/__init__.py, findet pytest das Modul nicht." ;;
    a1-doku)
      echo "Fülle in DOKUMENTATION.md den Abschnitt 'Auftrag 1' aus: was die AI übersehen hat, was du korrigiert hast, was die Spec verändert hat. Alle <Platzhalter> ersetzen, mindestens 40 Wörter." ;;
    a2-table)
      echo "Fülle in DOKUMENTATION.md die Tabelle im Abschnitt 'Auftrag 2' aus: je Angriff ja/nein ohne und mit Härtung. Alle <Platzhalter> ersetzen." ;;
    a2-prompt)
      echo "Trage im Abschnitt 'Auftrag 2' deinen gehärteten System-Prompt als Codeblock (zwischen zwei Zeilen mit drei Backticks) ein — mindestens 20 Wörter." ;;
    a2-transfer)
      echo "Beantworte im Abschnitt 'Auftrag 2' die Transfer-Frage: wie ein Angreifer einen AI-Review-Bot über den Diff eines Pull Requests manipulieren kann und was dagegen hilft. Das Wort 'Diff' muss vorkommen." ;;
    *) echo "Überprüfe die Aufgabenstellung im README" ;;
  esac
}

echo "🔍 Prüfe Abnahmekriterien für Tag 12 Praxis — AI in DevOps"
echo ""
echo "── Auftrag 1: Spec-Driven Development mit AI ──"

check "spec" \
  "Auftrag 1: Spec vorhanden (specs/*.md)" \
  "ls specs/*.md 2>/dev/null | grep -q ."

check "spec-content" \
  "Auftrag 1: Spec nennt Ziel, Anforderungen, Akzeptanzkriterien und Out of Scope" \
  "grep -qiE '^#+[[:space:]]*ziel' specs/*.md && grep -qiE '^#+[[:space:]]*anforderung' specs/*.md && grep -qiE '^#+[[:space:]]*akzeptanzkriterien' specs/*.md && grep -qiE '^#+[[:space:]]*out.of.scope' specs/*.md"

check "impl" \
  "Auftrag 1: Implementierung zur Spec vorhanden (discounts/*.py)" \
  "ls discounts/*.py 2>/dev/null | grep -v '/__init__\.py$' | grep -q ."

check "tests" \
  "Auftrag 1: Tests zu den Akzeptanzkriterien vorhanden (tests/test_*.py mit def test_)" \
  "grep -qE '^[[:space:]]*def test_' tests/test_*.py"

check "pytest" \
  "Auftrag 1: Tests laufen grün (pytest)" \
  "ls tests/test_*.py 2>/dev/null | grep -q . && \"\$PYTHON\" -m pytest -q -p no:cacheprovider tests/"

check "a1-doku" \
  "Auftrag 1: Review des AI-Outputs dokumentiert (DOKUMENTATION.md, ohne Platzhalter, mind. 40 Wörter)" \
  "! doku_section 1 --raw | has_placeholder && [ \$(doku_section 1 | words) -ge 40 ]"

echo ""
echo "── Auftrag 2: Prompt Injection ──"

check "a2-table" \
  "Auftrag 2: Ergebnis je Angriff dokumentiert (ohne Platzhalter, ja/nein)" \
  "doku_section 2 --raw >/dev/null && ! doku_section 2 --raw | has_placeholder && doku_section 2 | grep -qiwE 'ja|nein'"

check "a2-prompt" \
  "Auftrag 2: Gehärteter System-Prompt als Codeblock (mind. 20 Wörter)" \
  "[ \$(doku_section 2 | awk '/^[[:space:]]*\`\`\`/{f=!f; next} f' | wc -w) -ge 20 ]"

check "a2-transfer" \
  "Auftrag 2: Transfer auf den AI-Review-Bot — Angriff über den PR-Diff beschrieben" \
  "doku_section 2 | grep -vE '^[[:space:]]*#' | grep -qi 'diff'"

summary 12
