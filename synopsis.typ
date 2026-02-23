// To compile use the following command
// ❯ typst compile --ignore-system-fonts --font-path . synopsis.typ
//
// To compile and open use following command
// ❯ typst compile --ignore-system-fonts --font-path . --open <VIEWER> synopsis.typ
//
// And to edit with real-time feedback use the following command
// ❯ typst watch --ignore-system-fonts --font-path . --open <VIEWER> synopsis.typ
//
//
// Some constants

#let names = (
  (name: "Aditya Bahe", roll_no: 28),
  (name: "Ayush Paranjale", roll_no: 35),
  (name: "Himanshu Pawar", roll_no: 43),
  (name: "Prabhu Kalantri", roll_no: 56),
  (name: "Varad Pusadkar", roll_no: 66),
)
#let guide = "Prof. Monika Bagade"

//
// Some global config
//

#set text(hyphenate: false)
#set par(justify: true)
#set text(
  kerning: true,
  font: "Baskervville",
  size: 12pt,
)

#set page(
  paper: "a4",
  margin: 2.5cm,
)

#show heading: set text(font: "Mona Sans", weight: "bold") 

// Some constant blocks

#let first_page = [

#set text(font: "Mona Sans", weight: "bold")
#show heading: set text(font: "Mona Sans", weight: "extrabold") 

#align(center)[
  = BinStop \ (An PE executable behaviour analysis tool)
  \
  === Synopsis submitted to \ Shri Ramdeobaba College of Engineering & Management, Nagpur \ in partial fulfillment of requirement for the award of the degree of

  == Bachelor of Technology (B.Tech)
  \
  _*In*_
  \
  == COMPUTER SCIENCE AND ENGINEERING  (Cyber Security)
  \
  *_By_*\
  \
  #for kv in names {
    [*#kv.name (#kv.roll_no)*\ ]
  }
  \
  _*Guide*_ \ \
  #guide \ \

  #image("logo.png", fit: "contain", height: 12%)


  *Department of Computer Science and Engineering -- Cyber Security \ Shri Ramdeobaba College of Engineering & Management, Nagpur 440 013*

  (An Autonomous Institute affiliated to Rashtrasant Tukdoji Maharaj \ Nagpur University Nagpur)

  February 2026

] ]

#let last_page = [
  \ \
  #table(
    columns: (4fr, 1fr, 4fr),
    table.header([*Name of Students*], [*Roll No.*], [*Name of Guide*]),
    align: center,

    ..{
      let (name, roll_no) = names.at(0)
      ([#name], [#roll_no])
    },
    table.cell(
      [#guide],
      rowspan: names.len(),
      align: horizon,
    ),
    ..for rec in names.slice(1, 5) {
      ([#rec.name], [#rec.roll_no])
    },
  )
  \ \ \
  *Approved by:*
  \ \ \
  #grid(
    rows: 3cm,
    columns: 3,
    gutter: 1fr,
    [*Head of Department* #parbreak() *Cyber Security*], [*Guide* #parbreak() Prof. Koushik Roy], [],
  )
]

// Start of contents


#first_page
#pagebreak()

== PROBLEM STATEMENT
Knowing how an application interacts with the operating system is essential in domains such as security behavior analysis. Applications use WinAPI calls to request services from the operating system, but it can be difficult to manually track and analyze these WinAPI calls in large, complex systems. The depth and interactivity required to fully understand the behaviors and performance impacts of these WinAPI calls are often lacking in current tools, which leads to inefficient analysis and delayed debugging.

\
== PROBLEM DESCRIPTION :
Debugging, performance optimization, and security analysis of modern software depend
heavily on understanding how an application interacts with the operating system to request
services such as reading files, allocating memory, or interacting with hardware. Applications
primarily rely on WinAPI calls to perform these operations.

However, manually monitoring and interpreting these WinAPI calls remains a challenging
and time-consuming task. Debugging is often inefficient because many existing tools lack the
automation and contextual depth needed to fully analyze these interactions. Additionally, such
tools may struggle to identify unusual activity or potential security threats effectively.

In the previous semester, we established a foundational system for this project. We successfully
implemented a mechanism to intercept API calls from the Windows API (specifically api32-
related calls) made by executable programs. Alongside this, we developed a structured
database capable of storing and retrieving detailed descriptions and contextual information
for intercepted API calls. This foundation enables automated enrichment of raw logs with
meaningful explanations, significantly improving interpretability.

Building upon this groundwork, the goal of the project is to create a analyzer that records,
logs, and examines WinAPI calls with enhanced contextual insights. The system will integrate
intelligent analysis techniques, including the use of Large Language Models (LLMs), to provide
deeper behavioral interpretation, anomaly detection, and security insights. The tracer aims
to assist developers, reverse engineers, and malware analysts in understanding applicationOS interactions more efficiently and accurately. Ultimately, this tool seeks to deliver a
more thorough, automated, and insightful approach to analyzing program behavior, thereby
accelerating debugging, reverse engineering, and threat analysis workflows.

\
== PROJECT OBJECTIVES :

=== Completed (Previous Semester):
- Implemented a system to intercept and trace WinAPI (Win32/API32) calls from executable programs, capturing parameters, timestamps, and return values.
- Developed a database to store API metadata and descriptions, enabling contextual enrichment of collected logs.

=== Current Objectives:
- Build a centralized medium to communicate and manage intercepted logs and API call data.
- Increase interception coverage by adding support for more Win32 API hooks through an automated or semi-automated hook generation mechanism.
- Utilize Large Language Models (LLMs) to extract behavioral insights, workflows, and potential security indicators.\ \

\
== METHODOLOGY :

- *WinAPI Call Tracing*: When the application or executable (EXE) file is launched, the WinAPI call tracer is activated. Using hooking functions to intercept WinAPI calls during their execution, the tracer (shown as the WinAPI Call Tracer Core in the flow) records the WinAPI calls made by the application.

- *Logging*: Once intercepted, the WinAPI calls are recorded and stored in a database for future reference. Key information such as function parameters, return values, and timestamps is logged. To add context, these logs are enhanced with additional descriptive data, such as function names and expected behaviors.

- *Log Enhancement*: After additional processing to include detailed descriptions, the logs are stored in the database for later retrieval and deeper insights.

- *LLM Analysis*: The Large Language Model (LLM) analyzes the enriched logs to generate high-level insights, identify patterns, and detect issues—such as inefficiencies or suspicious activities. This step aids in reconstructing workflows and understanding the purpose of the WinAPI calls.

//- Report Generation: The results from log analysis and LLM insights are compiled into a final report. This report covers the application's behavior or workflow, identified problems, performance bottlenecks, and potential security threats.

#figure(
  image("flow.jpeg", height: 75%),
  caption: [
    Basic workflow
  ],
)

\
== TECHNOLOGY :

- C/C++ for generated hooks

- Detours Library is used in C++ to hook and intercept WinAPI calls.

- RadDebugger: will be used as interface, custom command dispatching to debugger

- SQLite is used to store and manage the enriched data and captured WinAPI call logs.

// - Custom Parsing Logic is employed to add more context to logs, such as function names and expected behavior.
// - ChatGPT (LLM): Used for WinAPI call intent analysis, insight generation, and enriched log analysis.
// - Python and C++: Python is used for log analysis and report generation, while C++ handles WinAPI call tracing.
// - _SQL_: Used to manage and query database syscall data.

\
== FUNTIONAL SPECIFICATION :

- WinAPI call logs will be stored in a database and enriched with information regarding expected behaviors, function names, and source code locations.
- The system will store and manage logs efficiently and allow users to start, stop, and monitor tracing sessions.
- The system will support expansion of API coverage through additional hooks, including an automated or semi-automated hook generation mechanism.
- By identifying problematic WinAPI calls, developers will be able to use the insights to debug and enhance system performance.
- The tool will monitor WinAPI call activity to detect abnormal or unauthorized behavior, aiding in the identification of potential security risks.
\ \ \
#last_page
