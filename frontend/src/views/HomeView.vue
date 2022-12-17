<template>
  <div class="home" >
    <div class="row">
      <div class="col">
        <button type="button" class="btn btn-danger" @click="texto = ''">Limpiar</button>

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
        
        <textarea class="form-control" v-model="traduccion" placeholder="Escribe aqui..." id="floatingTextarea2" style="height: 100px; width: 1500px; margin-left: 200px; margin-top: 0px;" ></textarea>
        <br><br><br><br><br><br>
        
      </div>
    </div>
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
    texto: '',
    traduccion: '',

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
        this.traduccion= r.data.traduccion;
      } catch (error) {
        console.log("Error no es posible gestionar el analisis del txt");
      }
    }


  }
}
</script>
