import React, { useState, useEffect } from 'react';
import './App.css';

function App() {
  const [atletas, setAtletas] = useState([]);
  const [cargando, setCargando] = useState(true);

  // Estados para el CRUD (Modal y Formulario)
  const [mostrarModal, setMostrarModal] = useState(false);
  const [editandoId, setEditandoId] = useState(null);
  const [formData, setFormData] = useState({
    name: '',
    categoria: 'Profesional Masculino'
  });

  // Estados para CRUD de Resultados
  const [mostrarModalResultados, setMostrarModalResultados] = useState(false);
  const [atletaResultadosActual, setAtletaResultadosActual] = useState(null);
  const [formDataResultados, setFormDataResultados] = useState({
    id: null,
    pts_boulder: 0,
    pts_lead: 0,
    tiempo_speed: 0,
    pts_speed_calc: 0,
    total_acumulado: 0
  });

  const cargarAtletas = () => {
    fetch("http://localhost:8081/atleta/all")
      .then((respuesta) => respuesta.json())
      .then((datos) => {
        setAtletas(datos);
        setCargando(false);
      })
      .catch((error) => {
        console.error("Hubo un error al pedir los datos:", error);
        setCargando(false);
      });
  };

  useEffect(() => {
    cargarAtletas();
  }, []);

  // --------------- LÓGICA CRUD -----------------

  const abrirModalCrear = () => {
    setEditandoId(null);
    setFormData({ name: '', categoria: 'Profesional Masculino' });
    setMostrarModal(true);
  };

  const abrirModalEditar = (atleta) => {
    setEditandoId(atleta.id);
    setFormData({
      name: atleta.name,
      categoria: atleta.categoria
    });
    setMostrarModal(true);
  };

  const cerrarModal = () => {
    setMostrarModal(false);
  };

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const abrirModalResultados = (atleta) => {
    setAtletaResultadosActual(atleta);
    const listaResultados = atleta.resultados || atleta.resultado;
    const res = (listaResultados && listaResultados.length > 0) ? listaResultados[0] : null;

    if (res) {
      setFormDataResultados({
        id: res.id,
        pts_boulder: res.pts_boulder || 0,
        pts_lead: res.pts_lead || 0,
        tiempo_speed: res.tiempo_speed || 0,
        pts_speed_calc: res.pts_speed_calc || 0,
        total_acumulado: res.total_acumulado || 0
      });
    } else {
      setFormDataResultados({
        id: null,
        pts_boulder: 0,
        pts_lead: 0,
        tiempo_speed: 0,
        pts_speed_calc: 0,
        total_acumulado: 0
      });
    }
    setMostrarModalResultados(true);
  };

  const cerrarModalResultados = () => {
    setMostrarModalResultados(false);
    setAtletaResultadosActual(null);
  };

  const handleChangeResultados = (e) => {
    const { name, value } = e.target;
    setFormDataResultados(prev => {
      const updated = {
        ...prev,
        [name]: parseFloat(value) || 0
      };
      // Auto-calcular total
      updated.total_acumulado = (updated.pts_boulder || 0) + (updated.pts_lead || 0) + (updated.pts_speed_calc || 0);
      return updated;
    });
  };

  const guardarResultados = async (e) => {
    e.preventDefault();

    const url = formDataResultados.id
      ? `http://localhost:8081/resultados/update/${formDataResultados.id}`
      : `http://localhost:8081/resultados/save`;

    const metodo = formDataResultados.id ? 'PUT' : 'POST';

    const payload = { ...formDataResultados, atleta_id: atletaResultadosActual.id };

    try {
      const resp = await fetch(url, {
        method: metodo,
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });

      if (!resp.ok) {
        console.warn(`Falló ${metodo} a ${url}`);
      }

      cerrarModalResultados();
      cargarAtletas(); // Recargar la lista
    } catch (error) {
      console.error("Error al guardar resultados:", error);
      alert("No se pudo conectar al servidor para guardar resultados.");
    }
  };

  const guardarAtleta = async (e) => {
    e.preventDefault();

    // Dependiendo si tu API usa /atleta o /atleta/save para guardar
    // Usaremos los estándares REST más comunes.
    const url = editandoId
      ? `http://localhost:8081/atleta/update/${editandoId}`
      : `http://localhost:8081/atleta/save`;

    const metodo = editandoId ? 'PUT' : 'POST';

    const payload = { ...formData };
    if (editandoId) { payload.id = editandoId; }

    try {
      const resp = await fetch(url, {
        method: metodo,
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });

      // Si la API Spring no responde PUT /atleta/{id}, puedes intentar cambiar url a /atleta/save
      if (!resp.ok) {
        // Intento fallback si la ruta era distinta en tu Java (muy común)
        console.warn(`Falló ${metodo} a ${url}. Asegúrate que las rutas existan en tu @RestController de Spring.`);
      }

      cerrarModal();
      cargarAtletas(); // Recargar la lista
    } catch (error) {
      console.error("Error al guardar:", error);
      alert("No se pudo conectar al servidor para guardar. Revisa la consola.");
    }
  };

  const eliminarAtleta = async (id) => {
    if (!window.confirm("¿Seguro que deseas eliminar a este atleta?")) return;

    try {
      const resp = await fetch(`http://localhost:8081/atleta/delete/${id}`, {
        method: 'DELETE'
      });

      if (!resp.ok) {
        console.warn(`Falló DELETE a /atleta/${id}. Verifica la ruta en Spring.`);
      }

      cargarAtletas();
    } catch (error) {
      console.error("Error al eliminar:", error);
      alert("Error de conexión al eliminar.");
    }
  };

  // ---------------- RENDERING -----------------

  return (
    <div className="App">

      {/* MODAL PARA CREAR Y EDITAR */}
      {mostrarModal && (
        <div className="modal-overlay">
          <div className="modal-content">
            <h2>{editandoId ? "Editar Atleta" : "Nuevo Atleta"}</h2>
            <form onSubmit={guardarAtleta}>

              <div className="form-group">
                <label>Nombre Completo</label>
                <input
                  type="text"
                  name="name"
                  className="form-control"
                  placeholder="Ej: Adam Ondra"
                  value={formData.name}
                  onChange={handleChange}
                  required
                />
              </div>

              <div className="form-group">
                <label>Categoría</label>
                <select
                  name="categoria"
                  className="form-control"
                  value={formData.categoria}
                  onChange={handleChange}
                >
                  <option value="Profesional Masculino">Profesional Masculino</option>
                  <option value="Profesional Femenino">Profesional Femenino</option>
                  <option value="Amateur Masculino">Amateur Masculino</option>
                  <option value="Amateur Femenino">Amateur Femenino</option>
                </select>
              </div>

              <div className="modal-actions">
                <button type="button" className="btn-secondary" onClick={cerrarModal}>Cancelar</button>
                <button type="submit" className="btn-primary">
                  {editandoId ? "Actualizar" : "Crear Atleta"}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* MODAL PARA EDITAR RESULTADOS */}
      {mostrarModalResultados && (
        <div className="modal-overlay">
          <div className="modal-content">
            <h2>Resultados de {atletaResultadosActual?.name}</h2>
            <form onSubmit={guardarResultados}>

              <div className="form-group">
                <label>Pts Boulder</label>
                <input type="number" step="0.1" name="pts_boulder" className="form-control" value={formDataResultados.pts_boulder} onChange={handleChangeResultados} required />
              </div>

              <div className="form-group">
                <label>Pts Lead</label>
                <input type="number" step="0.1" name="pts_lead" className="form-control" value={formDataResultados.pts_lead} onChange={handleChangeResultados} required />
              </div>

              <div className="form-group">
                <label>Tiempo Speed (s)</label>
                <input type="number" step="0.01" name="tiempo_speed" className="form-control" value={formDataResultados.tiempo_speed} onChange={handleChangeResultados} required />
              </div>

              <div className="form-group">
                <label>Pts Speed (Calculado)</label>
                <input type="number" step="0.1" name="pts_speed_calc" className="form-control" value={formDataResultados.pts_speed_calc} onChange={handleChangeResultados} required />
              </div>

              <div className="score-total" style={{margin: '15px 0', textAlign: 'center'}}>
                <span>Puntaje Total Calculado: {formDataResultados.total_acumulado}</span>
              </div>

              <div className="modal-actions">
                <button type="button" className="btn-secondary" onClick={cerrarModalResultados}>Cancelar</button>
                <button type="submit" className="btn-primary">Guardar Resultados</button>
              </div>
            </form>
          </div>
        </div>
      )}


      <header className="App-header" style={{ minHeight: '100vh', padding: '40px 20px', background: 'transparent' }}>

        <h1 className="title-glow">Clasificación de Atletas</h1>

        {/* Controles superiores (Boton Crear) */}
        <div className="header-controls">
          <button className="btn-primary" onClick={abrirModalCrear}>
            + Añadir Nuevo Atleta
          </button>
        </div>

        {cargando ? (
          <div className="loading">⏳ Cargando datos desde Spring Boot...</div>
        ) : atletas.length === 0 ? (
          <div className="no-data">❌ No hay atletas registrados en la base de datos.</div>
        ) : (
          <div className="atletas-container">
            {atletas.map((atleta, index) => {
              const listaResultados = atleta.resultados || atleta.resultado;
              const res = (listaResultados && listaResultados.length > 0) ? listaResultados[0] : null;

              return (
                <div key={atleta.id || index} className="atleta-card">

                  {/* BOTONES CRUD ACCIONES RÁPIDAS */}
                  <div className="card-actions">
                    <button className="btn-edit" onClick={() => abrirModalEditar(atleta)}>Editar</button>
                    <button className="btn-edit" style={{background: '#0ea5e9'}} onClick={() => abrirModalResultados(atleta)}>Resultados</button>
                    <button className="btn-danger" onClick={() => eliminarAtleta(atleta.id)}>✖</button>
                  </div>

                  <div className="atleta-header">
                    <h2 className="atleta-name">{atleta.name}</h2>
                    <span className="atleta-categoria">{atleta.categoria}</span>
                  </div>

                  {res ? (
                    <div className="atleta-body">
                      <div className="resultados-title">📊 Resultados Oficiales</div>
                      <div className="scores-grid">
                        <div className="score-item">
                          <span className="score-label">Boulder</span>
                          <span className="score-value">{res.pts_boulder} <span>pts</span></span>
                        </div>
                        <div className="score-item">
                          <span className="score-label">Lead</span>
                          <span className="score-value">{res.pts_lead} <span>pts</span></span>
                        </div>
                        <div className="score-item" style={{ gridColumn: 'span 2' }}>
                          <span className="score-label">Velocidad (Speed)</span>
                          <span className="score-value speed">
                            {res.tiempo_speed}s <span style={{ marginLeft: '8px', color: '#cbd5e1' }}>({res.pts_speed_calc} pts)</span>
                          </span>
                        </div>
                      </div>
                      <div className="score-total">
                        <span className="total-label">Puntaje Total</span>
                        <span className="total-value">{res.total_acumulado}</span>
                      </div>
                    </div>
                  ) : (
                    <div className="no-data" style={{ padding: '20px', marginTop: '10px', fontSize: '1rem', width: '100%' }}>
                      Resultados no registrados.
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        )}
      </header>
    </div>
  );
}

export default App;
