import 'dart:io';

void main() {
  int opcao = 0;

  do {
    print(
      "Você deseja abrir qual programa? \n 1 - Pessoa \n 2 - Carro \n 3 - Conta Bancaria \n 4 - Media de Aluno \n 5 - Produtos \n 6 - Funcionario \n 7 - SAIR",
    );
    opcao = int.parse(stdin.readLineSync()!);

    switch (opcao) {
      case 1:
        print("Ola! \nQual é o seu nome?");
        String? nome = stdin.readLineSync();
        print("Qual é a sua idade?");
        int idade = int.parse(stdin.readLineSync()!);

        Pessoa pessoa = Pessoa(nome, idade);
        pessoa.ExibirDados();
        enter();
        break;

      case 2:
        print("Qual é a marca do seu carro?");
        String? marca = stdin.readLineSync();
        print("Qual é o modelo do seu carro?");
        String? modelo = stdin.readLineSync();
        print("Qual foi o preço do seu carro?");
        int preco = int.parse(stdin.readLineSync()!);

        Carro carro = Carro(marca, modelo, preco);
        carro.ExibirDetalhes();
        enter();
        break;

      case 3:
        print("Qual é o titular da conta?");
        String? titular = stdin.readLineSync();
        print("Qual é o saldo inicial da conta?");
        double saldo = double.parse(stdin.readLineSync()!);

        ContaBancaria conta = ContaBancaria(titular, saldo);

        int opcaoConta = 0;

        do {
          print(
            "Você deseja \n 1 - Depositar \n 2 - Sacar \n 3 - Informações da conta \n 4 - sair"
          );
          
          opcaoConta = int.parse(stdin.readLineSync()!);

          switch (opcaoConta) {
            case 1:
              print("Qual é o valor que voce deseja depositar?");
              double deposito = double.parse(stdin.readLineSync()!);
              conta.depositar(deposito);
              break;

            case 2:
              print("Qual é o valor que voce deseja sacar?");
              double saque = double.parse(stdin.readLineSync()!);
              conta.sacar(saque);
              break;

            case 3:
              conta.ExibirSaldo();
              break;

            case 4 :
              print("Saindo...");
              break;

            default:
              print("Opção inválida. Tente novamente.");
          }
        } while (opcaoConta != 4);
      break;

      case 4:
        print("Qual é o nome do aluno?");
        String? nome = stdin.readLineSync();

        print("Qual foi a primeira nota do $nome?");
        double nota1 = double.parse(stdin.readLineSync()!);

        print("Qual foi a segunda nota do $nome?");
        double nota2 = double.parse(stdin.readLineSync()!);

        Aluno aluno = Aluno(nome, nota1, nota2);
        aluno.verificarAprovacao();
        aluno.media();
        enter();
        break;

      case 5:
        print("Qual é o nome do produto?");
        String? nome = stdin.readLineSync();
        print("Qual é o preço atual do produto?");
        double preco = double.parse(stdin.readLineSync()!);
        print("Qual é o desconto a ser aplicado em cima do produto?");
        double desconto = double.parse(stdin.readLineSync()!);

        Produto produto = Produto(nome, preco);
        produto.ExibirPrecosemDesconto();

        Produto produtoDesconto = Produto.comDesconto(nome, preco, desconto);
        produtoDesconto.ExibirPrecocomDesconto();
        enter();
        break;

      case 6:
        print("Qual é o seu nome?");
        String? nomeFuncionario = stdin.readLineSync();

        print("Qual é o seu salario atual?");
        double salario = double.parse(stdin.readLineSync()!);

        print("Seu salario aumentou quantos %?");
        double percentual = double.parse(stdin.readLineSync()!);

        Funcionario funcionario = Funcionario(nomeFuncionario, salario);
        funcionario.aumentarSalario(percentual);
        enter();
        break;

      case 7:
        print("Saindo do programa...");
        break;

      default:
        print("Opção inválida! Tente novamente.");
        break;
    }
  } while (opcao != 7);
}

void enter() {
  stdin.readLineSync();
}

class Pessoa {
  String? nome;
  int _idade;

  Pessoa(this.nome, this._idade);

  int get idade {
    return _idade;
  }

  set idade(int idade) {
    if (idade > 0) {
      _idade = idade;
    }
  }

  void ExibirDados() {
    print("Seu nome é $nome e você tem $idade anos!");
  }
}

class Carro {
  String? marca;
  String? modelo;
  int _preco;

  Carro(this.marca, this.modelo, this._preco);

  int get preco {
    return _preco;
  }

  set preco(int novoPreco) {
    if (novoPreco > 0) {
      _preco = novoPreco;
    }
  }

  void ExibirDetalhes() {
    print(
      "Seu carro é da marca $marca do modelo $modelo e você pagou R\$ $preco",
    );
  }
}

class ContaBancaria {
  String? titular;
  double _saldo;

  ContaBancaria(this.titular, this._saldo);

  void depositar(double valor) {
    if (valor > 0) {
      _saldo += valor;
      print("Deposito realizado!");
    } else {
      print("O deposito deve ser positivo");
    }
  }

  void sacar(double valor) {
    if (valor <= _saldo) {
      _saldo -= valor;
      print("O saque de R\$ $valor foi realizado!");
    } else {
      print("Saldo insuficiente");
    }
  }

  double get saldo {
    return _saldo;
  }

  void ExibirSaldo() {
    print("O saldo atual é de R\$ $saldo");
  }
}

class Aluno {
  String? nome;
  final double _nota1;
  final double _nota2;

  Aluno(this.nome, this._nota1, this._nota2);

  double calcularMedia() {
    return (_nota1 + _nota2) / 2;
  }

  void media() {
    print("A media do aluno é ${calcularMedia()}");
  }

  void verificarAprovacao() {
    double media = calcularMedia();

    if (media >= 7) {
      print("O aluno esta aprovado!");
    } else {
      print("O aluno esta reprovado!");
    }
  }
}

class Produto {
  String? nome;
  final double _preco;
  double desconto = 0.0;

  Produto(this.nome, this._preco) : desconto = 0.0;
  Produto.comDesconto(this.nome, this._preco, this.desconto);

  double calcularDesconto() {
    return _preco * (desconto / 100);
  }

  double precoComDesconto() {
    return _preco - calcularDesconto();
  }

  void ExibirPrecocomDesconto() {
    print("O preço com o desconto é de R\$ ${precoComDesconto()}");
  }

  void ExibirPrecosemDesconto() {
    print("O preço sem o desconto é de R\$ $_preco");
  }
}

class Funcionario {
  String? nome;
  final double _salario;

  Funcionario(this.nome, this._salario);

  double get salario {
    return _salario;
  }

  void aumentarSalario(double percentual) {
    double salarioPercentual = salario * (percentual / 100);
    double salarioAtualizado = salario + salarioPercentual;

    print("O salario atual é de R\$ $salarioAtualizado");
  }
}
