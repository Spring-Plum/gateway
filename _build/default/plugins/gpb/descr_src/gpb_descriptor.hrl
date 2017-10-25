%% -*- coding: utf-8 -*-
%% Automatically generated, do not edit
%% Generated by gpb_compile version 3.28.0

-ifndef(gpb_descriptor).
-define(gpb_descriptor, true).

-define(gpb_descriptor_gpb_version, "3.28.0").

-ifndef('UNINTERPRETEDOPTION.NAMEPART_PB_H').
-define('UNINTERPRETEDOPTION.NAMEPART_PB_H', true).
-record('UninterpretedOption.NamePart',
        {name_part,                     % = 1, string
         is_extension                   % = 2, bool
        }).
-endif.

-ifndef('UNINTERPRETEDOPTION_PB_H').
-define('UNINTERPRETEDOPTION_PB_H', true).
-record('UninterpretedOption',
        {name = [],                     % = 2, [{msg,'UninterpretedOption.NamePart'}]
         identifier_value,              % = 3, string (optional)
         positive_int_value,            % = 4, uint64 (optional)
         negative_int_value,            % = 5, int64 (optional)
         double_value,                  % = 6, double (optional)
         string_value,                  % = 7, bytes (optional)
         aggregate_value                % = 8, string (optional)
        }).
-endif.

-ifndef('ENUMVALUEOPTIONS_PB_H').
-define('ENUMVALUEOPTIONS_PB_H', true).
-record('EnumValueOptions',
        {deprecated = false,            % = 1, bool (optional)
         uninterpreted_option = []      % = 999, [{msg,'UninterpretedOption'}]
        }).
-endif.

-ifndef('FILEOPTIONS_PB_H').
-define('FILEOPTIONS_PB_H', true).
-record('FileOptions',
        {java_package,                  % = 1, string (optional)
         java_outer_classname,          % = 8, string (optional)
         java_multiple_files = false,   % = 10, bool (optional)
         java_generate_equals_and_hash = false, % = 20, bool (optional)
         java_string_check_utf8 = false, % = 27, bool (optional)
         optimize_for = 'SPEED',        % = 9, {enum,'FileOptions.OptimizeMode'} (optional)
         go_package,                    % = 11, string (optional)
         cc_generic_services = false,   % = 16, bool (optional)
         java_generic_services = false, % = 17, bool (optional)
         py_generic_services = false,   % = 18, bool (optional)
         deprecated = false,            % = 23, bool (optional)
         cc_enable_arenas = false,      % = 31, bool (optional)
         objc_class_prefix,             % = 36, string (optional)
         csharp_namespace,              % = 37, string (optional)
         javanano_use_deprecated_package, % = 38, bool (optional)
         uninterpreted_option = []      % = 999, [{msg,'UninterpretedOption'}]
        }).
-endif.

-ifndef('ENUMOPTIONS_PB_H').
-define('ENUMOPTIONS_PB_H', true).
-record('EnumOptions',
        {allow_alias,                   % = 2, bool (optional)
         deprecated = false,            % = 3, bool (optional)
         uninterpreted_option = []      % = 999, [{msg,'UninterpretedOption'}]
        }).
-endif.

-ifndef('ENUMVALUEDESCRIPTORPROTO_PB_H').
-define('ENUMVALUEDESCRIPTORPROTO_PB_H', true).
-record('EnumValueDescriptorProto',
        {name,                          % = 1, string (optional)
         number,                        % = 2, int32 (optional)
         options                        % = 3, {msg,'EnumValueOptions'} (optional)
        }).
-endif.

-ifndef('ENUMDESCRIPTORPROTO_PB_H').
-define('ENUMDESCRIPTORPROTO_PB_H', true).
-record('EnumDescriptorProto',
        {name,                          % = 1, string (optional)
         value = [],                    % = 2, [{msg,'EnumValueDescriptorProto'}]
         options                        % = 3, {msg,'EnumOptions'} (optional)
        }).
-endif.

-ifndef('ONEOFDESCRIPTORPROTO_PB_H').
-define('ONEOFDESCRIPTORPROTO_PB_H', true).
-record('OneofDescriptorProto',
        {name                           % = 1, string (optional)
        }).
-endif.

-ifndef('SOURCECODEINFO.LOCATION_PB_H').
-define('SOURCECODEINFO.LOCATION_PB_H', true).
-record('SourceCodeInfo.Location',
        {path = [],                     % = 1, [int32]
         span = [],                     % = 2, [int32]
         leading_comments,              % = 3, string (optional)
         trailing_comments,             % = 4, string (optional)
         leading_detached_comments = [] % = 6, [string]
        }).
-endif.

-ifndef('SERVICEOPTIONS_PB_H').
-define('SERVICEOPTIONS_PB_H', true).
-record('ServiceOptions',
        {deprecated = false,            % = 33, bool (optional)
         uninterpreted_option = []      % = 999, [{msg,'UninterpretedOption'}]
        }).
-endif.

-ifndef('GENERATEDCODEINFO.ANNOTATION_PB_H').
-define('GENERATEDCODEINFO.ANNOTATION_PB_H', true).
-record('GeneratedCodeInfo.Annotation',
        {path = [],                     % = 1, [int32]
         source_file,                   % = 2, string (optional)
         'begin',                       % = 3, int32 (optional)
         'end'                          % = 4, int32 (optional)
        }).
-endif.

-ifndef('DESCRIPTORPROTO.EXTENSIONRANGE_PB_H').
-define('DESCRIPTORPROTO.EXTENSIONRANGE_PB_H', true).
-record('DescriptorProto.ExtensionRange',
        {start,                         % = 1, int32 (optional)
         'end'                          % = 2, int32 (optional)
        }).
-endif.

-ifndef('DESCRIPTORPROTO.RESERVEDRANGE_PB_H').
-define('DESCRIPTORPROTO.RESERVEDRANGE_PB_H', true).
-record('DescriptorProto.ReservedRange',
        {start,                         % = 1, int32 (optional)
         'end'                          % = 2, int32 (optional)
        }).
-endif.

-ifndef('MESSAGEOPTIONS_PB_H').
-define('MESSAGEOPTIONS_PB_H', true).
-record('MessageOptions',
        {message_set_wire_format = false, % = 1, bool (optional)
         no_standard_descriptor_accessor = false, % = 2, bool (optional)
         deprecated = false,            % = 3, bool (optional)
         map_entry,                     % = 7, bool (optional)
         uninterpreted_option = []      % = 999, [{msg,'UninterpretedOption'}]
        }).
-endif.

-ifndef('FIELDOPTIONS_PB_H').
-define('FIELDOPTIONS_PB_H', true).
-record('FieldOptions',
        {ctype = 'STRING',              % = 1, {enum,'FieldOptions.CType'} (optional)
         packed,                        % = 2, bool (optional)
         jstype = 'JS_NORMAL',          % = 6, {enum,'FieldOptions.JSType'} (optional)
         lazy = false,                  % = 5, bool (optional)
         deprecated = false,            % = 3, bool (optional)
         weak = false,                  % = 10, bool (optional)
         uninterpreted_option = []      % = 999, [{msg,'UninterpretedOption'}]
        }).
-endif.

-ifndef('FIELDDESCRIPTORPROTO_PB_H').
-define('FIELDDESCRIPTORPROTO_PB_H', true).
-record('FieldDescriptorProto',
        {name,                          % = 1, string (optional)
         number,                        % = 3, int32 (optional)
         label,                         % = 4, {enum,'FieldDescriptorProto.Label'} (optional)
         type,                          % = 5, {enum,'FieldDescriptorProto.Type'} (optional)
         type_name,                     % = 6, string (optional)
         extendee,                      % = 2, string (optional)
         default_value,                 % = 7, string (optional)
         oneof_index,                   % = 9, int32 (optional)
         json_name,                     % = 10, string (optional)
         options                        % = 8, {msg,'FieldOptions'} (optional)
        }).
-endif.

-ifndef('DESCRIPTORPROTO_PB_H').
-define('DESCRIPTORPROTO_PB_H', true).
-record('DescriptorProto',
        {name,                          % = 1, string (optional)
         field = [],                    % = 2, [{msg,'FieldDescriptorProto'}]
         extension = [],                % = 6, [{msg,'FieldDescriptorProto'}]
         nested_type = [],              % = 3, [{msg,'DescriptorProto'}]
         enum_type = [],                % = 4, [{msg,'EnumDescriptorProto'}]
         extension_range = [],          % = 5, [{msg,'DescriptorProto.ExtensionRange'}]
         oneof_decl = [],               % = 8, [{msg,'OneofDescriptorProto'}]
         options,                       % = 7, {msg,'MessageOptions'} (optional)
         reserved_range = [],           % = 9, [{msg,'DescriptorProto.ReservedRange'}]
         reserved_name = []             % = 10, [string]
        }).
-endif.

-ifndef('SOURCECODEINFO_PB_H').
-define('SOURCECODEINFO_PB_H', true).
-record('SourceCodeInfo',
        {location = []                  % = 1, [{msg,'SourceCodeInfo.Location'}]
        }).
-endif.

-ifndef('METHODOPTIONS_PB_H').
-define('METHODOPTIONS_PB_H', true).
-record('MethodOptions',
        {deprecated = false,            % = 33, bool (optional)
         uninterpreted_option = []      % = 999, [{msg,'UninterpretedOption'}]
        }).
-endif.

-ifndef('METHODDESCRIPTORPROTO_PB_H').
-define('METHODDESCRIPTORPROTO_PB_H', true).
-record('MethodDescriptorProto',
        {name,                          % = 1, string (optional)
         input_type,                    % = 2, string (optional)
         output_type,                   % = 3, string (optional)
         options,                       % = 4, {msg,'MethodOptions'} (optional)
         client_streaming = false,      % = 5, bool (optional)
         server_streaming = false       % = 6, bool (optional)
        }).
-endif.

-ifndef('SERVICEDESCRIPTORPROTO_PB_H').
-define('SERVICEDESCRIPTORPROTO_PB_H', true).
-record('ServiceDescriptorProto',
        {name,                          % = 1, string (optional)
         method = [],                   % = 2, [{msg,'MethodDescriptorProto'}]
         options                        % = 3, {msg,'ServiceOptions'} (optional)
        }).
-endif.

-ifndef('FILEDESCRIPTORPROTO_PB_H').
-define('FILEDESCRIPTORPROTO_PB_H', true).
-record('FileDescriptorProto',
        {name,                          % = 1, string (optional)
         package,                       % = 2, string (optional)
         dependency = [],               % = 3, [string]
         public_dependency = [],        % = 10, [int32]
         weak_dependency = [],          % = 11, [int32]
         message_type = [],             % = 4, [{msg,'DescriptorProto'}]
         enum_type = [],                % = 5, [{msg,'EnumDescriptorProto'}]
         service = [],                  % = 6, [{msg,'ServiceDescriptorProto'}]
         extension = [],                % = 7, [{msg,'FieldDescriptorProto'}]
         options,                       % = 8, {msg,'FileOptions'} (optional)
         source_code_info,              % = 9, {msg,'SourceCodeInfo'} (optional)
         syntax                         % = 12, string (optional)
        }).
-endif.

-ifndef('FILEDESCRIPTORSET_PB_H').
-define('FILEDESCRIPTORSET_PB_H', true).
-record('FileDescriptorSet',
        {file = []                      % = 1, [{msg,'FileDescriptorProto'}]
        }).
-endif.

-ifndef('GENERATEDCODEINFO_PB_H').
-define('GENERATEDCODEINFO_PB_H', true).
-record('GeneratedCodeInfo',
        {annotation = []                % = 1, [{msg,'GeneratedCodeInfo.Annotation'}]
        }).
-endif.

-endif.
