import 'dart:async';
import 'package:macros/macros.dart';

macro class Example implements ClassDeclarationsMacro {
  const Example();

  @override
  FutureOr<void> buildDeclarationsForClass(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) async {
     final defaultClassConstructor = await builder.constructorsOf(clazz);
    if (defaultClassConstructor.isNotEmpty) {
            builder.report(  Diagnostic( DiagnosticMessage(
              'A default constructor already exists. with Name: ${clazz.identifier.name}',
              target: defaultClassConstructor.first.asDiagnosticTarget,
            ),
            Severity.error,));
      
    }
    final fields = await builder.fieldsOf(clazz);
    builder.declareInType(DeclarationCode.fromParts([
    "${clazz.identifier.name}(" ,
    
    "{",
    for (final field in fields)
     ...[
          
            'required this.', "${field.identifier.name}, " ,
        
          ],
     "}",
     ");",
    // clazz.interfaces.first.identifier.name.toString(), //Simple the name of Interface if implements
    // clazz.superclass!.identifier.name.toString(), //Simple if it has a superclass or say inherited  if extends
    // .toString(),
      // 'SimpleA();',
    ]));
  }
}
