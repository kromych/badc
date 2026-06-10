
static_linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x230, %esi            # imm = 0x230
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
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
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%edx, %rax
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movslq	%eax, %rdx
               	movq	0x8(%rcx), %rcx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
