
inline_nonleaf_const_switch.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movl	$0x0, -0x18(%rbp)
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x11223344, (%rax)     # imm = 0x11223344
               	leaq	-0x10(%rbp), %rax
               	movw	$0x3344, (%rax)         # imm = 0x3344
               	leaq	-0x8(%rbp), %rax
               	movb	$0x44, (%rax)
               	movl	-0x18(%rbp), %eax
               	xorq	$0x11223344, %rax       # imm = 0x11223344
               	movl	-0x10(%rbp), %ecx
               	xorq	$0x3344, %rcx           # imm = 0x3344
               	orq	%rcx, %rax
               	movl	-0x8(%rbp), %ecx
               	xorq	$0x44, %rcx
               	orq	%rcx, %rax
               	movslq	%eax, %rax
               	leave
               	retq
