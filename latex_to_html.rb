require 'rubygems'
require 'treetop'
require 'latex_grammar'
require 'html_builder'

def latex
	parser = LatexParser.new
	source = ARGV[0]
	tex = File.read(source + ".tex")
	
	tree = parser.parse(tex)
	
	puts "Can't parse!! index : " + parser.index.to_s unless tree
	
	puts tree.to_s
	
	File.open(source + ".html","w") {|out|
		out.puts("<!doctype html>")
		out.puts("<html><body>")
		tree.toHtml(out)
		out.puts("</body></html>")
	}
	
end

def test(sample, inspect = false)
	parser = LatexParser.new
	tree = parser.parse(sample)
	puts sample
	puts tree.inspect if inspect
	tree.toDesc($stdout)
	tree.toHtml($stdout)
	puts "END"
end

test "\\operation1[opt1,opt2]{param1,param2}"

test "\\operation1[opt1,opt2]"

test "\\includegraphics[scale=0.4]{src.png}"

test "\\noOptions{param1}"

test "text\\commandOpts[pippo]{yyyy ,uu uu}text\\rootCommand{\\subcommand[]{param}},text {text}{}text\\commandEmptyPar{}"

latex