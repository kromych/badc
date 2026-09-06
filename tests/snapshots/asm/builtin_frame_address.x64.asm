
builtin_frame_address.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movq	%rbp, %rax
               	movq	%rbp, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rcx
               	subq	%rcx, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	imulq	$-0x1, %rax, %rax
               	cmpq	$0x100000, %rax         # imm = 0x100000
               	jle	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
               	jmp	<addr>
