/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: _coder_jacobian_fcn_api.h
 *
 * MATLAB Coder version            : 5.3
 * C/C++ source code generated on  : 21-Jun-2022 12:59:19
 */

#ifndef _CODER_JACOBIAN_FCN_API_H
#define _CODER_JACOBIAN_FCN_API_H

/* Include Files */
#include "emlrt.h"
#include "tmwtypes.h"
#include <string.h>

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

#ifdef __cplusplus
extern "C" {
#endif

/* Function Declarations */
void jacobian_fcn(real_T q_1, real_T q_2, real_T q_3, real_T q_4, real_T q_5,
                  real_T Jacobi_camera[36]);

void jacobian_fcn_api(const mxArray *const prhs[5], const mxArray **plhs);

void jacobian_fcn_atexit(void);

void jacobian_fcn_initialize(void);

void jacobian_fcn_terminate(void);

void jacobian_fcn_xil_shutdown(void);

void jacobian_fcn_xil_terminate(void);

#ifdef __cplusplus
}
#endif

#endif
/*
 * File trailer for _coder_jacobian_fcn_api.h
 *
 * [EOF]
 */
