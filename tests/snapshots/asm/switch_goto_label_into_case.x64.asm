
switch_goto_label_into_case.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x14, %r8d
               	movq	%r8, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1e, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x5, %rdi
               	setge	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x8(%rbp)
               	cmpq	$0x0, %r8
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x1, %rdi
               	je	<addr>
               	cmpq	$0x2, %rdi
               	je	<addr>
               	cmpq	$0x3, %rdi
               	je	<addr>
               	cmpq	$0x4, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x8, %rdi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x8(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpq	$0x14, %rdi
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x3, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpq	$0x1e, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x5, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpq	$0x1e, %rdi
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x8, %edi
               	callq	<addr>
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x7, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x9, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
