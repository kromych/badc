
packed_anon_union_layout.x64:	file format elf64-x86-64

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
               	subq	$0x108, %rsp            # imm = 0x108
               	leaq	(%rsp), %rax
               	leaq	0x80(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x80, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	leaq	0x80(%rsp), %rdi
               	xorl	%esi, %esi
               	movl	$0x80, %edx
               	callq	<addr>
               	movl	$0x3, 0x80(%rsp)
               	movl	$0x8, 0xbc(%rsp)
               	movl	$0x14, 0xc4(%rsp)
               	movzbq	0x80(%rsp), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	movzbq	0xbc(%rsp), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	movzbq	0xc4(%rsp), %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	xorl	%eax, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
