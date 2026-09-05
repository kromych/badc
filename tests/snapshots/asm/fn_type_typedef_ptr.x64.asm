
fn_type_typedef_ptr.x64:	file format elf64-x86-64

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

<cr_init>:
               	movl	$0x7, %eax
               	movl	%eax, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	xorq	%rax, %rax
               	retq

<my_realloc>:
               	movq	%rsi, %rax
               	leaq	<rip>, %rcx
               	movq	%rdx, (%rcx)
               	retq

<inc>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<apply>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<apply2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<deref_call>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movq	(%rdi), %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<grouped>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<via_alias>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	xorq	%rdi, %rdi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x2a, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0x5, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x3, %edi
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	movl	$0x4, %edi
               	callq	*%rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	movl	$0x5, %edi
               	callq	*%rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x6, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
