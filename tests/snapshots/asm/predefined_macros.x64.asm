
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
               	movl	$0x10, %ecx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movslq	%eax, %rax
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
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	addq	$0x3, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x20, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0x6, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x20, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addq	$0xb, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	addq	$0x2, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x3a, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0x5, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x3a, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addq	$0x8, %rax
               	movzbq	(%rax), %rax
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
               	addb	%al, 0x41(%rdx)
