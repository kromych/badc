
for_init_decl_in_loop.x64:	file format elf64-x86-64

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

<run>:
               	xorq	%rdx, %rdx
               	movl	$0x1, %eax
               	jmp	<addr>
               	imulq	$0x64, %rax, %rcx
               	leaq	(%rcx), %rsi
               	addq	%rsi, %rdx
               	leaq	0x1(%rcx), %rsi
               	addq	%rsi, %rdx
               	leaq	0x2(%rcx), %rsi
               	addq	%rsi, %rdx
               	leaq	0x3(%rcx), %rsi
               	addq	%rsi, %rdx
               	leaq	0x4(%rcx), %rsi
               	addq	%rsi, %rdx
               	leaq	0x5(%rcx), %rsi
               	addq	%rsi, %rdx
               	leaq	0x6(%rcx), %rsi
               	addq	%rsi, %rdx
               	addq	$0x7, %rcx
               	addq	%rcx, %rdx
               	imulq	$0x64, %rax, %rcx
               	leaq	0x8(%rcx), %rsi
               	addq	%rsi, %rdx
               	leaq	0x9(%rcx), %rsi
               	addq	%rsi, %rdx
               	leaq	0xa(%rcx), %rsi
               	addq	%rsi, %rdx
               	leaq	0xb(%rcx), %rsi
               	addq	%rsi, %rdx
               	leaq	0xc(%rcx), %rsi
               	addq	%rsi, %rdx
               	leaq	0xd(%rcx), %rsi
               	addq	%rsi, %rdx
               	leaq	0xe(%rcx), %rsi
               	addq	%rsi, %rdx
               	addq	$0xf, %rcx
               	addq	%rcx, %rdx
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rdi
               	cmpq	$0x5, %rdi
               	jl	<addr>
               	movslq	%edx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	cmpq	$0x4060, %rax           # imm = 0x4060
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
