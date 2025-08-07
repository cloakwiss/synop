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
  ( name: "Aditya Bahe", roll_no: 28, ),
  ( name: "Ayush Paranjale", roll_no: 35, ),
  ( name: "Gunangi Bhagat", roll_no: 3, ),
  ( name: "Himanshu Pawar", roll_no: 43, ),
  ( name: "Prabhu Kalantri", roll_no: 56, ),
)
#let guide = "Prof. Kaushik Roy"

// Some constant blocks

#let first_page = [#align(center)[ 
= BinStop \ (An PE executable behaviour analysis tool)
\
=== Synopsis submitted to \ Shri Ramdeobaba College of Engineering & Management, Nagpur \ in partial fulfillment of requirement for the award of the degree of

== Bachelor of Technology (B.Tech)
\
_*In*_
\
=== COMPUTER SCIENCE AND ENGINEERING  (Cyber Security)
\
*_By_*\ 
\
  #for kv in names {
    [#kv.name (#kv.roll_no) \ ]
  }  
\
_*Guide*_ \ \
  #guide \ \

#image("logo.png", fit: "contain", height: 12%)


==== Department of Computer Science and Engineering -- Cyber Security \ Shri Ramdeobaba College of Engineering & Management, Nagpur 440 013

(An Autonomous Institute affiliated to Rashtrasant Tukdoji Maharaj \ Nagpur University Nagpur)

*July 2025*

] ]

#let last_page = [
\ \
#table(  
  columns: (4fr, 1fr, 4fr),
  table.header(
    [*Name of Students*], [*Roll No.*], [*Name of Guide*]
  ),
  align: center,

  ..{
    let (name, roll_no) = names.at(0);
    ([#name],  [#roll_no])
  },
  table.cell(
    [#guide],
    rowspan: names.len(),
    align: horizon,
  ),
  ..for rec in names.slice(1,5) { 
    ([#rec.name], [#rec.roll_no],)
  }
)
\ \ \
*Approved by:*
\ \ \
#grid(
  rows: 3cm,
  columns: 3,
  gutter: 1fr,
  [*Head of Department* #parbreak() *Cyber Security*],
  [*Guide* #parbreak() Prof. Koushik Roy],
  [],
)
]

// 
// Some global config
// 

#set text(hyphenate: false)
#set par(justify: true)
#set text(
  kerning: true,
  font: "PT Serif",
  size: 12pt
)
#set page(
  paper: "a4",
  margin: 2.5cm,
)


// Start of contents 


#first_page
#pagebreak()

== PROBLEM STATEMENT
\
Knowing how an application interacts with the operating system is essential in domains such as security behavior analysis. Applications use WinAPI calls to request services from the operating system, but it can be difficult to manually track and analyze these WinAPI calls in large, complex systems. The depth and interactivity required to fully understand the behaviors and performance impacts of these WinAPI calls are often lacking in current tools, which leads to inefficient analysis and delayed debugging.

\
== PROBLEM DESCRIPTION :
Debugging, performance optimization, and security analysis of today's software all depend on understanding how an application interacts with the operating system to request various services from the OS, such as reading files, allocating memory, or interacting with hardware. Applications primarily rely on WinAPI calls.

However, manually monitoring and deciphering these WinAPI calls becomes a challenging and time-consuming task. Debugging is often inefficient because current tools lack the depth and automation needed to fully analyze these interactions. Furthermore, these tools might not be able to identify unusual activity or potential security threats. The goal of this project is to create a behavior analyzer that will record, log, and examine WinAPI calls made by executable programs by adding comprehensive context to the logs. The tracer will assist developers, reverse engineers, and malware analysts in learning more about application and OS interactions by using tools such as Large Language Models (LLMs) for insights. The goal of this tool is to provide a more thorough, effective, and perceptive method of examining how applications behave and interact with the operating system, ultimately speeding up the understanding of program behavior.
\ \
== PROJECT OBJECTIVES :
\
- Intercept and Trace WinAPI Calls: Record and intercept WinAPI calls from programs, capturing important information like timestamps, parameters, and return values.

- Improve Log Context: To enhance analysis, add more context to WinAPI call logs, such as function names, source code locations, and expected behaviors.

- Leverage LLM for Insights: From enriched WinAPI call logs, extract high-level insights, workflows, and intent by using Large Language Models (LLM).

- Create Reports: Create actionable, readable reports that highlight security threats, performance issues, and WinAPI call behavior.

- Support Debugging and Profiling: Help developers identify and address issues related to faulty or inefficient WinAPI calls, thereby improving system performance.

- Assist Reverse Engineering: By tracking WinAPI calls and uncovering operational intent, this technique assists in analyzing and understanding the application workflow.

- Examine WinAPI Call Patterns: Use WinAPI call sequence analysis to identify performance bottlenecks, redundancies, and abnormal behaviors.
\ \
== METHODOLOGY :
\
- WinAPI Call Tracing: When the application or executable (EXE) file is launched, the WinAPI call tracer is activated. Using hooking functions to intercept WinAPI calls during their execution, the tracer (shown as the WinAPI Call Tracer Core in the flow) records the WinAPI calls made by the application.

- Logging: Once intercepted, the WinAPI calls are recorded and stored in a database for future reference. Key information such as function parameters, return values, and timestamps is logged. To add context, these logs are enhanced with additional descriptive data, such as function names and expected behaviors.

- Log Enhancement: After additional processing to include detailed descriptions, the logs are stored in the database for later retrieval and deeper insights.

- LLM Analysis: The Large Language Model (LLM) analyzes the enriched logs to generate high-level insights, identify patterns, and detect issues—such as inefficiencies or suspicious activities. This step aids in reconstructing workflows and understanding the purpose of the WinAPI calls.

- Report Generation: The results from log analysis and LLM insights are compiled into a final report. This report covers the application's behavior or workflow, identified problems, performance bottlenecks, and potential security threats.
#figure(
  image("flow_chart.png", height: 60%),
  caption: [
    Basic workflow
  ],
)
\ \
== TECHNOLOGY :

- Detours Library is used in C++ to hook and intercept WinAPI calls.

- SQLite is used to store and manage the enriched data and captured WinAPI call logs.

- Custom Parsing Logic is employed to add more context to logs, such as function names and expected behavior.

- ChatGPT (LLM): Used for WinAPI call intent analysis, insight generation, and enriched log analysis.

- Python and C++: Python is used for log analysis and report generation, while C++ handles WinAPI call tracing.
// - _SQL_: Used to manage and query database syscall data.
\ 
== FUNTIONAL SPECIFICATION :
\
- WinAPI call logs are stored in a database and enriched with information regarding expected behaviors, function names, and source code locations.

- The enriched logs are analyzed by a Large Language Model (LLM) to uncover patterns and workflows, as well as to detect issues like performance difficulties or security threats.

- Based on the analysis, the tool generates comprehensive reports that highlight inefficiencies and security vulnerabilities.

- By identifying problematic WinAPI calls, developers can use the insights to debug and enhance system performance.

- The tool monitors WinAPI call activity to detect abnormal or unauthorized behavior, aiding in the identification of potential security risks.

\ \ \
#last_page
