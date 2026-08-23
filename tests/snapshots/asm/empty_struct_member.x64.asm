
empty_struct_member.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	xorq	%rax, %rax
               	leaq	-0x38(%rbp), %rax
               	movl	$0x1111, %ecx           # imm = 0x1111
               	movq	%rcx, 0x8(%rax)
               	cmpq	$0x1111, %rcx           # imm = 0x1111
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0x8(%rax), %rcx
               	cmpq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2222, %ecx           # imm = 0x2222
               	movq	%rcx, 0x10(%rax)
               	movq	0x8(%rax), %rcx
               	cmpq	$0x1111, %rcx           # imm = 0x1111
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rax
               	cmpq	$0x2222, %rax           # imm = 0x2222
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
