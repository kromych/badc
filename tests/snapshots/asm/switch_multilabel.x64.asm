
switch_multilabel.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	jmp	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	retq
               	movl	$0x2, %edi
               	movq	%rdi, %rax
               	retq
               	movl	$0x3, %eax
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	retq
               	cmpq	$0x61, %rdi
               	je	<addr>
               	cmpq	$0x62, %rdi
               	je	<addr>
               	cmpq	$0x63, %rdi
               	je	<addr>
               	cmpq	$0x64, %rdi
               	je	<addr>
               	cmpq	$0x41, %rdi
               	je	<addr>
               	cmpq	$0x42, %rdi
               	je	<addr>
               	cmpq	$0x30, %rdi
               	je	<addr>
               	cmpq	$0x31, %rdi
               	je	<addr>
               	cmpq	$0x32, %rdi
               	je	<addr>
               	cmpq	$0x33, %rdi
               	je	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x61, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	movl	$0x62, %eax
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpq	$0x1, %rdi
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x63, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpq	$0x1, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x41, %edi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x5, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	movl	$0x42, %eax
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpq	$0x2, %rdi
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x30, %edi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x7, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	movl	$0x33, %eax
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpq	$0x3, %rdi
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movl	$0x3f, %edi
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
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
