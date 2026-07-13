
comparison_imm_lhs_swap.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	movl	$0x1, %ebx
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rbx
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rbx
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rbx
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rbx
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rbx
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rbx
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rbx
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
               	addb	%al, (%rax)
