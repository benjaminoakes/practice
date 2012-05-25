Huffman = require('../lib/huffman')

describe 'helper', ->
  helper = Huffman.helper

  describe 'frequencies', ->
    it 'counts the occurences of each letter', ->
      expect(helper.frequencies('ABRRKBAARAA')).toEqual
        A: 5
        R: 3
        B: 2
        K: 1

  describe 'tree', ->
    it 'makes a tree of the frequencies', ->
      expect(helper.tree(A: 5, R: 3, B: 2, K: 1)).toEqual
        value: 'ARBK',
        left:
          value: 'A'
        right:
          value: 'RBK'
          left:
            value: 'R'
          right:
            value: 'BK'
            left:
              value: 'B'
            right:
              value: 'K'

  describe 'encodings', ->
    it 'translates a tree into its codes', ->
      tree =
        value: 'ARBK',
        left:
          value: 'A'
        right:
          value: 'RBK'
          left:
            value: 'R'
          right:
            value: 'BK'
            left:
              value: 'B'
            right:
              value: 'K'

      expect(helper.encodings(tree)).toEqual
        A:   '0'
        R:  '10'
        B: '110'
        K: '111'

describe 'presenter', ->
  original = 'ABRRKBAARAA'
  encoded = '01101010111110001000'
  presented = Huffman.presenter.present(original, encoded)

  describe 'presents the original string', ->
    expect(presented.originalString).toEqual('ABRRKBAARAA')

  describe 'presents the original byte count', ->
    expect(presented.originalByteCount).toEqual(11)

  describe 'presents the encoded string', ->
    expect(presented.encodedString).toEqual('01101010 11111000 10000000')

  describe 'presents an encoded byte count', ->
    expect(presented.encodedByteCount).toEqual(3)

  describe 'presents a compression percentage', ->
    expect(presented.compressionPercentage).toEqual('72%')

describe 'controller', ->
  controller = Huffman.controller

  it 'has usage information', ->
    expect(controller.usage(['huffman'])).toMatch(/huffman/)

  it 'has encoded data', ->
    expect(controller.encoded(['huffman', 'ABRRKBAARAA'])).toMatch(/ABRRKBAARAA/)

describe 'app', ->
  app = Huffman.app
  stdout = null
  process = null

  beforeEach ->
    stdout = null
    process = { env: { _: 'huffman' }, argv: ['coffee', '/path/to/huffman'] }

    spyOn(console, 'log').andCallFake (s) ->
      stdout = s

  describe 'without enough arguments', ->
    it 'shows usage', ->
      app.run(process)
      expect(stdout).toMatch(/Usage:/)

  describe 'with the --help flag', ->
    beforeEach ->
      process.argv.push('--help')

    it 'shows usage', ->
      app.run(process)
      expect(stdout).toMatch(/Usage:/)

  describe 'with a message', ->
    beforeEach ->
      process.argv.push('ABRRKBAARAA')

    it 'shows encoded data', ->
      app.run(process)
      expect(stdout).toMatch(/ABRRKBAARAA/)
      expect(stdout).toMatch(/01101010/)
