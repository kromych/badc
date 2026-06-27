
function_pointer_typedefs.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<do_add>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	retq

<do_sub>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	movslq	%eax, %rax
               	retq

<do_cmp>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdi
               	jge	<addr>
               	movabsq	$-0x1, %rax
               	retq
               	cmpq	%rsi, %rdi
               	jle	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	retq

<apply>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	movq	%rdx, %rsi
               	callq	*%rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-<rip>, %rbx       # <addr>
               	movl	$0x3, %edi
               	movl	$0x5, %esi
               	movq	%rbx, %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	movl	$0x2, %esi
               	movq	%rbx, %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movq	%rbx, %rax
               	movq	%rdi, %rsi
               	callq	*%rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	-<rip>, %rcx       # <addr>
               	movq	%rcx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	leaq	-<rip>, %rcx       # <addr>
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
               	movq	%rbx, 0x10(%rax)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x3, %esi
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movl	$0xa, %edi
               	movl	$0x4, %esi
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	0x10(%rax), %rax
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	movl	$0x8, %esi
               	movl	$0x9, %edx
               	callq	<addr>
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
