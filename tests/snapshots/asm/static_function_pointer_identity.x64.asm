
static_function_pointer_identity.x64:	file format elf64-x86-64

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

<f>:
               	movl	$0x7, %eax
               	retq

<g>:
               	movl	$0x9, %eax
               	retq

<main>:
               	pushq	%rax
               	movq	<rip>, %rcx # <addr>
               	leaq	-<rip>, %rax # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rsi # <addr>
               	leaq	-<rip>, %rdx # <addr>
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	callq	*%rcx
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	leaq	-<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%r11
               	retq
               	leaq	-<rip>, %rax # <addr>
               	leaq	-<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
