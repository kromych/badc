
volatile_ptr_alias_loop.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rdx
               	movslq	-0x8(%rbp), %rcx
               	incq	%rcx
               	movl	%ecx, (%rdx)
               	incq	%rax
               	movslq	%eax, %rcx
               	cmpq	$0xa, %rcx
               	jg	<addr>
               	movslq	-0x8(%rbp), %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
