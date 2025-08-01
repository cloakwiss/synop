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
  ( name: "Prabhu Kalantri", roll_no: 55, ),
)
#let guide = "Prof. Koushik Roy"

// Some constant blocks

#let first_page = [#align(center)[ 
= BinStop \ (An binary executable behaviour analysis tool)
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

#image("logo.png", fit: "contain", height: 15%)


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
#set text(kerning: true, font: "Amazon Ember")
#set page(
  paper: "a4",
  margin: 2.5cm,
)


// Start of contents 


#first_page
#pagebreak()

== PROBLEM STATEMENT

Knowing how an application interacts with the operating system is essential in domains
such as security behavior analysis. Applications use system calls (syscalls) to ask
the operating system for services, but it can be difficult to manually track and analyze
these syscalls in large, complex systems. The depth and interactivity required for
completely understanding the behaviors and performance impacts of these syscalls are
often not present in current tools, which results in inefficient analysis and pushed
back debugging.


== PROBLEM DESCRIPTION :

Debugging, performance optimisation, and security analysis of today's software  all
depend on understanding of how an application interacts with the operating system
to request different services from the OS, like reading files, allocating
memory, or interacting with hardware, applications mainly rely on system calls, or
syscalls. However, manually monitoring and deciphering these syscalls becomes a difficult
and time-consuming task /* in large and complex applications*/. Debugging is 
inefficient because current tools often lack the depth and automation needed to
fully analyse these interactions. Furthermore, these tools might not be able to identify
unusual activity or possible security-threats. The goal of this project is to create
a /* syscall tracer */ behavior analyzer that will record, log, and examine syscalls made by executable programs
By adding thorough context to the logs. The tracer will assist developers and /* security
experts*/ reverse engineers and malware analyst in learning more about application and OS interactions /*workflows, identifying inefficiencies, and
detecting malicious activity*/ by using tools such as Large Language Models (LLMs) for
/* deeper */ insights. The goal of this tool is to provide a more thorough, effective, and
perceptive method of examining how applications /* communicate */ behave and interact with the operating system
 which will ultimately speedup understanding the program behavior. /* security monitoring, performance tuning, and debugging */ 

== PROJECT OBJECTIVES :

- _Intercept and Trace Syscalls_: Record and intercept system calls from programs, noting important information like timestamps, parameters, and return values.
- _Improve Log Context_: For better analysis, add more context to syscall logs, such as function names, source locations, and expected behaviors.
- _Leverage LLM for Insights_: From enriched syscall logs, extract high-level insights, workflows, and intent by using Large Language Models (LLM).
- _Create Reports_: Create actionable, readable reports that highlight security threats, performance problems, and syscall behavior.
- _Support Debugging and Profiling_: Help developers find and address problems relating to faulty or inefficient syscalls, thereby improving system performance.
// - _Improve Security Monitoring_: Look for strange syscall patterns that might point to malicious activity or security flaws.
- _Assist Reverse Engineering_: By tracking syscalls and discovering operational intent, this technique assists in the analysis and understanding of application workflow
- _Examine Syscall Patterns_: Use syscall sequence analysis to find performance snags, redundancies, and odd behaviors.

== METHODOLOGY :

- _Syscall Tracing_: When the application or EXE file launches, the syscall tracer is launched. Using hooking functions to intercept system calls while they are being executed, the tracer (shown as the Syscall Tracer Core in the flow) records syscalls made by the application.
//TODO: This needs to be split in 2
- _Logging /*and Database Storage*/_: After being intercepted, the syscalls are recorded and kept in a database for later use. Function parameters, return values, and timestamps are among the crucial information found in logs. To add context, these logs are enhanced with extra descriptive data (such as function names and expected behavior).
- _Log Enhancement_: After undergoing additional processing to include thorough descriptions, the logs are saved in the database for later retrieval and deeper insights.
- _LLM Analysis_: To produce high-level insights, identify patterns, and find any problems—such as inefficiencies or questionable activity—the LLM examines the enriched logs. Rebuilding workflows and comprehending the purpose of the syscalls are aided by this step.
- _Report Generation_: The results of the log analysis and LLM insights are compiled in a final report. This covers the behavior or workflow of the application, identified problems, performance snags, and possible security threats.

== TECHNOLOGY :

- _Detours Library_ is used in C++ to hook and intercept system calls.
- _SQLite_: Used to store and handle enriched data and captured system call logs.
- _Custom Parsing Logic_: To add more context to logs, like function names and expected behavior.
- _ChatGPT (LLM)_: For syscall intent comprehension, insight generation, and enriched log analysis.
// - For creating organized, readable reports, use Markdown.
- _Python and C++_: Python for log analysis and report generation, and C++ for syscall tracing.
// - _SQL_: Used to manage and query database syscall data.

== FUNTIONAL SPECIFICATION :

- Syscall logs are kept in a database and improved with information about expected behaviors, function names, and source code locations.
- The enriched logs are analyzed by a Large Language Model (LLM) to find patterns and workflows as well as problems like performance difficulties or security threats.
- Based on the analysis, the tool produces thorough reports that point out inefficiencies and security issues.
- By identifying challenging syscalls, developers can use the insights to debug problems and improve system performance.
- The program keeps an eye on syscall activity to spot odd or unauthorized activity, helping in spotting possible security risks.

#pagebreak()
#last_page
