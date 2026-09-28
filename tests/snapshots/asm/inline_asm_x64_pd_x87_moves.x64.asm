
inline_asm_x64_pd_x87_moves.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<packed_double_moves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax
               	movapd	<rip>, %xmm1
               	movapd	%xmm1, %xmm2
               	movapd	%xmm2, <rip>
               	movsd	(%rax), %xmm0
               	movabsq	$0x3ff4000000000000, %rax # imm = 0x3FF4000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsd	0x8(%rax), %xmm0
               	movabsq	$-0x3ff4000000000000, %rax # imm = 0xC00C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	0x18(%rax), %rsi
               	movupd	<rip>, %xmm3
               	movupd	%xmm3, %xmm4
               	movupd	%xmm4, <rip>
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rax), %xmm0
               	movabsq	$0x3ff4000000000000, %rcx # imm = 0x3FF4000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rax), %xmm0
               	movabsq	$-0x3ff4000000000000, %rax # imm = 0xC00C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>

<x87_constants>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x38(%rbp), %rax
               	fld1
               	fstpl	(%rax)
               	leaq	-0x30(%rbp), %rax
               	fldz
               	fstpl	(%rax)
               	leaq	-0x28(%rbp), %rax
               	fldpi
               	fstpl	(%rax)
               	leaq	-0x20(%rbp), %rax
               	fldl2t
               	fstpl	(%rax)
               	leaq	-0x18(%rbp), %rax
               	fldl2e
               	fstpl	(%rax)
               	leaq	-0x10(%rbp), %rax
               	fldlg2
               	fstpl	(%rax)
               	leaq	-0x8(%rbp), %rax
               	fldln2
               	fstpl	(%rax)
               	movsd	-0x38(%rbp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x30(%rbp), %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movsd	-0x28(%rbp), %xmm0
               	movabsq	$0x400921fb54442d18, %rcx # imm = 0x400921FB54442D18
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm0
               	movabsq	$0x3cbcd2b297d889bc, %rax # imm = 0x3CBCD2B297D889BC
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm1
               	mulsd	%xmm15, %xmm1
               	ucomisd	%xmm0, %xmm1
               	jb	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jb	<addr>
               	movsd	-0x20(%rbp), %xmm0
               	movabsq	$0x400a934f0979a371, %rcx # imm = 0x400A934F0979A371
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm1
               	mulsd	%xmm15, %xmm1
               	ucomisd	%xmm0, %xmm1
               	jb	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jb	<addr>
               	movsd	-0x18(%rbp), %xmm0
               	movabsq	$0x3ff71547652b82fe, %rcx # imm = 0x3FF71547652B82FE
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm1
               	mulsd	%xmm15, %xmm1
               	ucomisd	%xmm0, %xmm1
               	jb	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jb	<addr>
               	movsd	-0x10(%rbp), %xmm0
               	movabsq	$0x3fd34413509f79ff, %rcx # imm = 0x3FD34413509F79FF
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm1
               	mulsd	%xmm15, %xmm1
               	ucomisd	%xmm0, %xmm1
               	jb	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3cbcd2b297d889bc, %rax # imm = 0x3CBCD2B297D889BC
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm1
               	mulsd	%xmm15, %xmm1
               	ucomisd	%xmm0, %xmm1
               	jb	<addr>
               	movsd	-0x8(%rbp), %xmm0
               	movabsq	$0x3fe62e42fefa39ef, %rax # imm = 0x3FE62E42FEFA39EF
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	movabsq	$0x3cbcd2b297d889bc, %rcx # imm = 0x3CBCD2B297D889BC
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm1
               	mulsd	%xmm15, %xmm1
               	ucomisd	%xmm0, %xmm1
               	jb	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jae	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

<x87_widths>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%rbx
               	movl	$0x40200000, %edx       # imm = 0x40200000
               	movq	%rdx, %xmm14
               	movss	%xmm14, -0x38(%rbp)
               	movl	$0x0, -0x30(%rbp)
               	movl	$0x0, -0x28(%rbp)
               	movabsq	$-0x4018000000000000, %rcx # imm = 0xBFE8000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x20(%rbp)
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x10(%rbp), %rbx
               	leaq	-0x38(%rbp), %rcx
               	flds	(%rcx)
               	fsts	(%rax)
               	fstpl	(%rbx)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x28(%rbp), %rbx
               	leaq	-0x20(%rbp), %rcx
               	fldl	(%rcx)
               	fstl	(%rax)
               	fstps	(%rbx)
               	movss	-0x30(%rbp), %xmm0
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x10(%rbp), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x18(%rbp), %xmm0
               	movabsq	$-0x4018000000000000, %rax # imm = 0xBFE8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x28(%rbp), %xmm0
               	movl	$0xbf400000, %eax       # imm = 0xBF400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movzwq	0x8(%rcx), %r10
               	movw	%r10w, 0x8(%rax)
               	movq	$0x0, -0x8(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	movl	$0xaa, %esi
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x58(%rbp), %rax
               	leaq	-0x68(%rbp), %rbx
               	fldt	(%rbx)
               	fstpt	(%rax)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x68(%rbp), %rbx
               	fldt	(%rbx)
               	fstpl	(%rax)
               	leaq	-0x48(%rbp), %rax
               	fld1
               	fstpt	(%rax)
               	leaq	-0x58(%rbp), %rdi
               	leaq	-0x68(%rbp), %rsi
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsd	-0x8(%rbp), %xmm0
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	-0x48(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	popq	%rbp
               	retq
