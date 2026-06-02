
ssa_c5_internal_fp_arg.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	cvtsi2sd	%r9, %xmm7
               	movq	%r11, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	cvtsi2sd	%r9, %xmm7
               	movq	%r11, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setbe	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movslq	%edi, %r11
               	movq	%rsi, %r9
               	movq	%r11, %r9
               	addq	$0x64, %r9
               	movslq	%r9d, %r9
               	subq	%r11, %r9
               	movslq	%r9d, %r9
               	movabsq	$0x4049400000000000, %r8 # imm = 0x4049400000000000
               	movq	%r11, %r10
               	subq	%r10, %r11
               	movslq	%r11d, %r11
               	cvtsi2sd	%r11, %xmm7
               	movq	%r8, %xmm6
               	addsd	%xmm7, %xmm6
               	movq	%xmm6, %r11
               	movq	%r11, -0x10(%rbp)
               	movq	-0x10(%rbp), %r8
               	cvtsi2sd	%r9, %xmm6
               	movq	%r8, %xmm14
               	ucomisd	%xmm6, %xmm14
               	setb	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x1, %r8
               	je	<addr>
               	movl	$0x1, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4062d00000000000, %r8 # imm = 0x4062D00000000000
               	cvtsi2sd	%r9, %xmm6
               	movq	%r8, %xmm14
               	ucomisd	%xmm6, %xmm14
               	setb	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x2, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cvtsi2sd	%r9, %xmm6
               	movq	%xmm6, %r11
               	movq	%r11, -0x38(%rbp)
               	movq	-0x38(%rbp), %r8
               	cvtsi2sd	%r9, %xmm6
               	movq	%r8, %xmm14
               	ucomisd	%xmm6, %xmm14
               	setbe	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x1, %r8
               	je	<addr>
               	movl	$0x3, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cvtsi2sd	%r9, %xmm6
               	movabsq	$0x3fe0000000000000, %r8 # imm = 0x3FE0000000000000
               	movq	%r8, %xmm15
               	addsd	%xmm15, %xmm6
               	movq	%xmm6, %r11
               	movq	%r11, -0x40(%rbp)
               	movq	-0x40(%rbp), %r8
               	cvtsi2sd	%r9, %xmm6
               	movq	%r8, %xmm14
               	ucomisd	%xmm6, %xmm14
               	setbe	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
