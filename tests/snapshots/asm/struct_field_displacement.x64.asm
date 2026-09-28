
struct_field_displacement.x64:	file format elf64-x86-64

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
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movl	$0x1, (%rax)
               	movl	$0x16, 0x4(%rax)
               	movq	$0x14d, 0x8(%rax)       # imm = 0x14D
               	movw	$0x2c, 0x10(%rax)
               	movb	$0x5, 0x12(%rax)
               	movl	$0x63, 0x4(%rax)
               	movq	$0x309, 0x8(%rax)       # imm = 0x309
               	movl	$0x64, 0x4(%rax)
               	movq	$0x313, 0x8(%rax)       # imm = 0x313
               	movb	$0x6, 0x12(%rax)
               	xorl	%eax, %eax
               	leave
               	retq
