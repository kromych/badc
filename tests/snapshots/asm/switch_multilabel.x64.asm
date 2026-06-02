
switch_multilabel.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %r11
               	jmp	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	retq
               	movl	$0x2, %r11d
               	movq	%r11, %rax
               	retq
               	movl	$0x3, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	cmpq	$0x61, %r11
               	je	<addr>
               	cmpq	$0x62, %r11
               	je	<addr>
               	cmpq	$0x63, %r11
               	je	<addr>
               	cmpq	$0x64, %r11
               	je	<addr>
               	cmpq	$0x41, %r11
               	je	<addr>
               	cmpq	$0x42, %r11
               	je	<addr>
               	cmpq	$0x30, %r11
               	je	<addr>
               	cmpq	$0x31, %r11
               	je	<addr>
               	cmpq	$0x32, %r11
               	je	<addr>
               	cmpq	$0x33, %r11
               	je	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x61, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	movl	$0x62, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	movl	$0x63, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	movl	$0x64, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	movl	$0x41, %edi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x5, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	movl	$0x42, %edi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	movl	$0x30, %edi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x7, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	movl	$0x33, %edi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x8, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	movl	$0x3f, %edi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x9, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
