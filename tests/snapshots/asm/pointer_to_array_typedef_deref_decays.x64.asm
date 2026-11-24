
pointer_to_array_typedef_deref_decays.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x58, %rsp
               	movq	$-0x1, 0x40(%rsp)
               	leaq	(%rsp), %rax
               	movq	%rax, 0x48(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	%rax, (%rsp)
               	movq	0x40(%rsp), %rax
               	movq	%rax, 0x38(%rsp)
               	movq	0x48(%rsp), %rcx
               	movq	0x40(%rsp), %rax
               	addq	$0x1234568, %rax        # imm = 0x1234568
               	movq	%rax, (%rcx)
               	leaq	0x1(%rax), %rdx
               	movq	%rdx, 0x38(%rcx)
               	movq	(%rsp), %rcx
               	cmpq	$0x1234567, %rcx        # imm = 0x1234567
               	jne	<addr>
               	movq	0x38(%rsp), %rcx
               	cmpq	$0x1234568, %rcx        # imm = 0x1234568
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x58, %rsp
               	retq
               	cmpq	$0x1234567, %rax        # imm = 0x1234567
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x58, %rsp
               	retq
               	cmpq	$0x1234568, %rdx        # imm = 0x1234568
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x58, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x58, %rsp
               	retq
