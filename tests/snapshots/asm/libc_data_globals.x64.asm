
libc_data_globals.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x0, (%rax)
               	movq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rcx
               	movq	<rip>, %rdx # <addr>
               	movq	(%rdx), %rdx
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
