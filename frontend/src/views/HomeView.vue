<template>
  <div class="home" >
    <div class="row">
      <div class="col">
        <button type="button" class="btn btn-info" >Buscar Archivo</button>

      </div>
      <div class="col">
        <button type="button" class="btn btn-danger" @click="texto = '' ,traduccion = ''">Limpiar</button>

      </div>
      <div class="col">
        <button type="button" class="btn btn-primary" @click="realizarAnalisis">Analizar</button>

      </div>
      
      <div class="form-floating">
        <br><br>
        <div class="card text-dark bg-info mb-3" style="max-width: 8rem;margin-left: 200px;">
          <div class="card-header">Lenguaje</div>
          <div class="card-body">
            <h5 class="card-title">C#</h5>
          </div>
        </div>
        
        <textarea class="form-control" v-model="texto" placeholder="Escribe aqui..." id="floatingTextarea2" style="height: 100px; width: 1500px; margin-left: 200px; margin-top: 0px;" ></textarea>
        <br><br>
        <div class="card text-white bg-success mb-3" style="max-width: 8rem;margin-left: 200px;">
          <div class="card-header">Lenguaje</div>
          <div class="card-body">
            <h5 class="card-title">Python</h5>
          </div>
        </div>
        <br><br>
        <textarea class="form-control" v-model="traduccion" placeholder="Escribe aqui..." id="floatingTextarea2" style="height: 100px; width: 1500px; margin-left: 200px; margin-top: 0px;" ></textarea>
        <br><br>
        <div class="card text-white bg-warning mb-3" style="max-width: 8rem;margin-left: 200px;">
          <div class="card-header">Herramienta</div>
          <div class="card-body">
            <h5 class="card-title">HTML</h5>
          </div>
        </div>
        
        <textarea class="form-control" v-model="traduccion" placeholder="Escribe aqui..." id="floatingTextarea2" style="height: 100px; width: 1500px; margin-left: 200px; margin-top: 0px;" ></textarea>
        
        <br><br><br><br><br><br>
        
      </div>
    </div>
    <h1 class="display-1">Tabla de Simbolos</h1><br><br><br><br><br><br>
    <table class="table">
    <thead>
      <tr>
        <th scope="col">Identificador</th>
        <th scope="col">Tipo de dato</th>
        <th scope="col">Token</th>
        <th scope="col">Valor</th>
        <th scope="col">Fila</th>
        <th scope="col">Columna</th>
      </tr>
    </thead>
        <tbody>
            <tr v-for="(item,i) in simbolos" :key=i>
              <td>{{item.identificador}}</td>
              <td>{{item.tipo_dato}}</td>
              <td>{{item.token}}</td>
              <td>{{item.valor}}</td>
              <td>{{item.fila}}</td>
              <td>{{item.columna}}</td>

            </tr>
        </tbody>
      </table>
      <br><br><br><br>
      <h1 class="display-1">Tabla de Errores Lexicos</h1><br><br><br><br><br><br>
    <table class="table">
    <thead>
      <tr>
        <th scope="col">Lexema</th>
        <th scope="col">Fila</th>
        <th scope="col">Columna</th>
        <th scope="col">Tipo</th>
      </tr>
    </thead>
        <tbody>
            <tr v-for="(item,i) in lexico" :key=i>
              <td>{{item.lexema}}</td>
              <td>{{item.fila}}</td>
              <td>{{item.columna}}</td>
              <td>{{item.tipo}}</td>
              

            </tr>
        </tbody>
      </table>

  </div>
  
</template>

<script>

// @ is an alias to /src


export default {
  name: 'HomeView',
  components: {
    
  },
  data: () => ({
    errores_sintacticos: [],
    simbolos:[],
    texto: '',
    traduccion: '',
    lexico:[],

  }),


  async created() {
    console.log("URL EN USO", process.env.VUE_APP_SERVICE_URL1);

  },

  methods: {

    async realizarAnalisis() {
      try {
        let r = await this.$store.state.services.serviciosUsuario.realizarAnalisis({ text: this.texto })
        console.log("Respuesta del analisis ", r);
        this.errores_sintacticos = r.data.errores_sintacticos;
        this.lexico = r.data.errores_lexicos;
        this.traduccion= r.data.traduccion;
        this.simbolos=r.data.tabla_simbolos
      } catch (error) {
        console.log("Error no es posible gestionar el analisis del txt");
      }
    }


  }
}
</script>
