/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: false,
  eslint: { ignoreDuringBuilds: true },
  typescript: { ignoreBuildErrors: true },
  transpilePackages: ['three', '@react-three/fiber', '@react-three/drei', 'maath']
}

module.exports = nextConfig
