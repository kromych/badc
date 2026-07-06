
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
               	imulq	$0x64, %rcx, %rsi
               	addq	$0x0, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rcx, %rsi
               	incq	%rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rcx, %rsi
               	addq	$0x2, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rcx, %rsi
               	addq	$0x3, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rcx, %rsi
               	addq	$0x4, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rcx, %rsi
               	addq	$0x5, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rcx, %rsi
               	addq	$0x6, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rcx, %rsi
               	addq	$0x7, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rcx, %rsi
               	addq	$0x8, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rcx, %rsi
               	addq	$0x9, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rcx, %rsi
               	addq	$0xa, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rcx, %rsi
               	addq	$0xb, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rcx, %rsi
               	addq	$0xc, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rcx, %rsi
               	addq	$0xd, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rcx, %rsi
               	addq	$0xe, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rcx, %rsi
               	addq	$0xf, %rsi
               	addq	%rsi, %rdx
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
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
