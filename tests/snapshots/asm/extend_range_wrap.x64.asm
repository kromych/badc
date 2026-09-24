
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

<guard_then_join>:
               	movl	$0x7, %eax
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
               	subq	$0x30, %rsp
               	movl	$0x7fffffff, -0x28(%rbp) # imm = 0x7FFFFFFF
               	movl	$0x80000000, -0x20(%rbp) # imm = 0x80000000
               	movl	$0xffffffff, -0x18(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x80000000, -0x10(%rbp) # imm = 0x80000000
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
               	movslq	-0x20(%rbp), %rdi
               	callq	<addr>
               	cmpq	$-0x7fffffff, %rax      # imm = 0x80000001
               	jne	<addr>
               	movslq	-0x28(%rbp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %eax
               	leaq	-0x1(%rax), %rdi
               	callq	<addr>
               	movabsq	$0x1fffffffe, %r11      # imm = 0x1FFFFFFFE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %edi
               	movl	$0x8, %esi
               	movl	$0x5, %edx
               	callq	<addr>
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %edi
               	movl	$0x2, %esi
               	movq	%rsi, %rdx
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movq	$-0x1, -0x8(%rbp)
               	movl	-0x18(%rbp), %edi
               	movl	$0x2, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	-0x18(%rbp), %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %edi
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
               	movl	-0x10(%rbp), %edi
               	movl	-0x10(%rbp), %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	movl	-0x10(%rbp), %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	movslq	-0x20(%rbp), %rdi
               	movslq	-0x20(%rbp), %rsi
               	callq	<addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movslq	-0x20(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
