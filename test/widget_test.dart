import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_firebase_authentication/main.dart'; // ⚠️ troque "seu_pacote" pelo nome do seu pacote real

class MockFirebaseApp extends Mock implements FirebaseApp {}

void main() {
  setUpAll(() async {
    // Simula o Firebase antes de rodar os testes
    TestWidgetsFlutterBinding.ensureInitialized();
    try {
      await Firebase.initializeApp();
    } catch (_) {
      // ignora erros se já estiver inicializado
    }
  });

  testWidgets('App loads without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verifica se o app inicializa e exibe algo na tela
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
