# ## Huffman Encoder (#[123](http://www.rubyquiz.com/quiz123.html))
# by Harlan
# 
# Huffman Coding is a common form of data compression where none of the original data gets lost. It begins by analyzing a string of data to determine which pieces occur with the highest frequencies. These frequencies and pieces are used to construct a binary tree. It is the “path” from root node to the leaf with this data that forms its encoding. The following example should explain things:
# 
#     Data:  ABRRKBAARAA (11 bytes)
#     
#     Frequency counts:
#     A  5
#     R  3
#     B  2
#     K  1
#     
#     In Huffman Tree form, with frequency weights in parentheses:
#          ARBK (11)
#         /    \  
#        0      1
#       /        \
#     A (5)      RBK (6)
#               /   \
#              0     1
#             /       \
#           R (3)     BK (3)
#                     / \
#                    0   1
#                   /     \
#                 B (2)   K (1)
#     
#     The encoding for each character is simply the path to that character:
#     A    0
#     R   10
#     B  110
#     K  111
#     
#     Here is the original data encoded:
#     01101010 11111000 1000 (fits in 3 bytes)
# 
# We have compressed the original information by 80%!
# 
# A key point to note is that every character encoding has a unique prefix, corresponding to the unique path to that character within the tree. If this were not so, then decoding would be impossible due to ambiguity.
# 
# The quiz this time is to write a program to implement a compression program using Huffman encoding.
#
#     Extra Credit:
#     Perform the actual encoding using your tree.  You may encounter one issue
#     during the decompression/decoding phase.  Your encoded string may not be a
#     multiple of 8.  This means that when you compress your encoding into a
#     binary number, padding 0’s get added.  Then, upon decompression, you may
#     see extra characters.  To counter this, one solution is to add your own
#     padding of 1 extra character every time.  And then simply strip it off
#     once you have decoded.
#     
#     You may also wish to provide a way to serialize the Huffman Tree so it
#     can be shared among copies of your program.
#     
#     ./huffman_encode.rb I want this message to get encoded!
#     
#     Encoded:
#     11111111 11111110 11111111 11101111 10111111
#     01100110 11111111 11110111 11111111 11011100
#     11111111 11010111 01110111 11011110 10011011
#     11111100 11110101 10010111 11101111 11111011
#     11111101 11111101 01111111 01111111 11111110
#     Encoded Bytes:
#     25
#     
#     Original:
#     I want this message to get encoded!
#     Original Bytes:
#     35
#     
#     Compressed:  28%

helper =
  frequencies: (string) ->
    # A: 5
    # R: 3
    # B: 2
    # K: 1

  tree: (frequencies) ->
    # value: 'ARBK',
    # left:
    #   value: 'A'
    # right:
    #   value: 'RBK'
    #   left:
    #     value: 'R'
    #   right:
    #     value: 'BK'
    #     left:
    #       value: 'B'
    #     right:
    #       value: 'K'
  
  encodings: (tree) ->
    # A:   '0'
    # R:  '10'
    # B: '110'
    # K: '111'

encoder =
  encode: (string) ->
    # fs = helper.frequencies(string)
    # t = helper.tree(fs)
    # encodings = helper.encodings(t)
    # string.chars.map (char) -> encodings[char]

    # '01101010111110001000'

presenter = do ->
  ratio = (string, encoded) ->
    # 0.8
  
  bytes = (bitstring) ->
    # ['01101010', '11111000', '10000000']

  present: (string, encoded) ->
    # originalString: 'ABRRKBAARAA'
    # originalByteCount: 11
    # encodedString: '01101010 11111000 10000000'
    # encodedByteCount: 3
    # compressionPercentage: '80%'

templates =
  usage: """
    Usage: {{programName}} message [--help]

    Compress the message using Huffman coding.

      message   Message to encode
      --help    Show this help text
    
    Example:
    
      $ {{programName}} "I want this message to get encoded!"
    """

  encoded: """
    Encoded:
    {{encodedString}}
    Encoded Bytes:
    {{encodedByteCount}}
    
    Original:
    {{originalString}}
    Original Bytes:
    {{originalByteCount}}
    
    Compressed:  {{compressionPercentage}}
    """

controller =
  usage: (argv) ->
    # Handlebars.compile(templates.usage, programName: argv[0])

  encoded: (argv) ->
    # string = argv[1]
    # encoded = encoder.encode(string)
    # data = presenter.present(string, encoded)
    # Handlebars.compile(templates.encoded, data)

app =
  run: (process) ->
    # # Make argv more UNIX-y
    # argv = process.argv.slice(2)
    # argv.unshift(process.env['_'])

    # if (1 == argv.length) || (argv.indexOf('--help') >= 0)
    #   rendered = controller.usage(argv)
    # else
    #   rendered = controller.encoded(argv)
    # 
    # console.log(rendered)

module.exports =
  helper: helper
  encoder: encoder
  presenter: presenter
  app: app
