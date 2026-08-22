
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
               	movl	%eax, %eax
               	retq

<load_le32>:
               	movl	(%rdi), %eax
               	movl	%eax, %eax
               	retq

<load_be64>:
               	movq	(%rdi), %rax
               	bswapq	%rax
               	retq

<load_le16>:
               	movzwq	(%rdi), %rax
               	movl	%eax, %eax
               	retq

<load_be24>:
               	movzbq	(%rdi), %rax
               	shlq	$0x10, %rax
               	movl	%eax, %eax
               	movzbq	0x1(%rdi), %rcx
               	shlq	$0x8, %rcx
               	movl	%ecx, %ecx
               	orq	%rcx, %rax
               	movzbq	0x2(%rdi), %rcx
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x11, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x22, %ecx
               	movb	%cl, 0x1(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x33, %ecx
               	movb	%cl, 0x2(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x44, %ecx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x55, %ecx
               	movb	%cl, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x66, %ecx
               	movb	%cl, 0x5(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x77, %ecx
               	movb	%cl, 0x6(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x88, %ecx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x99, %ecx
               	movb	%cl, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0xaa, %ecx
               	movb	%cl, 0x9(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0xbb, %ecx
               	movb	%cl, 0xa(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0xcc, %ecx
               	movb	%cl, 0xb(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0xdd, %ecx
               	movb	%cl, 0xc(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0xee, %ecx
               	movb	%cl, 0xd(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0xff, %ecx
               	movb	%cl, 0xe(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x10, %ecx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	bswapl	%eax
               	movl	%eax, %eax
               	cmpq	$0x11223344, %rax       # imm = 0x11223344
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	movl	%eax, %eax
               	cmpq	$0x44332211, %rax       # imm = 0x44332211
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	incq	%rax
               	movl	(%rax), %eax
               	bswapl	%eax
               	movl	%eax, %eax
               	cmpq	$0x22334455, %rax       # imm = 0x22334455
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	addq	$0x3, %rax
               	movl	(%rax), %eax
               	movl	%eax, %eax
               	cmpq	$0x77665544, %rax       # imm = 0x77665544
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	bswapq	%rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	incq	%rax
               	movq	(%rax), %rax
               	bswapq	%rax
               	movabsq	$0x2233445566778899, %r11 # imm = 0x2233445566778899
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	addq	$0x5, %rax
               	movzwq	(%rax), %rax
               	movl	%eax, %eax
               	cmpq	$0x7766, %rax           # imm = 0x7766
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rcx
               	shlq	$0x10, %rcx
               	movl	%ecx, %ecx
               	movzbq	0x1(%rax), %rdx
               	shlq	$0x8, %rdx
               	movl	%edx, %edx
               	orq	%rdx, %rcx
               	movzbq	0x2(%rax), %rax
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	cmpq	$0x334455, %rax         # imm = 0x334455
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
