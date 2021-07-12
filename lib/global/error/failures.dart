abstract class Failure {}

class RequiredFailure extends Failure {
  final String message;

  RequiredFailure(this.message);
}

class ServerFailure extends Failure {
  final List<String?> message;

  ServerFailure(this.message);
}

class PermissionFailure extends Failure {
  final String message = "Não foi possível concluir por falta de permissão.";
}

class FailuresMessages {
  static const String SERVER_CONNECTION_FAILURE =
      "Erro ao se conectar ao servidor";

  static const Map<int, dynamic> HTTP_FAILUES = {
    400: "Erro na requisição",
    401: "Não autorizado",
    403: "Conexão perdida",
    404: "Não encontrado",
    408: "Tempo esgotado",
  };
}
