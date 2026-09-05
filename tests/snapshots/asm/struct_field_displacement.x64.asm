
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
               	subq	$0x30, %rsp
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x16, %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	$0x14d, %ecx            # imm = 0x14D
               	movq	%rcx, 0x8(%rax)
               	movl	$0x2c, %ecx
               	movw	%cx, 0x10(%rax)
               	movl	$0x5, %ecx
               	movb	%cl, 0x12(%rax)
               	movl	$0x63, %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	$0x309, %ecx            # imm = 0x309
               	movq	%rcx, 0x8(%rax)
               	movl	$0x64, %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	$0x313, %ecx            # imm = 0x313
               	movq	%rcx, 0x8(%rax)
               	movl	$0x6, %ecx
               	movb	%cl, 0x12(%rax)
               	xorq	%rax, %rax
               	leave
               	retq
