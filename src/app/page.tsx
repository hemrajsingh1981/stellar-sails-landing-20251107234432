import Image from 'next/image';

export default function HomePage() {
  return (
    <main className="relative min-h-screen w-full">
      <section
        id="hero-section"
        className="relative flex items-center justify-center bg-cover bg-center"
        style={{
          backgroundImage: `url('/images/hero-spaceship-planet.webp')`,
          minHeight: '100vh',
        }}
      >
        <div className="absolute inset-0 bg-black opacity-50"></div>
        <div className="relative z-10 text-center text-white p-8">
          <h1 className="text-5xl md:text-7xl font-bold mb-4">Welcome to Stellar Sails</h1>
          <p className="text-xl md:text-2xl mb-8">Luxury Space Tourism Redefined</p>
          <div className="flex justify-center mb-8">
            <Image
              src="/images/logo.svg"
              alt="Stellar Sails Logo"
              width={150}
              height={150}
              priority
            />
          </div>
          <button className="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
            Explore Destinations
          </button>
        </div>
      </section>
    </main>
  );
}
