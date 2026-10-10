
byte_load_wide_merge.x64:	file format elf64-x86-64

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

<load_be32>:
               	movl	(%rdi), %eax
               	bswapl	%eax
               	retq

<load_le32>:
               	movl	(%rdi), %eax
               	retq

<load_be64>:
               	movq	(%rdi), %rax
               	bswapq	%rax
               	retq

<load_le16>:
               	movzwq	(%rdi), %rax
               	retq

<load_be24>:
               	movzbq	(%rdi), %rax
               	shlq	$0x10, %rax
               	movzbq	0x1(%rdi), %rcx
               	shlq	$0x8, %rcx
               	orq	%rcx, %rax
               	movzbq	0x2(%rdi), %rcx
               	orq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movb	$0x11, -0x10(%rbp)
               	movb	$0x22, -0xf(%rbp)
               	movb	$0x33, -0xe(%rbp)
               	movb	$0x44, -0xd(%rbp)
               	movb	$0x55, -0xc(%rbp)
               	movb	$0x66, -0xb(%rbp)
               	movb	$0x77, -0xa(%rbp)
               	movb	$-0x78, -0x9(%rbp)
               	movb	$-0x67, -0x8(%rbp)
               	movb	$-0x56, -0x7(%rbp)
               	movb	$-0x45, -0x6(%rbp)
               	movb	$-0x34, -0x5(%rbp)
               	movb	$-0x23, -0x4(%rbp)
               	movb	$-0x12, -0x3(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movb	$-0x1, -0x2(%rbp)
               	movb	$0x10, -0x1(%rbp)
               	movl	(%rax), %ecx
               	bswapl	%ecx
               	cmpl	$0x11223344, %ecx       # imm = 0x11223344
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	(%rax), %ecx
               	cmpl	$0x44332211, %ecx       # imm = 0x44332211
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	0x1(%rax), %ecx
               	bswapl	%ecx
               	cmpl	$0x22334455, %ecx       # imm = 0x22334455
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	0x3(%rax), %ecx
               	cmpl	$0x77665544, %ecx       # imm = 0x77665544
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	(%rax), %rax
               	bswapq	%rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	0x1(%rax), %rcx
               	bswapq	%rcx
               	movabsq	$0x2233445566778899, %r11 # imm = 0x2233445566778899
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movzwq	0x5(%rax), %rax
               	cmpl	$0x7766, %eax           # imm = 0x7766
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
