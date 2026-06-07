
predefined_macros.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0xf, %eax
               	movl	$0x10, %edx
               	subq	%rax, %rdx
               	movslq	%edx, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	%rcx, %rax
               	addq	$0x3, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x20, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	addq	$0x6, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x20, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addq	$0xb, %rcx
               	movzbq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	%rcx, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x3a, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	addq	$0x5, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x3a, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addq	$0x8, %rcx
               	movzbq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
