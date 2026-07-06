
static_linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	movl	$0x2, %eax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	movq	%rax, 0x8(%rcx)
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	jmp	<addr>
               	movslq	(%rcx), %rax
               	addq	%rax, %rdx
               	movq	0x8(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
