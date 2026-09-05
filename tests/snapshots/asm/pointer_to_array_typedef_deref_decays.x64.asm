
pointer_to_array_typedef_deref_decays.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	movabsq	$-0x1, %rax
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, -0x48(%rbp)
               	movq	-0x50(%rbp), %rcx
               	movq	%rcx, (%rax)
               	movq	-0x50(%rbp), %rcx
               	movq	%rcx, 0x38(%rax)
               	movq	-0x48(%rbp), %rcx
               	movq	-0x50(%rbp), %rdx
               	addq	$0x1234568, %rdx        # imm = 0x1234568
               	movq	%rdx, (%rcx)
               	incq	%rdx
               	movq	%rdx, 0x38(%rcx)
               	movq	(%rax), %rdx
               	cmpq	$0x1234567, %rdx        # imm = 0x1234567
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	0x38(%rax), %rax
               	cmpq	$0x1234568, %rax        # imm = 0x1234568
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	(%rcx), %rax
               	cmpq	$0x1234567, %rax        # imm = 0x1234567
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	0x38(%rcx), %rax
               	cmpq	$0x1234568, %rax        # imm = 0x1234568
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
               	jmp	<addr>
