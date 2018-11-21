import ObjectMapper

class Login : Mappable {
	var cpf : String?
	var senha : String?
	
	required init?(map: Map) {}
    
    init(cpf: String, senha: String) {
        self.cpf = cpf
        self.senha = senha
    }

    func mapping(map: Map) {

		cpf <- map["cpf"]
		senha <- map["senha"]
	}
}

class Registro : Mappable {
    var cpf : String?
    var nome : String?
    var email : String?
    var dtNascimento : String?
    var senha : String?
    
    required init?(map: Map) {}
    
    init(cpf: String, nome: String, email: String, dtNascimento: String, senha: String) {
        self.cpf = cpf
        self.nome = nome
        self.email = email
        self.dtNascimento = dtNascimento
        self.senha = senha
    }
    
    func mapping(map: Map) {
        
        cpf <- map["cpf"]
        nome <- map["nome"]
        email <- map["email"]
        dtNascimento <- map["dtNascimento"]
        senha <- map["senha"]
    }
}

class RegistroCelular : Mappable {
    var numero : String?
    var token : String?

    required init?(map: Map) {}
    
    init(numero: String, token: String) {
        self.numero = numero
        if !token.isEmpty { self.token = token }
    }
    
    func setToken(value: String) {
        self.token = value
    }
    
    func mapping(map: Map) {
        numero <- map["numero"]
        token <- map["token"]
    }
}

class RegistroSenha : Mappable {
    var cpf : String?
    var token : String?
    var senha : String?
    
    required init?(map: Map) {}
    
    init(cpf: String, senha: String,  token: String) {
        self.cpf = cpf
        self.cpf = cpf
        if !token.isEmpty { self.token = token }
    }
    
    func setToken(value: String) {
        self.token = value
    }
    
    func mapping(map: Map) {
        cpf <- map["cpf"]
        senha <- map["senha"]
        token <- map["token"]
    }
}
