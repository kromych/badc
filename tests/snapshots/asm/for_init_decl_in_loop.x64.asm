
for_init_decl_in_loop.x64:	file format elf64-x86-64

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

<run>:
               	xorl	%eax, %eax
               	movl	$0x1, %edx
               	imulq	$0x64, %rdx, %rcx
               	addq	%rcx, %rax
               	leaq	0x1(%rcx), %rsi
               	addq	%rsi, %rax
               	leaq	0x2(%rcx), %rsi
               	addq	%rsi, %rax
               	leaq	0x3(%rcx), %rsi
               	addq	%rsi, %rax
               	leaq	0x4(%rcx), %rsi
               	addq	%rsi, %rax
               	leaq	0x5(%rcx), %rsi
               	addq	%rsi, %rax
               	leaq	0x6(%rcx), %rsi
               	addq	%rsi, %rax
               	leaq	0x7(%rcx), %rsi
               	addq	%rsi, %rax
               	leaq	0x8(%rcx), %rsi
               	addq	%rsi, %rax
               	leaq	0x9(%rcx), %rsi
               	addq	%rsi, %rax
               	addq	$0xa, %rcx
               	addq	%rax, %rcx
               	imulq	$0x64, %rdx, %rax
               	leaq	0xb(%rax), %rsi
               	addq	%rsi, %rcx
               	leaq	0xc(%rax), %rsi
               	addq	%rsi, %rcx
               	leaq	0xd(%rax), %rsi
               	addq	%rsi, %rcx
               	leaq	0xe(%rax), %rsi
               	addq	%rsi, %rcx
               	addq	$0xf, %rax
               	addq	%rcx, %rax
               	incq	%rdx
               	cmpl	$0x5, %edx
               	jl	<addr>
               	retq

<main>:
               	pushq	%rax
               	callq	<addr>
               	cmpl	$0x4060, %eax           # imm = 0x4060
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
