
unsigned_div_in_assign.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<outer>:
               	movq	(%rdi), %rcx
               	movl	$0x18, %eax
               	movq	%rax, %r10
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rdx
               	movl	$0x7, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movl	$0x18, %eax
               	movq	%rax, %r10
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rdx
               	movl	$0x7, %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x3ea, %rax            # imm = 0x3EA
               	jne	<addr>
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	addb	%al, (%rax)
