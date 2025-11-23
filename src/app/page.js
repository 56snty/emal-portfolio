'use client'
import { useRef, useState } from 'react'
import { Canvas, useFrame } from '@react-three/fiber'
import { Points, PointMaterial, Float } from '@react-three/drei'
import * as random from 'maath/random/dist/maath-random.esm'
import { ReactLenis } from '@studio-freight/lenis/react'
import { Syne, Manrope } from 'next/font/google'
import { EffectComposer, Bloom, Noise } from '@react-three/postprocessing'

const syne = Syne({ subsets: ['latin'], weight: ['400', '700', '800'] })
const manrope = Manrope({ subsets: ['latin'] })

function StarField() {
  const ref = useRef()
  const [sphere] = useState(() => random.inSphere(new Float32Array(24000), { radius: 1.5 }))
  useFrame((state, delta) => {
    ref.current.rotation.x -= delta / 10
    ref.current.rotation.y -= delta / 15
    ref.current.scale.z = 1 + Math.sin(state.clock.elapsedTime * 0.5) * 0.1
  })
  return (
    <group rotation={[0, 0, Math.PI / 4]}>
      <Points ref={ref} positions={sphere} stride={3} frustumCulled={false}>
        <PointMaterial transparent color="#ff3333" size={0.003} sizeAttenuation={true} depthWrite={false} blending={2} />
      </Points>
    </group>
  )
}

export default function Home() {
  return (
    <ReactLenis root options={{ lerp: 0.05, duration: 1.5, smoothTouch: true }}>
      <main className={`${manrope.className} bg-black text-white min-h-screen relative`}>
        <div className="fixed top-0 left-0 w-full h-full z-0 pointer-events-none">
          <Canvas camera={{ position: [0, 0, 1] }}>
            <color attach="background" args={['#050505']} />
            <Float speed={2} rotationIntensity={1} floatIntensity={1}>
              <StarField />
            </Float>
            <EffectComposer>
              <Bloom luminanceThreshold={0.1} intensity={1.5} radius={0.5} />
              <Noise opacity={0.05} />
            </EffectComposer>
          </Canvas>
        </div>

        <nav className="fixed top-0 left-0 w-full p-8 flex justify-between items-center z-50 mix-blend-difference">
          <div className={`${syne.className} text-xl font-bold`}>EMAL</div>
          <div className="text-xs tracking-widest uppercase opacity-70">System Online</div>
        </nav>

        <div className="relative z-10">
          <section className="h-screen flex flex-col justify-center items-center p-4">
            <h2 className={`${syne.className} text-red-500 text-xs md:text-lg tracking-[0.5em] uppercase mb-4`}>Creative Developer</h2>
            <h1 className={`${syne.className} text-7xl md:text-[10rem] font-extrabold leading-none tracking-tighter text-transparent bg-clip-text bg-gradient-to-b from-white to-transparent`}>EMAL</h1>
            <p className="mt-8 text-gray-400 text-sm uppercase tracking-widest">Scroll to Explore</p>
          </section>

          <section className="min-h-screen flex items-center justify-end px-6 md:px-24 py-20">
            <div className="max-w-2xl text-right">
              <h2 className={`${syne.className} text-5xl md:text-8xl font-bold mb-8`}>THE <span className="text-red-500">CORE</span></h2>
              <div className="border-r-2 border-red-500 pr-8 py-4">
                <p className="text-xl md:text-3xl font-light leading-relaxed text-gray-300">"I don't build websites. I build ecosystems. Using <span className="text-red-500 font-bold">React</span>, <span className="text-red-500 font-bold">WebGL</span>, and <span className="text-red-500 font-bold">Next.js</span>."</p>
              </div>
            </div>
          </section>

          <section className="min-h-screen px-6 md:px-24 py-20">
            <h2 className={`${syne.className} text-5xl md:text-8xl font-bold mb-20`}>SELECTED <span className="text-red-500">WORK</span></h2>
            <div className="space-y-32">
              <div className="border-t border-white/10 pt-8">
                <h3 className={`${syne.className} text-4xl md:text-6xl font-bold mb-2 hover:text-red-500 transition-colors`}>NEBULA</h3>
                <p className="text-gray-500 uppercase tracking-widest">Three.js / Physics Simulation</p>
              </div>
              <div className="border-t border-white/10 pt-8">
                <h3 className={`${syne.className} text-4xl md:text-6xl font-bold mb-2 hover:text-red-500 transition-colors`}>VOID</h3>
                <p className="text-gray-500 uppercase tracking-widest">E-Commerce / Raymarching</p>
              </div>
            </div>
          </section>

          <section className="h-[50vh] flex flex-col justify-center items-center text-center">
            <h2 className={`${syne.className} text-4xl md:text-7xl font-bold mb-8`}>LET'S <span className="text-red-500">TALK</span></h2>
            <a href="mailto:emal@dev.com" className="px-8 py-3 border border-red-500 text-red-500 rounded-full hover:bg-red-500 hover:text-white transition-all uppercase tracking-widest text-sm">emal@student.cs</a>
          </section>
        </div>
      </main>
    </ReactLenis>
  )
}
