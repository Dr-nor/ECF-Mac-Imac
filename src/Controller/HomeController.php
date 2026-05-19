<?php
// src/Controller/HomeController.php
// ECF DWWM 2026 — Vite & Gourmand

namespace App\Controller;

use App\Repository\MenuRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class HomeController extends AbstractController
{
    #[Route('/', name: 'app_')]
    public function index(MenuRepository $menuRepository): Response
    {
        $menus = $menuRepository->findBy([], ['id' => 'ASC'], 3);

        return $this->render('home/index.html.twig', [
            'menus' => $menus,
        ]);
    }
    #[Route('/contact', name: 'app_contact')]
public function contact(): Response
{
    return $this->render('home/contact.html.twig');
}

#[Route('/horaires', name: 'app_horaires')]
public function horaires(): Response
{
    return $this->render('home/horaires.html.twig');
}
}