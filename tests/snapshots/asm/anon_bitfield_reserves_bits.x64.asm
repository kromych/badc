
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
               	leaq	-0x10(%rbp), %rcx
               	movb	$0x0, -0x10(%rbp)
               	movb	$0x0, -0xf(%rbp)
               	movb	$0x0, -0xe(%rbp)
               	movb	$0x0, -0xd(%rbp)
               	movb	$0x0, -0xc(%rbp)
               	movb	$0x0, -0xb(%rbp)
               	movb	$0x0, -0xa(%rbp)
               	movb	$0x0, -0x9(%rbp)
               	movb	$0x0, -0x8(%rbp)
               	movb	$0x0, -0x7(%rbp)
               	movb	$0x0, -0x6(%rbp)
               	movb	$0x0, -0x5(%rbp)
               	movb	$0x0, -0x4(%rbp)
               	movb	$0x0, -0x3(%rbp)
               	movb	$0x0, -0x2(%rbp)
               	movb	$0x0, -0x1(%rbp)
               	movl	$0x1, (%rcx)
               	movl	$0x11223344, -0x8(%rbp) # imm = 0x11223344
               	movl	$0x55667788, -0x4(%rbp) # imm = 0x55667788
               	movl	(%rcx), %eax
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
