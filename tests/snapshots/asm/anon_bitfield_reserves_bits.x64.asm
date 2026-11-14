
anon_bitfield_reserves_bits.x64:	file format elf64-x86-64

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
               	movl	$0x0, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	$0x1, -0x10(%rbp)
               	movabsq	$0x5566778811223344, %rax # imm = 0x5566778811223344
               	movq	%rax, -0x8(%rbp)
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	jne	<addr>
               	movl	-0x4(%rbp), %eax
               	cmpl	$0x55667788, %eax       # imm = 0x55667788
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
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
