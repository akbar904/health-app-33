import 'package:appwrite/appwrite.dart';
import 'package:stacked/stacked.dart';

class AppwriteService implements InitializableDependency {
  late final Client client;
  late final Account account;
  late final Databases databases;
  late final Storage storage;

  static const String projectId = '675ed00de90cdb0b8076';
  static const String endpoint = 'https://cloud.appwrite.io/v1';
  static const String databaseId = 'medical_records';
  static const String patientsCollectionId = 'patients';
  static const String diagnosisCollectionId = 'diagnoses';
  static const String usersCollectionId = 'users';

  @override
  Future<void> init() async {
    client = Client()
      ..setEndpoint(endpoint)
      ..setProject(projectId)
      ..setSelfSigned(status: true);

    account = Account(client);
    databases = Databases(client);
    storage = Storage(client);
  }

  Future<void> createSession(String email, String password) async {
    try {
      await account.createEmailSession(
        email: email,
        password: password,
      );
    } catch (e) {
      throw _handleAppwriteError(e);
    }
  }

  Future<void> createAccount(String email, String password, String name) async {
    try {
      await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
    } catch (e) {
      throw _handleAppwriteError(e);
    }
  }

  Future<void> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
    } catch (e) {
      throw _handleAppwriteError(e);
    }
  }

  Future<bool> isAuthenticated() async {
    try {
      await account.get();
      return true;
    } catch (e) {
      return false;
    }
  }

  Exception _handleAppwriteError(dynamic error) {
    if (error is AppwriteException) {
      switch (error.code) {
        case 401:
          return Exception(
              'Invalid credentials. Please check your email and password.');
        case 409:
          return Exception('An account with this email already exists.');
        case 429:
          return Exception('Too many attempts. Please try again later.');
        case 503:
          return Exception(
              'Service temporarily unavailable. Please try again later.');
        default:
          return Exception('An unexpected error occurred. Please try again.');
      }
    }
    return Exception(
        'Unable to connect to the server. Please check your internet connection.');
  }

  Future<Document> createDocument(
    String collectionId,
    Map<String, dynamic> data,
  ) async {
    try {
      return await databases.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: ID.unique(),
        data: data,
      );
    } catch (e) {
      throw _handleAppwriteError(e);
    }
  }

  Future<Document> getDocument(
    String collectionId,
    String documentId,
  ) async {
    try {
      return await databases.getDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: documentId,
      );
    } catch (e) {
      throw _handleAppwriteError(e);
    }
  }

  Future<DocumentList> listDocuments(
    String collectionId, {
    List<String>? queries,
  }) async {
    try {
      return await databases.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
        queries: queries,
      );
    } catch (e) {
      throw _handleAppwriteError(e);
    }
  }

  Future<Document> updateDocument(
    String collectionId,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    try {
      return await databases.updateDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: documentId,
        data: data,
      );
    } catch (e) {
      throw _handleAppwriteError(e);
    }
  }

  Future<void> deleteDocument(
    String collectionId,
    String documentId,
  ) async {
    try {
      await databases.deleteDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: documentId,
      );
    } catch (e) {
      throw _handleAppwriteError(e);
    }
  }
}
