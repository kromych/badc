
anon_bitfield_reserves_bits.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x0, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	$0x1, -0x10(%rbp)
               	movabsq	$0x5566778811223344, %rax # imm = 0x5566778811223344
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	0x8(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
