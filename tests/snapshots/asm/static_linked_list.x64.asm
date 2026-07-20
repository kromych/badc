
static_linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rcx
               	movl	$0x1, %eax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	movq	%rax, 0x8(%rcx)
               	movl	$0x2, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	movl	$0x3, %eax
               	movl	%eax, (%rcx)
               	xorq	%rax, %rax
               	movq	%rax, 0x8(%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	jmp	<addr>
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movq	0x8(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	retq
