
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
               	xorq	%rdx, %rdx
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	jmp	<addr>
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	addq	$0x8, %rcx
               	movq	(%rcx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	%edx, %rax
               	testq	%rax, %rax
               	jle	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
