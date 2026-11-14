
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
               	movw	$0x2211, -0x10(%rbp)    # imm = 0x2211
               	movw	$0x4433, -0xe(%rbp)     # imm = 0x4433
               	movw	$0x6655, -0xc(%rbp)     # imm = 0x6655
               	movw	$0x8877, -0xa(%rbp)     # imm = 0x8877
               	movw	$0xaa99, -0x8(%rbp)     # imm = 0xAA99
               	movw	$0xccbb, -0x6(%rbp)     # imm = 0xCCBB
               	movw	$0xeedd, -0x4(%rbp)     # imm = 0xEEDD
               	movw	$0x10ff, -0x2(%rbp)     # imm = 0x10FF
               	movl	-0x10(%rbp), %eax
               	movl	%eax, %ecx
               	bswapl	%ecx
               	cmpl	$0x11223344, %ecx       # imm = 0x11223344
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpl	$0x44332211, %eax       # imm = 0x44332211
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	-0xf(%rbp), %eax
               	bswapl	%eax
               	cmpl	$0x22334455, %eax       # imm = 0x22334455
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	-0xd(%rbp), %eax
               	cmpl	$0x77665544, %eax       # imm = 0x77665544
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	bswapq	%rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	-0xf(%rbp), %rax
               	bswapq	%rax
               	movabsq	$0x2233445566778899, %r11 # imm = 0x2233445566778899
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movzwq	-0xb(%rbp), %rax
               	cmpl	$0x7766, %eax           # imm = 0x7766
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
