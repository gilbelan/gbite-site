// Configuração do Particles.js
document.addEventListener('DOMContentLoaded', function() {
    particlesJS("particles-js", {
        "particles": {
        "number": {
            "value": 80,
            "density": {
            "enable": true,
            "value_area": 800
            }
        },
        "color": {
            "value": "#0ff0e6"
        },
        "shape": {
            "type": "circle",
            "stroke": {
            "width": 0,
            "color": "#000000"
            },
            "polygon": {
            "nb_sides": 5
            }
        },
        "opacity": {
            "value": 0.5,
            "random": true,
            "anim": {
            "enable": true,
            "speed": 1,
            "opacity_min": 0.1,
            "sync": false
            }
        },
        "size": {
            "value": 3,
            "random": true,
            "anim": {
            "enable": true,
            "speed": 2,
            "size_min": 0.1,
            "sync": false
            }
        },
        "line_linked": {
            "enable": true,
            "distance": 150,
            "color": "#ffffff",
            "opacity": 0.4,
            "width": 1
        },
        "move": {
            "enable": true,
            "speed": 2,
            "direction": "none",
            "random": true,
            "straight": false,
            "out_mode": "out",
            "bounce": false,
            "attract": {
            "enable": false,
            "rotateX": 600,
            "rotateY": 1200
            }
        }
        },
        "interactivity": {
        "detect_on": "canvas",
        "events": {
            "onhover": {
            "enable": true,
            "mode": "grab"
            },
            "onclick": {
            "enable": true,
            "mode": "push"
            },
            "resize": true
        },
        "modes": {
            "grab": {
            "distance": 140,
            "line_linked": {
                "opacity": 1
            }
            },
            "push": {
            "particles_nb": 4
            }
        }
        },
        "retina_detect": true
    });
});

// Efeito de Scroll suave
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        
        const target = document.querySelector(this.getAttribute('href'));
        if(target) {
            target.scrollIntoView({
                behavior: 'smooth'
            });
        }
    });
});

// Função para alternar o menu
function toggleMenu() {
    const navLinks = document.querySelector('.nav-links');
    navLinks.classList.toggle('active');
}

// Animação de entrada dos cards
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver(function(entries) {
    entries.forEach(entry => {
        if(entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Aplicar animação aos cards quando a página carregar
window.addEventListener('load', function() {
    const cards = document.querySelectorAll('.team-card, .value-card');
    cards.forEach((card, index) => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(30px)';
        card.style.transition = `all 0.5s ease ${index * 0.1}s`;
        observer.observe(card);
    });
});

