<?php

namespace App\Controller;

use App\Entity\Commande;
use App\Repository\MenuRepository;
use App\Repository\CommandeRepository;
use Doctrine\ODM\MongoDB\DocumentManager;
use Doctrine\ORM\EntityManagerInterface;
use App\Document\Avis;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin')]
#[IsGranted('ROLE_ADMIN')]
class AdminController extends AbstractController
{
    #[Route('', name: 'admin_dashboard')]
    public function dashboard(
        MenuRepository $menuRepo,
        DocumentManager $dm
    ): Response {
        $totalMenus = count($menuRepo->findAll());
        $menusDisponibles = count(array_filter(
            $menuRepo->findAll(),
            fn($m) => $m->getQuantiteRestante() > 0
        ));
        $menus = $menuRepo->findAll();
        $statsByTheme = [];
        foreach ($menus as $menu) {
            $theme = $menu->getTheme() ?? 'classique';
            if (!isset($statsByTheme[$theme])) {
                $statsByTheme[$theme] = ['count' => 0, 'prixMoyen' => 0, 'total' => 0];
            }
            $statsByTheme[$theme]['count']++;
            $statsByTheme[$theme]['total'] += (float) $menu->getPrix();
        }
        foreach ($statsByTheme as $theme => &$stats) {
            $stats['prixMoyen'] = round($stats['total'] / $stats['count'], 2);
        }
        try {
    $avisEnAttente = $dm->getRepository(Avis::class)->findBy(['statut' => 'en_attente']);
    $totalAvis = count($dm->getRepository(Avis::class)->findAll());
} catch (\Throwable $e) {
    $avisEnAttente = [];
    $totalAvis = 0;
}
        $chartLabels = array_map('ucfirst', array_keys($statsByTheme));
        $chartData   = array_column(array_values($statsByTheme), 'count');
        $chartPrix   = array_column(array_values($statsByTheme), 'prixMoyen');
        return $this->render('admin/dashboard.html.twig', [
            'totalMenus'       => $totalMenus,
            'menusDisponibles' => $menusDisponibles,
            'avisEnAttente'    => count($avisEnAttente),
            'totalAvis'        => $totalAvis,
            'statsByTheme'     => $statsByTheme,
            'chartLabels'      => json_encode($chartLabels),
            'chartData'        => json_encode($chartData),
            'chartPrix'        => json_encode($chartPrix),
        ]);
    }

    #[Route('/commandes', name: 'admin_commandes')]
    public function commandes(CommandeRepository $commandeRepo): Response
    {
        $commandes = $commandeRepo->findBy([], ['dateCommande' => 'DESC']);
        return $this->render('admin/commandes.html.twig', [
            'commandes' => $commandes,
        ]);
    }

    #[Route('/commandes/{id}/statut', name: 'admin_commande_statut', methods: ['POST'])]
    public function changerStatut(
        Commande $commande,
        Request $request,
        EntityManagerInterface $em
    ): Response {
        $nouveauStatut = $request->request->get('statut');
        $statutsValides = ['en_attente', 'confirmée', 'livrée', 'annulée'];
        if (in_array($nouveauStatut, $statutsValides)) {
            $commande->setStatut($nouveauStatut);
            $em->flush();
            $this->addFlash('success', 'Statut mis à jour : ' . $nouveauStatut);
        } else {
            $this->addFlash('danger', 'Statut invalide.');
        }
        return $this->redirectToRoute('admin_commandes');
    }
}
