/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: false,
  eslint: {
    // Warning: This allows production builds to successfully complete even if
    // your project has ESLint errors.
    ignoreDuringBuilds: true,
  },
  typescript: {
    // !! WARN !!
    // Dangerously allow production builds to successfully complete even if
    // your project has type errors.
    ignoreBuildErrors: true,
  },
  // Fix for 3D libraries (Maath/Three) causing build crashes
  transpilePackages: ['three', '@react-three/fiber', '@react-three/drei', 'maath'],
}

module.exports = nextConfig
