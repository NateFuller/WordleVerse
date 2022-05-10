//
//  String+WordleParserInput.swift
//  Recordle
//
//  Created by Nathan Fuller on 3/21/22.
//

import Foundation

extension String {
  static let hardMode =
  """
  Wordle 275 3/6*

  ⬛🟨⬛⬛⬛
  ⬛🟩⬛🟨🟨
  🟩🟩🟩🟩🟩
  """
  
  static let winInThree =
  """
  Wordle 275 3/6

  ⬛🟨⬛⬛⬛
  ⬛🟩⬛🟨🟨
  🟩🟩🟩🟩🟩
  """

  static let miss =
  """
  Wordle 294 X/6

  ⬛⬛🟩⬛⬛
  🟩🟩🟩⬛⬛
  ⬛⬛🟩🟨⬛
  ⬛⬛🟩🟩🟩
  ⬛⬛🟩🟩🟩
  ⬛⬛🟩🟩⬛
  """
}
