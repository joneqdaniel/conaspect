	.file	"conaspect.c"
	.text
	.section	.rodata.main.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"MODE: %dx%d %d:%d CONSOLE: %dx%d SCALE: %fx%f\n"
	.align 8
.LC2:
	.ascii	"Usage: %s <width> <height> [scale]...\nCalculate aspect rati"
	.ascii	"o and kernel console para"
	.string	"meters.\n\n  <width>  - integer screen width\n  <height> - integer screen height\n  [col scale]  - optional floating point column multiplier\n  [row scale]  - optional floating point row multiplier\n\nExamples:\n%s 1920 1080\n%s 1920 1080 2.0\n%s 1920 1080 1.0 2.0\n\n"
	.section	.text.startup.main,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB57:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$32, %rsp
	.cfi_def_cfa_offset 80
	cmpl	$2, %edi
	jg	.L16
	movq	(%rsi), %rcx
	pushq	%rax
	.cfi_def_cfa_offset 88
	xorl	%eax, %eax
	leaq	.LC2(%rip), %rdx
	movq	stderr(%rip), %rdi
	movl	$1, %esi
	pushq	%rcx
	.cfi_def_cfa_offset 96
	movq	%rcx, %r9
	movq	%rcx, %r8
	call	__fprintf_chk@PLT
	popq	%rdx
	.cfi_def_cfa_offset 88
	xorl	%edi, %edi
	popq	%rcx
	.cfi_def_cfa_offset 80
.L7:
	xorl	$1, %edi
	movzbl	%dil, %edi
	call	exit@PLT
.L16:
	movl	%edi, %r13d
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	__isoc23_strtol@PLT
	movq	16(%r12), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	movq	%rax, %rbx
	movl	%eax, %ebp
	call	__isoc23_strtol@PLT
	movq	%rax, %r8
	movl	%eax, %r14d
	movl	%ebx, %eax
	movl	%r8d, %ecx
	testl	%r8d, %r8d
	jne	.L3
	jmp	.L17
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L18:
	movl	%edx, %ecx
.L3:
	cltd
	idivl	%ecx
	movl	%ecx, %eax
	testl	%edx, %edx
	jne	.L18
.L6:
	movl	%ecx, %eax
	sarl	$31, %eax
	xorl	%eax, %ecx
	subl	%eax, %ecx
	cmpl	$3, %r13d
	jne	.L4
	vmovss	.LC0(%rip), %xmm3
	vmovaps	%xmm3, %xmm1
.L5:
	movl	%r8d, %eax
	sarl	$3, %ebx
	vunpcklps	%xmm1, %xmm3, %xmm4
	pushq	%rsi
	.cfi_def_cfa_offset 88
	sarl	$4, %eax
	vmovd	%ebx, %xmm5
	vmovq	%xmm4, %xmm4
	movl	$1, %esi
	vpinsrd	$1, %eax, %xmm5, %xmm2
	movl	%ebp, %eax
	vcvtss2sd	%xmm3, %xmm3, %xmm0
	vcvtss2sd	%xmm1, %xmm1, %xmm1
	cltd
	vmovq	%xmm2, %xmm2
	movq	stdout(%rip), %rdi
	idivl	%ecx
	vcvtdq2ps	%xmm2, %xmm2
	vmovq	%xmm2, %xmm2
	xorl	%ecx, %ecx
	vmulps	%xmm4, %xmm2, %xmm2
	vmovq	%xmm2, %xmm2
	vcvttps2dq	%xmm2, %xmm2
	movl	%eax, %r9d
	vpextrd	$1, %xmm2, %eax
	pushq	%rax
	.cfi_def_cfa_offset 96
	movl	%r14d, %eax
	cltd
	idivl	%ecx
	leaq	-8(%rsp), %rsp
	.cfi_def_cfa_offset 104
	movl	%ebp, %ecx
	leaq	.LC1(%rip), %rdx
	vmovd	%xmm2, (%rsp)
	pushq	%rax
	.cfi_def_cfa_offset 112
	movl	$2, %eax
	call	__fprintf_chk@PLT
	addq	$32, %rsp
	.cfi_def_cfa_offset 80
	movl	$1, %edi
	jmp	.L7
.L4:
	movq	24(%r12), %rdi
	xorl	%esi, %esi
	movq	%r8, 16(%rsp)
	movl	%ecx, 12(%rsp)
	call	strtof@PLT
	cmpl	$4, %r13d
	movl	12(%rsp), %ecx
	movq	16(%rsp), %r8
	vmovaps	%xmm0, %xmm3
	je	.L9
	movq	32(%r12), %rdi
	xorl	%esi, %esi
	movq	%r8, 24(%rsp)
	vmovss	%xmm0, 16(%rsp)
	call	strtof@PLT
	movl	12(%rsp), %ecx
	vmovss	16(%rsp), %xmm3
	movq	24(%rsp), %r8
	vmovaps	%xmm0, %xmm1
	jmp	.L5
.L9:
	vmovss	.LC0(%rip), %xmm1
	jmp	.L5
.L17:
	movl	%ebx, %ecx
	jmp	.L6
	.cfi_endproc
.LFE57:
	.size	main, .-main
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC0:
	.long	1065353216
	.ident	"GCC: (Gentoo 15.2.1_p20260418 p5) 15.2.1 20260418"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
