
a_step_tested_again_after_compares.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<report>:
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	retq

<classify>:
               	testq	%rdi, %rdi
               	je	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	xorl	%r12d, %r12d
               	movq	%rbx, %r13
               	addq	$0x9, %r13
               	jne	<addr>
               	callq	<addr>
               	movzbq	(%r13), %rax
               	andq	$0x38, %rax
               	testl	%eax, %eax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r13, %r13
               	jne	<addr>
               	callq	<addr>
               	movzbq	(%r13), %rax
               	andq	$0x7, %rax
               	cmpl	$0x6, %eax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%r14, %rax
               	leaq	0x64(%r12), %rcx
               	testq	%rax, %rax
               	cmoveq	%r12, %rcx
               	leaq	0x1(%rcx), %r12
               	movq	(%rbx), %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x40(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movups	%xmm14, 0x20(%rcx)
               	movups	%xmm14, 0x30(%rcx)
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movq	%rdi, (%rsi)
               	leaq	(%rax,%rax,8), %rdi
               	andq	$0xff, %rdi
               	movb	%dil, 0x9(%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rcx, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	leaq	0x1(%rax), %rdi
               	shlq	$0x4, %rdi
               	addq	%rcx, %rdi
               	jmp	<addr>
               	movq	%rdx, %rdi
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	cmpl	$0x68, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
