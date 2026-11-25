
fn_type_typedef_ptr.x64:	file format elf64-x86-64

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

<cr_init>:
               	movl	$0x7, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	retq

<my_realloc>:
               	movq	%rsi, %rax
               	movq	%rdx, <rip> # <addr>
               	retq

<inc>:
               	leaq	0x1(%rdi), %rax
               	retq

<apply>:
               	pushq	%rax
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	popq	%r11
               	retq

<apply2>:
               	pushq	%rax
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	popq	%r11
               	retq

<deref_call>:
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	popq	%r11
               	retq

<grouped>:
               	pushq	%rax
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	popq	%r11
               	retq

<via_alias>:
               	pushq	%rax
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	popq	%r11
               	retq

<main>:
               	subq	$0x18, %rsp
               	movl	$0x5, (%rsp)
               	xorl	%edi, %edi
               	leaq	(%rsp), %rsi
               	movl	$0x2a, %edx
               	callq	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x2a, %rcx
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x6, %edi
               	callq	*%rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
