
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
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %r8
               	movq	(%rax), %rax
               	movq	%rax, (%r8)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cvtsi2sd	%rsi, %xmm7
               	movq	%rdi, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	retq
               	cvtsi2sd	%rsi, %xmm7
               	movq	%rdi, %xmm14
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
