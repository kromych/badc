
local_struct_array_compound_literal_runtime.x64:	file format elf64-x86-64

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
               	subq	$0xe0, %rsp
               	movl	$0x15, %ecx
               	movl	$0x33, %edx
               	leaq	-0x58(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rsi), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x18(%rsi), %rcx
               	movq	%rcx, 0x18(%rax)
               	movq	0x20(%rsi), %rcx
               	movq	%rcx, 0x20(%rax)
               	movq	0x28(%rsi), %rcx
               	movq	%rcx, 0x28(%rax)
               	movq	0x30(%rsi), %rcx
               	movq	%rcx, 0x30(%rax)
               	movq	0x38(%rsi), %rcx
               	movq	%rcx, 0x38(%rax)
               	movq	0x40(%rsi), %rcx
               	movq	%rcx, 0x40(%rax)
               	popq	%rcx
               	leaq	-0x58(%rbp), %rax
               	movq	%rcx, (%rax)
               	movl	$0x1014, %esi           # imm = 0x1014
               	leaq	-0x58(%rbp), %rax
               	movq	%rsi, 0x8(%rax)
               	movl	$0x200, %esi            # imm = 0x200
               	leaq	-0x58(%rbp), %rax
               	movq	%rsi, 0x10(%rax)
               	leaq	-0x58(%rbp), %rax
               	movq	%rdx, 0x18(%rax)
               	movl	$0x1032, %esi           # imm = 0x1032
               	leaq	-0x58(%rbp), %rax
               	movq	%rsi, 0x20(%rax)
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x15, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movl	$0x1, %eax
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x1014, %rax           # imm = 0x1014
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	movq	0x10(%rax), %rax
               	cmpq	$0x200, %rax            # imm = 0x200
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x33, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movl	$0x1, %eax
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	movq	0x20(%rax), %rax
               	cmpq	$0x1032, %rax           # imm = 0x1032
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	movq	0x28(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movq	0x30(%rax), %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movl	$0x1, %eax
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	movq	0x38(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	movq	0x40(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rsi), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x18(%rsi), %rcx
               	movq	%rcx, 0x18(%rax)
               	movq	0x20(%rsi), %rcx
               	movq	%rcx, 0x20(%rax)
               	movq	0x28(%rsi), %rcx
               	movq	%rcx, 0x28(%rax)
               	popq	%rcx
               	leaq	-0x88(%rbp), %rax
               	movq	%rcx, (%rax)
               	movl	$0x7, %ecx
               	leaq	-0x88(%rbp), %rax
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x88(%rbp), %rax
               	movq	%rdx, 0x20(%rax)
               	leaq	-0x88(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x15, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x88(%rbp), %rax
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x88(%rbp), %rax
               	movq	0x10(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	movq	0x18(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x88(%rbp), %rax
               	movq	0x20(%rax), %rax
               	cmpq	$0x33, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x88(%rbp), %rax
               	movq	0x28(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
