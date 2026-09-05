
zero_length_array_member_marker.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rax
               	cmpl	$0x1, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	movslq	0x4(%rdx), %rcx
               	cmpl	$0x2, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x8(%rdx), %rcx
               	cmpl	$0x3, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x5, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x6, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x5a5a5a, %ecx         # imm = 0x5A5A5A
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	$0x2, %edx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x28, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x29, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
