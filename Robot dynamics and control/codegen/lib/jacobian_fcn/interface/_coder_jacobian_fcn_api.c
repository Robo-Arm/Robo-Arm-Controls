/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: _coder_jacobian_fcn_api.c
 *
 * MATLAB Coder version            : 5.3
 * C/C++ source code generated on  : 21-Jun-2022 12:59:19
 */

/* Include Files */
#include "_coder_jacobian_fcn_api.h"
#include "_coder_jacobian_fcn_mex.h"

/* Variable Definitions */
emlrtCTX emlrtRootTLSGlobal = NULL;

emlrtContext emlrtContextGlobal = {
    true,                                                 /* bFirstTime */
    false,                                                /* bInitialized */
    131611U,                                              /* fVersionInfo */
    NULL,                                                 /* fErrorFunction */
    "jacobian_fcn",                                       /* fFunctionName */
    NULL,                                                 /* fRTCallStack */
    false,                                                /* bDebugMode */
    {2045744189U, 2170104910U, 2743257031U, 4284093946U}, /* fSigWrd */
    NULL                                                  /* fSigMem */
};

/* Function Declarations */
static real_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId);

static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                 const emlrtMsgIdentifier *msgId);

static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *q_1,
                               const char_T *identifier);

static const mxArray *emlrt_marshallOut(const real_T u[36]);

/* Function Definitions */
/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : real_T
 */
static real_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = c_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : real_T
 */
static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                 const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  real_T ret;
  emlrtCheckBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                          false, 0U, (void *)&dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *q_1
 *                const char_T *identifier
 * Return Type  : real_T
 */
static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *q_1,
                               const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  real_T y;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(q_1), &thisId);
  emlrtDestroyArray(&q_1);
  return y;
}

/*
 * Arguments    : const real_T u[36]
 * Return Type  : const mxArray *
 */
static const mxArray *emlrt_marshallOut(const real_T u[36])
{
  static const int32_T iv[2] = {0, 0};
  static const int32_T iv1[2] = {6, 6};
  const mxArray *m;
  const mxArray *y;
  y = NULL;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, (void *)&u[0]);
  emlrtSetDimensions((mxArray *)m, &iv1[0], 2);
  emlrtAssign(&y, m);
  return y;
}

/*
 * Arguments    : const mxArray * const prhs[5]
 *                const mxArray **plhs
 * Return Type  : void
 */
void jacobian_fcn_api(const mxArray *const prhs[5], const mxArray **plhs)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  real_T(*Jacobi_camera)[36];
  real_T q_1;
  real_T q_2;
  real_T q_3;
  real_T q_4;
  real_T q_5;
  st.tls = emlrtRootTLSGlobal;
  Jacobi_camera = (real_T(*)[36])mxMalloc(sizeof(real_T[36]));
  /* Marshall function inputs */
  q_1 = emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "q_1");
  q_2 = emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "q_2");
  q_3 = emlrt_marshallIn(&st, emlrtAliasP(prhs[2]), "q_3");
  q_4 = emlrt_marshallIn(&st, emlrtAliasP(prhs[3]), "q_4");
  q_5 = emlrt_marshallIn(&st, emlrtAliasP(prhs[4]), "q_5");
  /* Invoke the target function */
  jacobian_fcn(q_1, q_2, q_3, q_4, q_5, *Jacobi_camera);
  /* Marshall function outputs */
  *plhs = emlrt_marshallOut(*Jacobi_camera);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void jacobian_fcn_atexit(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  jacobian_fcn_xil_terminate();
  jacobian_fcn_xil_shutdown();
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void jacobian_fcn_initialize(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, NULL);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void jacobian_fcn_terminate(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/*
 * File trailer for _coder_jacobian_fcn_api.c
 *
 * [EOF]
 */
