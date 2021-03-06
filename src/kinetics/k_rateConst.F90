module k_rateConst
!--------------------------------------------------------
! k rate constants for 3component chemistry
!--------------------------------------------------------

!  use ccpp_kinds, only: r8 => kind_phys
  use ccpp_kinds, only:  kind_phys
  use rate_constants_utility, only: k_rate_constant

implicit none
private

public :: k_rateConst_run

! k_rateConst are computed at the beginning of the 
!   chemistry_box_solver time step.
!   They are not computed for internal steps of the
!   box-model time-step advancer
! k_rateConst will be thread-safe memory provided elsewhere.
! rate_constant_store will be an accessor to memory
! For now, it is allocated here. It is not thread safe

contains

  !---------------------------
  ! Compute k_rateConst, given M, P, T
  ! Execute once for the chemistry-time-step advance
  !---------------------------
!> \section arg_table_k_rateConst_run Argument Table
!! \htmlinclude k_rateConst_run.html
!!
  subroutine k_rateConst_run(nkRxt, njRxt, k_rateConst, nd_air, rh, c_h2o, c_o2, temp, p, sad, ad, errmsg, errflg)
  
    integer,                   intent(in)  :: nkRxt
    integer,                   intent(in)  :: njRxt  !!!! THIS IS ONLY HERE TO WORKAROUND A BUG IN CPF
    real(kind_phys),           intent(out) :: k_rateConst(:)
    real(kind_phys),           intent(in)  :: nd_air
    real(kind_phys),           intent(in)  :: rh 
    real(kind_phys),           intent(in)  :: c_h2o     
    real(kind_phys),           intent(in)  :: c_o2
    real(kind_phys),           intent(in)  :: temp

    real(kind_phys),           intent(in)  :: p
    real(kind_phys),           intent(in)  :: sad(:)
    real(kind_phys),           intent(in)  :: ad(:)

    character(len=512), intent(out) :: errmsg
    integer,            intent(out) :: errflg


    ! retrieve the temperature used by tuv (the photolysis level)

    errmsg=''
    errflg=0

    call k_rate_constant(k_rateConst, nd_air, temp, p, sad, ad, c_h2o, c_o2 )

  end subroutine k_rateConst_run
  

! number of Functions: 1



end module k_rateConst
