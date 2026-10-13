class ReciclajeService {
  String contenedorPara(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'papel':
        return 'Contenedor para papel';
      case 'organico':
        return 'Contenedor organico';
      case 'plastico':
        return 'Contenedor para reciclaje';
      default:
        return 'Consultar clasificación local';
    }
  }
}