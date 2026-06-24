
unsigned_div_in_assign.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<outer>:
               	movq	(%rdi), %rax
               	movl	$0x18, %ecx
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	$0x7, %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	imulq	$0x64, %rcx, %rcx
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
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rcx
               	movl	$0x18, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movl	$0x7, %eax
               	movq	%rax, %r10
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	imulq	$0x64, %rdx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x3ea, %rax            # imm = 0x3EA
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
