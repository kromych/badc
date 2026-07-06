
environ_single_tu.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	addq	$0x8, %rax
               	movq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	jle	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
