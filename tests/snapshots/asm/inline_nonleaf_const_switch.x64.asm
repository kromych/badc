
inline_nonleaf_const_switch.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, -0x10(%rbp)
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x11223344, %ecx       # imm = 0x11223344
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x3344, %ecx           # imm = 0x3344
               	movw	%cx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x44, %ecx
               	movb	%cl, (%rax)
               	movl	-0x8(%rbp), %eax
               	xorq	$0x11223344, %rax       # imm = 0x11223344
               	movl	-0x10(%rbp), %ecx
               	xorq	$0x3344, %rcx           # imm = 0x3344
               	orq	%rcx, %rax
               	movl	-0x18(%rbp), %ecx
               	xorq	$0x44, %rcx
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
