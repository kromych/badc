
init_leading_neg_arith.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %rcx
               	movq	%rcx, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$-0x4650, %rax          # imm = 0xB9B0
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%rcx, %rax
               	addq	$0x18, %rax
               	movslq	(%rax), %rax
               	cmpq	$-0x5460, %rax          # imm = 0xABA0
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rcx, %rax
               	addq	$0x28, %rax
               	movslq	(%rax), %rax
               	cmpq	$-0x6234, %rax          # imm = 0x9DCC
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	addq	$0x38, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$-0x9, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
