<?xml version="1.0" encoding="UTF-8"?>  <!-- -*- xml -*- -->
<!DOCTYPE chapter SYSTEM "local/xml/markup.dtd">
<chapter id="chp.preface">
  <title>Why Regular Expression Brain Teasers</title>

  <p> Regular expressions—sometimes given the playful back formation
  <firstuse>regexen</firstuse>, or more neurally
  <firstuse>regex</firstuse>—are a powerful and compact way of
  describing patterns in text.  Many tutorials and "cheat sheets" exist
  to understand their syntax and semantics in a formally correct manner.
  I encourage you to read some of those, if you have not already.  </p>

  <p> These brain teasers begin at a certain point where the formal
  descriptions leave off.  As you work with regexen, you will find
  subtle pitfalls.  A pattern that seems like it should obviously do one
  thing, actually matches something slightly different than you
  intended.  Or perhaps a match pattern has "pathological" behavior and
  takes far too long.  Or sometimes it is simply that a more concise
  pattern can also be clearer in describing what you actually wish to
  match.  </p>

  <p> A great many programming languages, libraries, and tools support
  regular expressions, with relatively minor variations in the syntax
  used.  Such software includes <class>[efr]?grep</class>,
  <class>sed</class>, <class>awk</class>, <class>Perl</class>,
  <class>Java</class>, <class>.NET</class>, <class>JavaScript</class>,
  <class>Julia</class>, <class>XML Schema</class>, or indeed, pretty
  much every other programming language via a library.  </p>

  <p> For this book, we will use Python to pose these puzzles.  In
  particular, we will use the standard library module <class>re</class>.
  Often code samples are used in puzzles and in explanation; where I
  wish to show the output from code, the example emulates to the Python
  shell with lines starting with <code>&gt;&gt;&gt;</code> (or
  continuing with <code>...</code>).  Outputs are echoed without
  a prompt in this case.  Where code defines a function that is not
  necessarily executed in the mention, only the plain code is shown.
  </p>

  <p> While you are reading this book, I strongly encourage you to keep
  open an interactive Python environment.  Many tools enable this, such
  as the Python REPL (read-evaluate-print-loop) itself, or the IPython
  enhanced REPL, or Jupyter notebooks, or the IDLE editor that comes
  with Python, or indeed most modern code editors and IDEs (integrated
  development environment).  A number of online regular expression 
  testers are also available, although those will not capture
  the details of the Python calling details.  Explanations will follow
  each puzzle, but trying to work it out in code before reading it is
  worthwhile.  </p>

</chapter>
