
extern_in_function.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	imulq	$-0x1, %rax, %rax
               	retq
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	imulq	$-0x1, %rax, %rax
               	retq
               	movabsq	$-0x5, %rax
               	imulq	$-0x1, %rax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movl	$0x7, %eax
               	imulq	$-0x1, %rax, %rax
               	cmpq	$-0x7, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	$0x3, %eax
               	imulq	$-0x1, %rax, %rax
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movabsq	$-0x1, %rax
               	imulq	$-0x1, %rax, %rcx
               	imulq	$-0x1, %rax, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
