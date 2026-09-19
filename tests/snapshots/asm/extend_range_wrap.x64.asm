
extend_range_wrap.x64:	file format elf64-x86-64

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

<wrap_up>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	testl	%edi, %edi
               	jle	<addr>
               	movslq	%edi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	incq	%rdi
               	testl	%edi, %edi
               	jg	<addr>
               	movl	%eax, (%rsi)
               	movq	%rcx, %rax
               	retq

<le_max>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%esi, %edi
               	jg	<addr>
               	movslq	%edi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	incq	%rdi
               	cmpl	%esi, %edi
               	jle	<addr>
               	movq	%rcx, %rax
               	retq

<ne_bound>:
               	xorl	%eax, %eax
               	cmpl	%esi, %edi
               	je	<addr>
               	movslq	%edi, %rcx
               	addq	%rcx, %rax
               	incq	%rdi
               	cmpl	%esi, %edi
               	jne	<addr>
               	retq

<step_var>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%esi, %edi
               	jge	<addr>
               	movslq	%edi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	addq	$0x4, %rdi
               	cmpl	%esi, %edi
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<wrap_down>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	testl	%edi, %edi
               	jge	<addr>
               	movslq	%edi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	decq	%rdi
               	testl	%edi, %edi
               	jl	<addr>
               	movl	%eax, (%rsi)
               	movq	%rcx, %rax
               	retq

<count_down>:
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	testl	%esi, %esi
               	jl	<addr>
               	movslq	(%rdi,%rsi,4), %rcx
               	addq	%rcx, %rax
               	decq	%rsi
               	testl	%esi, %esi
               	jge	<addr>
               	retq

<two_back_edges>:
               	movq	%rcx, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%esi, %edi
               	jge	<addr>
               	incq	%rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movq	%rax, %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rdi
               	jmp	<addr>
               	movslq	%edi, %rdx
               	addq	%rdx, %rcx
               	leaq	0x2(%rdx), %rdi
               	cmpl	%esi, %edi
               	jl	<addr>
               	movl	%edi, (%r8)
               	movq	%rcx, %rax
               	retq

<other_guard>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<guard_then_join>:
               	xorl	%eax, %eax
               	cmpl	$0x64, %edi
               	jge	<addr>
               	movl	$0x1, %eax
               	leaq	0x1(%rdi), %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	retq

<guarded>:
               	movslq	%edi, %rdi
               	xorl	%eax, %eax
               	cmpl	$0x64, %edi
               	jge	<addr>
               	leaq	0x1(%rdi), %rax
               	retq

<uwrap>:
               	xorl	%eax, %eax
               	movq	%rdi, %rcx
               	xorq	$0x2, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	%edi, %ecx
               	addq	%rcx, %rax
               	incq	%rdi
               	movq	%rdi, %rcx
               	xorq	$0x2, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	retq

<as_ulong>:
               	leaq	0x2(%rdi), %rax
               	movl	%eax, %eax
               	retq

<shr4>:
               	leaq	0x2(%rdi), %rax
               	movl	%eax, %eax
               	shrq	$0x4, %rax
               	retq

<div3>:
               	leaq	0x2(%rdi), %rax
               	movl	%eax, %eax
               	movl	$0xaaaaaaab, %r11d      # imm = 0xAAAAAAAB
               	imulq	%r11, %rax
               	shrq	$0x21, %rax
               	retq

<divv>:
               	leaq	0x2(%rdi), %rax
               	movl	%eax, %eax
               	movl	$0xaaaaaaab, %r11d      # imm = 0xAAAAAAAB
               	imulq	%r11, %rax
               	shrq	$0x21, %rax
               	retq

<modv>:
               	leaq	0x8(%rdi), %rax
               	movl	%eax, %eax
               	movl	$0x5, %ecx
               	movl	$0xcccccccd, %edx       # imm = 0xCCCCCCCD
               	imulq	%rax, %rdx
               	shrq	$0x22, %rdx
               	imulq	%rdx, %rcx
               	subq	%rcx, %rax
               	movl	%eax, %eax
               	retq

<less64>:
               	leaq	0x2(%rdi), %rax
               	movl	%eax, %eax
               	cmpq	$0x2, %rax
               	setl	%al
               	movzbq	%al, %rax
               	retq

<store8>:
               	leaq	0x2(%rdi), %rax
               	movl	%eax, %eax
               	movq	%rax, (%rdx)
               	retq

<pass>:
               	movq	%rdi, %rax
               	retq

<as_arg>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	0x2(%rdi), %rax
               	movl	%eax, %edi
               	popq	%rbp
               	jmp	<addr>

<index_of>:
               	leaq	0x2(%rsi), %rax
               	movl	%eax, %eax
               	movq	(%rdi,%rax,8), %rax
               	retq

<as_double>:
               	leaq	0x2(%rdi), %rax
               	movl	%eax, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	retq

<sum_nonzero>:
               	leaq	(%rdi,%rsi), %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<usum_nonzero>:
               	leaq	(%rdi,%rsi), %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<diff_zero>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	$0x9, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movl	$0x7fffffff, -0x38(%rbp) # imm = 0x7FFFFFFF
               	movl	$0x80000000, -0x30(%rbp) # imm = 0x80000000
               	movl	$0xffffffff, -0x28(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x80000000, -0x20(%rbp) # imm = 0x80000000
               	movl	$0x0, -0x18(%rbp)
               	movl	$0x0, -0x10(%rbp)
               	movslq	-0x38(%rbp), %rax
               	leaq	-0x2(%rax), %rdi
               	leaq	-0x18(%rbp), %rsi
               	callq	<addr>
               	movabsq	$0x17ffffffa, %r11      # imm = 0x17FFFFFFA
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movslq	-0x18(%rbp), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movslq	-0x38(%rbp), %rax
               	leaq	-0x1(%rax), %rdi
               	movslq	-0x38(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movslq	-0x38(%rbp), %rax
               	leaq	-0x1(%rax), %rdi
               	movslq	-0x30(%rbp), %rax
               	leaq	0x2(%rax), %rsi
               	callq	<addr>
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movslq	-0x38(%rbp), %rax
               	leaq	-0x5(%rax), %rdi
               	movslq	-0x38(%rbp), %rsi
               	movl	$0x4, %edx
               	movl	$0x3, %ecx
               	callq	<addr>
               	cmpq	$0x7ffffffa, %rax       # imm = 0x7FFFFFFA
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movslq	-0x30(%rbp), %rax
               	leaq	0x1(%rax), %rdi
               	leaq	-0x18(%rbp), %rsi
               	callq	<addr>
               	movabsq	$-0xffffffff, %r11      # imm = 0xFFFFFFFF00000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movslq	-0x18(%rbp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x10e1, %rax           # imm = 0x10E1
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	$-0x1, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movslq	-0x38(%rbp), %rax
               	leaq	-0x2(%rax), %rdi
               	movslq	-0x38(%rbp), %rsi
               	movl	$0x5, %edx
               	leaq	-0x10(%rbp), %rcx
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x80000003, %eax       # imm = 0x80000003
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movslq	-0x38(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movslq	-0x38(%rbp), %rdi
               	callq	<addr>
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	$0x63, %edi
               	callq	<addr>
               	cmpq	$0x64, %rax
               	jne	<addr>
               	movslq	-0x30(%rbp), %rdi
               	callq	<addr>
               	cmpq	$-0x7fffffff, %rax      # imm = 0x80000001
               	jne	<addr>
               	movslq	-0x38(%rbp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movl	-0x28(%rbp), %eax
               	decq	%rax
               	movl	%eax, %edi
               	callq	<addr>
               	movabsq	$0x1fffffffe, %r11      # imm = 0x1FFFFFFFE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movl	-0x28(%rbp), %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movl	-0x28(%rbp), %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movl	-0x28(%rbp), %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movl	-0x28(%rbp), %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movl	-0x28(%rbp), %edi
               	movl	$0x8, %esi
               	movl	$0x5, %edx
               	callq	<addr>
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movl	-0x28(%rbp), %edi
               	movl	$0x2, %esi
               	movq	%rsi, %rdx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movq	$-0x1, -0x8(%rbp)
               	movl	-0x28(%rbp), %edi
               	movl	$0x2, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movl	-0x28(%rbp), %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	-0x28(%rbp), %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movl	-0x28(%rbp), %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	movslq	-0x30(%rbp), %rdi
               	movslq	-0x30(%rbp), %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	movslq	-0x38(%rbp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	movl	-0x20(%rbp), %edi
               	movl	-0x20(%rbp), %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	movl	-0x20(%rbp), %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	movslq	-0x30(%rbp), %rdi
               	movslq	-0x30(%rbp), %rsi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movslq	-0x30(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
