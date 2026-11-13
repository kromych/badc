
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movapd	<rip>, %xmm1 # <addr>
               	movapd	%xmm1, %xmm2
               	movapd	%xmm2, <rip> # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x3ff4000000000000, %rax # imm = 0x3FF4000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$-0x3ff4000000000000, %rax # imm = 0xC00C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	fld1
               	fstpl	(%rax)
               	leaq	-0x68(%rbp), %rax
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
               	leaq	-0x50(%rbp), %rax
               	fldln2
               	fstpl	(%rax)
               	movsd	-0x60(%rbp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x68(%rbp), %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x40200000, %esi       # imm = 0x40200000
               	movq	%rsi, %xmm14
               	movss	%xmm14, -0x60(%rbp)
               	movl	$0x0, -0x68(%rbp)
               	movl	$0x0, -0x28(%rbp)
               	movabsq	$-0x4018000000000000, %rcx # imm = 0xBFE8000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x20(%rbp)
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	leaq	-0x68(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	flds	(%rdx)
               	fsts	(%rax)
               	fstpl	(%rcx)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	fldl	(%rdx)
               	fstl	(%rax)
               	fstps	(%rcx)
               	movss	-0x68(%rbp), %xmm0
               	movq	%rsi, %xmm15
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
               	leave
               	retq
               	leaq	-0x58(%rbp), %rax
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movzwq	0x8(%rcx), %r10
               	movw	%r10w, 0x8(%rax)
               	movq	$0x0, -0x8(%rbp)
               	movabsq	$-0x5555555555555556, %rax # imm = 0xAAAAAAAAAAAAAAAA
               	movq	%rax, -0x48(%rbp)
               	movw	$0xaaaa, -0x40(%rbp)    # imm = 0xAAAA
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x58(%rbp), %rcx
               	fldt	(%rcx)
               	fstpt	(%rax)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x58(%rbp), %rcx
               	fldt	(%rcx)
               	fstpl	(%rax)
               	leaq	-0x38(%rbp), %rax
               	fld1
               	fstpt	(%rax)
               	leaq	-0x48(%rbp), %rdi
               	leaq	-0x58(%rbp), %rsi
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
               	leaq	-0x38(%rbp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movsd	-0x28(%rbp), %xmm0
               	movabsq	$0x400921fb54442d18, %rcx # imm = 0x400921FB54442D18
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm0
               	movabsq	$0x3cd6a3372f5d171b, %rcx # imm = 0x3CD6A3372F5D171B
               	movq	%rcx, %xmm15
               	comisd	%xmm0, %xmm15
               	jb	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	%rcx, %xmm15
               	comisd	%xmm0, %xmm15
               	jb	<addr>
               	movsd	-0x20(%rbp), %xmm0
               	movabsq	$0x400a934f0979a371, %rcx # imm = 0x400A934F0979A371
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm0
               	movabsq	$0x3cd7efe0307b33a5, %rcx # imm = 0x3CD7EFE0307B33A5
               	movq	%rcx, %xmm15
               	comisd	%xmm0, %xmm15
               	jb	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	%rcx, %xmm15
               	comisd	%xmm0, %xmm15
               	jb	<addr>
               	movsd	-0x18(%rbp), %xmm0
               	movabsq	$0x3ff71547652b82fe, %rcx # imm = 0x3FF71547652B82FE
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm0
               	movabsq	$0x3cc4ca9af0f3bece, %rcx # imm = 0x3CC4CA9AF0F3BECE
               	movq	%rcx, %xmm15
               	comisd	%xmm0, %xmm15
               	jb	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	%rcx, %xmm15
               	comisd	%xmm0, %xmm15
               	jb	<addr>
               	movsd	-0x10(%rbp), %xmm0
               	movabsq	$0x3fd34413509f79ff, %rcx # imm = 0x3FD34413509F79FF
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm0
               	movabsq	$0x3ca15a6b2b63ab5a, %rcx # imm = 0x3CA15A6B2B63AB5A
               	movq	%rcx, %xmm15
               	comisd	%xmm0, %xmm15
               	jb	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	%rcx, %xmm15
               	comisd	%xmm0, %xmm15
               	jb	<addr>
               	movsd	-0x50(%rbp), %xmm0
               	movabsq	$0x3fe62e42fefa39ef, %rcx # imm = 0x3FE62E42FEFA39EF
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm0
               	movabsq	$0x3cb3fa8601594afd, %rcx # imm = 0x3CB3FA8601594AFD
               	movq	%rcx, %xmm15
               	comisd	%xmm0, %xmm15
               	jb	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	%rcx, %xmm15
               	comisd	%xmm0, %xmm15
               	jae	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rcx
               	leaq	<rip>, %rdx # <addr>
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	addq	$0x18, %rax
               	movupd	<rip>, %xmm3 # <addr>
               	movupd	%xmm3, %xmm4
               	movupd	%xmm4, <rip> # <addr>
               	leaq	-0x68(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	-0x68(%rbp), %xmm0
               	movabsq	$0x3ff4000000000000, %rax # imm = 0x3FF4000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x60(%rbp), %xmm0
               	movabsq	$-0x3ff4000000000000, %rax # imm = 0xC00C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
