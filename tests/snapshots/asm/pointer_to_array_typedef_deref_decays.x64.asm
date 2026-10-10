
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
               	subq	$0x50, %rsp
               	movq	$-0x1, -0x10(%rbp)
               	leaq	-0x50(%rbp), %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, -0x50(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, -0x18(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	addq	$0x1234568, %rcx        # imm = 0x1234568
               	movq	%rcx, (%rax)
               	incq	%rcx
               	movq	%rcx, 0x38(%rax)
               	movq	-0x50(%rbp), %rcx
               	cmpq	$0x1234567, %rcx        # imm = 0x1234567
               	jne	<addr>
               	movq	-0x18(%rbp), %rcx
               	cmpq	$0x1234568, %rcx        # imm = 0x1234568
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	cmpq	$0x1234567, %rcx        # imm = 0x1234567
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	0x38(%rax), %rax
               	cmpq	$0x1234568, %rax        # imm = 0x1234568
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
