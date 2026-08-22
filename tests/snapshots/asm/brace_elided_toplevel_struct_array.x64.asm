
brace_elided_toplevel_struct_array.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	cmpq	$0x1, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movslq	0x14(%rdx), %rdx
               	cmpq	$0x6, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movslq	0x8(%rdx), %rdx
               	cmpq	$0x1e, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movslq	0x4(%rax), %rdx
               	cmpq	$0xc8, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x8(%rax), %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movslq	0x14(%rcx), %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
