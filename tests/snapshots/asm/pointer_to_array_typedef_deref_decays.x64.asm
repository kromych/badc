
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
               	movq	%rax, -0x58(%rbp)
               	leaq	-0x48(%rbp), %rax
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x48(%rbp), %rax
               	movq	-0x58(%rbp), %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x48(%rbp), %rax
               	movq	-0x58(%rbp), %rcx
               	movq	%rcx, 0x38(%rax)
               	movq	-0x50(%rbp), %rax
               	movq	-0x58(%rbp), %rcx
               	addq	$0x1234568, %rcx        # imm = 0x1234568
               	movq	%rcx, (%rax)
               	incq	%rcx
               	movq	%rcx, 0x38(%rax)
               	leaq	-0x48(%rbp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x1234567, %rcx        # imm = 0x1234567
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x48(%rbp), %rcx
               	movq	0x38(%rcx), %rcx
               	cmpq	$0x1234568, %rcx        # imm = 0x1234568
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	(%rax), %rcx
               	cmpq	$0x1234567, %rcx        # imm = 0x1234567
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	0x38(%rax), %rax
               	cmpq	$0x1234568, %rax        # imm = 0x1234568
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
