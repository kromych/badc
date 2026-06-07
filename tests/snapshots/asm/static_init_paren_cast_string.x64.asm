
static_init_paren_cast_string.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x5, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	(%rdx), %rcx
               	addq	$0x5, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x1a, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rdx, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%rdx, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rcx
               	addq	$0x9, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x4, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	addq	$0x10, %rdx
               	movq	(%rdx), %rcx
               	addq	$0x9, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
