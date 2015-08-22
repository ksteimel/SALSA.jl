using MAT, SALSA, Base.Test, MLBase

ripley = matread(joinpath(Pkg.dir("SALSA"),"data","ripley.mat"))

srand(1234)
model = salsa(NONLINEAR,PEGASOS,HINGE,ripley["X"],ripley["Y"],ripley["Xt"])
@test_approx_eq_eps mean(ripley["Yt"] .== model.output.Ytest) 0.89 0.01

srand(1234)
model = SALSAModel(NONLINEAR,PEGASOS(),LOGISTIC,global_opt=DS([-1,-1,1]),kernel=PolynomialKernel)
model = salsa(ripley["X"],ripley["Y"],model,ripley["Xt"])
@test_approx_eq_eps mean(ripley["Yt"] .== model.output.Ytest) 0.895 0.01

srand(1234)
model = SALSAModel(NONLINEAR,PEGASOS(),LOGISTIC,global_opt=DS([-1]),kernel=LinearKernel)
model = salsa(ripley["X"],ripley["Y"],model,ripley["Xt"])
@test_approx_eq_eps mean(ripley["Yt"] .== model.output.Ytest) 0.89 0.01

srand(1234)
model = SALSAModel(NONLINEAR,DROP_OUT(),HINGE,global_opt=DS([-5,1]))
model = salsa(ripley["X"],ripley["Y"],model,ripley["Xt"])
@test_approx_eq_eps mean(ripley["Yt"] .== model.output.Ytest) 0.88 0.02

srand(1234)
model = SALSAModel(NONLINEAR,L1RDA(),HINGE,global_opt=DS([-5,0,0,1]))
model = salsa(ripley["X"],ripley["Y"],model,ripley["Xt"])
@test_approx_eq_eps mean(ripley["Yt"] .== model.output.Ytest) 0.89 0.01

srand(1234)
model = SALSAModel(NONLINEAR,ADA_L1RDA(),HINGE,global_opt=DS([-5,0,0,1]))
model = salsa(ripley["X"],ripley["Y"],model,ripley["Xt"])
@test_approx_eq_eps mean(ripley["Yt"] .== model.output.Ytest) 0.88 0.02