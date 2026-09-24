
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
               	movl	$0x7, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	retq

<my_realloc>:
               	movq	%rsi, %rax
               	leaq	<rip>, %rcx
               	movq	%rdx, (%rcx)
               	retq

<inc>:
               	leaq	0x1(%rdi), %rax
               	retq

<apply>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	popq	%rbp
               	retq

<apply2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	popq	%rbp
               	retq

<deref_call>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	(%rdi), %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	popq	%rbp
               	retq

<grouped>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	popq	%rbp
               	retq

<via_alias>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x5, -0x8(%rbp)
               	xorl	%edi, %edi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x2a, %edx
               	callq	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x2a, %rcx
               	jne	<addr>
               	movslq	(%rax), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x10(%rbp)
               	movl	$0x3, %edi
               	movq	-0x10(%rbp), %rax
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
               	xorl	%eax, %eax
               	leave
               	retq
