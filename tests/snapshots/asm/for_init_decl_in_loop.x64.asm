
for_init_decl_in_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<run>:
               	xorq	%rcx, %rcx
               	movl	$0x1, %eax
               	jmp	<addr>
               	imulq	$0x64, %rax, %rdx
               	addq	$0x0, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	incq	%rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	addq	$0x2, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	addq	$0x3, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	addq	$0x4, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	addq	$0x5, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	addq	$0x6, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	addq	$0x7, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	addq	$0x8, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	addq	$0x9, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	addq	$0xa, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	addq	$0xb, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	addq	$0xc, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	addq	$0xd, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	addq	$0xe, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	addq	$0xf, %rdx
               	addq	%rdx, %rcx
               	leaq	0x1(%rsi), %rax
               	movslq	%eax, %rsi
               	cmpq	$0x5, %rsi
               	jl	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	retq
               	jmp	<addr>

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
