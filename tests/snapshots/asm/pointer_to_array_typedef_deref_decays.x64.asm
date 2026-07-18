
pointer_to_array_typedef_deref_decays.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	leaq	-0x40(%rbp), %rcx
               	movabsq	$-0x1, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x40(%rbp), %rcx
               	movq	%rax, 0x38(%rcx)
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rax
               	movl	$0x1234567, %ecx        # imm = 0x1234567
               	movq	%rcx, (%rax)
               	movl	$0x1234568, %ecx        # imm = 0x1234568
               	movq	%rcx, 0x38(%rax)
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x1234567, %rax        # imm = 0x1234567
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	0x38(%rax), %rax
               	cmpq	$0x1234568, %rax        # imm = 0x1234568
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x1234567, %rax        # imm = 0x1234567
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rax
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
