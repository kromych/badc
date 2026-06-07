
init_leading_neg_arith.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	addq	$0x8, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$-0x4650, %rcx          # imm = 0xB9B0
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%rax, %rcx
               	addq	$0x18, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$-0x5460, %rcx          # imm = 0xABA0
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rax, %rcx
               	addq	$0x28, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$-0x6234, %rcx          # imm = 0x9DCC
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	addq	$0x38, %rax
               	movslq	(%rax), %rax
               	cmpq	$-0x9, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
