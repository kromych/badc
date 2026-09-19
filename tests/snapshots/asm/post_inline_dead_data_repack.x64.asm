
post_inline_dead_data_repack.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdx
               	leaq	0x18(%rdx), %rax
               	cmpq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x3f, %cl
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	(%rcx), %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movq	0x8(%rcx), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x19, 0x10(%rax)
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	movq	0x10(%rax), %rsi
               	cmpq	$0x19, %rsi
               	jne	<addr>
               	cmpq	$0x0, 0x18(%rax)
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rsi
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x28, %edx
               	movq	0x8(%rcx), %rcx
               	movq	0x10(%rax), %r8
               	xchgq	%rdx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
