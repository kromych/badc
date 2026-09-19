
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
               	subq	$0x30, %rsp
               	leaq	-0x30(%rbp), %rax
               	movl	$0x1111, %ecx           # imm = 0x1111
               	movq	%rcx, 0x8(%rax)
               	leaq	0x8(%rax), %rcx
               	cmpq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x2222, %ecx           # imm = 0x2222
               	movq	%rcx, 0x10(%rax)
               	movq	0x8(%rax), %rax
               	cmpq	$0x1111, %rax           # imm = 0x1111
               	jne	<addr>
               	xorq	%rax, %rax
               	leave
               	retq
               	movl	$0x5, %eax
               	leave
               	retq
