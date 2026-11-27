
struct_field_displacement.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	leaq	(%rsp), %rax
               	movq	%rax, 0x18(%rsp)
               	movq	0x18(%rsp), %rax
               	movl	$0x1, (%rax)
               	movw	$0x2c, 0x10(%rax)
               	movl	$0x64, 0x4(%rax)
               	movq	$0x313, 0x8(%rax)       # imm = 0x313
               	movb	$0x6, 0x12(%rax)
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
