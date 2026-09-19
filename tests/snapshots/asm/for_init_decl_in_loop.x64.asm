
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
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	imulq	$0x64, %rcx, %rax
               	addq	%rax, %rdx
               	leaq	0x1(%rax), %rsi
               	addq	%rsi, %rdx
               	leaq	0x2(%rax), %rsi
               	addq	%rsi, %rdx
               	leaq	0x3(%rax), %rsi
               	addq	%rsi, %rdx
               	leaq	0x4(%rax), %rsi
               	addq	%rsi, %rdx
               	leaq	0x5(%rax), %rsi
               	addq	%rsi, %rdx
               	leaq	0x6(%rax), %rsi
               	addq	%rsi, %rdx
               	leaq	0x7(%rax), %rsi
               	addq	%rsi, %rdx
               	addq	$0x8, %rax
               	addq	%rax, %rdx
               	imulq	$0x64, %rcx, %rax
               	leaq	0x9(%rax), %rsi
               	addq	%rsi, %rdx
               	leaq	0xa(%rax), %rsi
               	addq	%rsi, %rdx
               	leaq	0xb(%rax), %rsi
               	addq	%rsi, %rdx
               	leaq	0xc(%rax), %rsi
               	addq	%rsi, %rdx
               	leaq	0xd(%rax), %rsi
               	addq	%rsi, %rdx
               	leaq	0xe(%rax), %rsi
               	addq	%rsi, %rdx
               	addq	$0xf, %rax
               	addq	%rax, %rdx
               	incq	%rcx
               	cmpl	$0x5, %ecx
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
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
