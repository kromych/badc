
switch_label_after_terminator.x64:	file format elf64-x86-64

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
               	xorq	%r9, %r9
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %r9d
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x2, %r9d
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x3, %r9d
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	movabsq	$-0x1, %r9
               	movq	%r9, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x1, %rdi
               	je	<addr>
               	cmpq	$0x2, %rdi
               	je	<addr>
               	cmpq	$0x3, %rdi
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	addq	$0x64, %r9
               	movslq	%r9d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x65, %rax
               	je	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpq	$0x66, %rdi
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x67, %rax
               	je	<addr>
               	movl	$0x3, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	movl	$0x63, %eax
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpq	$-0x1, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
