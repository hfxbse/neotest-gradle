local any_class_declaration = [[
    (
      (class_declaration name: (identifier) @namespace.name)
    ) @namespace.definition
  ]]

local method_with_test_marker = [[
    (
      (method_declaration
        (modifiers (marker_annotation name: (identifier) @test_marker.identifier))
        name: (identifier) @test.name
      )
      (#match? @test_marker.identifier "(ParameterizedTest|Test)")
    ) @test.definition
  ]]

local method_with_test_marker_and_display_name_annotation = [[
    (
      (method_declaration
        (modifiers
          (marker_annotation name: (identifier) @test_marker.identifier)
          (annotation
            name: (identifier) @display_name.identifier
            arguments: (annotation_argument_list (string_literal (string_fragment) @display_name.value))
          )
        )
        name: (identifier) @test.name
      )
      (#eq? @test_marker.identifier "Test")
      (#eq? @display_name.identifier "DisplayName")
    ) @test.definition
  ]]

-- Remind the order of the queries as first listed has higher priority.
return any_class_declaration
  .. method_with_test_marker_and_display_name_annotation
  .. method_with_test_marker
