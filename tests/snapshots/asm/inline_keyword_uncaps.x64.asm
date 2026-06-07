
inline_keyword_uncaps.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	addq	$0x1, %rdi
               	addq	$0x2, %rdi
               	addq	$0x3, %rdi
               	addq	$0x4, %rdi
               	addq	$0x5, %rdi
               	addq	$0x6, %rdi
               	addq	$0x7, %rdi
               	addq	$0x8, %rdi
               	addq	$0x9, %rdi
               	addq	$0xa, %rdi
               	addq	$0xb, %rdi
               	addq	$0xc, %rdi
               	addq	$0xd, %rdi
               	addq	$0xe, %rdi
               	addq	$0xf, %rdi
               	addq	$0x10, %rdi
               	movq	%rdi, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x64, %edi
               	callq	<addr>
               	addq	%rax, %rbx
               	cmpq	$0x174, %rbx            # imm = 0x174
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
