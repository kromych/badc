
extern_in_function.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	imulq	$-0x1, %rdi, %rdi
               	movq	%rdi, %rax
               	retq
               	movslq	%edi, %rdi
               	imulq	$-0x1, %rdi, %rdi
               	movq	%rdi, %rax
               	retq
               	movabsq	$-0x5, %rcx
               	imulq	$-0x1, %rcx, %rcx
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movl	$0x7, %ecx
               	imulq	$-0x1, %rcx, %rcx
               	cmpq	$-0x7, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	$0x3, %ecx
               	imulq	$-0x1, %rcx, %rcx
               	cmpq	$-0x3, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movabsq	$-0x1, %rdx
               	imulq	$-0x1, %rdx, %rax
               	imulq	$-0x1, %rdx, %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
