module Document
	def toHtml(out)
		elements.each {|element|
			out.print(element.toHtml)
		}
	end
	
	def toDesc(out)
		elements.each {|element|
			out.print(element.toDesc)
		}
	end

end

module Command
	def toHtml
		root = "http://minnenratta.files.wordpress.com/2010/11/"
		return "<img src=\"" + root + parameters.get(0).toHtml + "\" />" if operation.toHtml == "includegraphics"
		return "<h1>" + parameters.get(0).toHtml + "</h1>" if operation.toHtml == "section"
		return "<h2>" + parameters.get(0).toHtml + "</h2>" if operation.toHtml == "subsection"
		return "";
	end
	
	def toDesc
		if defined?(options) && defined?(parameters)
			return operation.toDesc + "[" + options.toDesc + "]" + "{" + parameters.toDesc + "}"
		end
		if defined? options
			return operation.toDesc + "[" + options.toDesc + "]"
		end
		if defined? parameters
			return operation.toDesc + "{" + parameters.toDesc + "}"
		end
		return operation.toDesc
	end
end

module Parameters
	def toHtml
		return parameter.toHtml + '|' + parameters.toHtml
	end

	def toDesc
		return parameter.toDesc + ',' + parameters.toDesc
	end
	
	def get(position) 
		return parameter if position <= 0
		return parameters.get(--position)
	end
end

module Parameter
	def get(position)
		return self
	end
end

module Verbatim
	def toHtml
		return "<pre><code>" + verbatim_text.toHtml + "</code></pre>"
	end
	
	def toDesc
		return verbatim_text.toDesc
	end
end

module Text
	def toHtml
		return text_value
	end
	
	def toDesc
		return text_value
	end
end

