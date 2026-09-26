
wrap_signed.x64:	file format elf64-x86-64

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

<two_back_edges>:
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%esi, %edi
               	jge	<addr>
               	incq	%rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	testb	$0x1, %al
               	je	<addr>
               	incq	%rdi
               	jmp	<addr>
               	movslq	%edi, %rdi
               	addq	%rdi, %rdx
               	addq	$0x2, %rdi
               	cmpl	%esi, %edi
               	jl	<addr>
               	movl	%edi, (%rcx)
               	movq	%rdx, %rax
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

<sum_nonzero>:
               	leaq	(%rdi,%rsi), %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<pre_inc>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<step_by>:
               	leaq	0x2(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<neg>:
               	movq	%rdi, %rax
               	negq	%rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x7fffffff, -0x10(%rbp) # imm = 0x7FFFFFFF
               	movl	$0x80000000, -0x8(%rbp) # imm = 0x80000000
               	movl	$0x0, -0x20(%rbp)
               	movl	$0x0, -0x18(%rbp)
               	movslq	-0x10(%rbp), %rax
               	leaq	-0x2(%rax), %rdi
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	movabsq	$0x17ffffffa, %r11      # imm = 0x17FFFFFFA
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movslq	-0x20(%rbp), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	leaq	-0x1(%rax), %rdi
               	movslq	-0x10(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	leaq	-0x1(%rax), %rdi
               	movslq	-0x8(%rbp), %rax
               	leaq	0x2(%rax), %rsi
               	callq	<addr>
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	leaq	-0x5(%rax), %rdi
               	movslq	-0x10(%rbp), %rsi
               	movl	$0x4, %edx
               	movl	$0x3, %ecx
               	callq	<addr>
               	cmpq	$0x7ffffffa, %rax       # imm = 0x7FFFFFFA
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rax
               	leaq	0x1(%rax), %rdi
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	movabsq	$-0xffffffff, %r11      # imm = 0xFFFFFFFF00000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movslq	-0x20(%rbp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	leaq	-0x2(%rax), %rdi
               	movslq	-0x10(%rbp), %rsi
               	movl	$0x5, %edx
               	leaq	-0x18(%rbp), %rcx
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movslq	-0x18(%rbp), %rax
               	cmpl	$0x80000003, %eax       # imm = 0x80000003
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rdi
               	callq	<addr>
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rdi
               	movslq	-0x8(%rbp), %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rdi
               	callq	<addr>
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	cmpq	$-0x7fffffff, %rax      # imm = 0x80000001
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rdi
               	callq	<addr>
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
