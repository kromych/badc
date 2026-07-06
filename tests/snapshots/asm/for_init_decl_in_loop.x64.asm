
for_init_decl_in_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<run>:
               	xorq	%rdx, %rdx
               	movl	$0x1, %ecx
               	jmp	<addr>
               	imulq	$0x64, %rcx, %rax
               	addq	$0x0, %rax
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rdx
               	incq	%rdx
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rdx
               	addq	$0x2, %rdx
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rdx
               	addq	$0x3, %rdx
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rdx
               	addq	$0x4, %rdx
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rdx
               	addq	$0x5, %rdx
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rdx
               	addq	$0x6, %rdx
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rdx
               	addq	$0x7, %rdx
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rdx
               	addq	$0x8, %rdx
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rdx
               	addq	$0x9, %rdx
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rdx
               	addq	$0xa, %rdx
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rdx
               	addq	$0xb, %rdx
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rdx
               	addq	$0xc, %rdx
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rdx
               	addq	$0xd, %rdx
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rdx
               	addq	$0xe, %rdx
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rdx
               	addq	$0xf, %rdx
               	addq	%rax, %rdx
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jl	<addr>
               	movslq	%edx, %rax
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
