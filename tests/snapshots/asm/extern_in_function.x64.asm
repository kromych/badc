
extern_in_function.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	movabsq	$-0x1, %rax
               	imulq	%rdi, %rax
               	retq
               	movslq	%edi, %rdi
               	movabsq	$-0x1, %rax
               	imulq	%rdi, %rax
               	retq
               	movabsq	$-0x5, %r11
               	movabsq	$-0x1, %r10
               	imulq	%r10, %r11
               	cmpq	$0x5, %r11
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movl	$0x7, %r11d
               	movabsq	$-0x1, %r10
               	imulq	%r10, %r11
               	cmpq	$-0x7, %r11
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	$0x3, %r11d
               	movabsq	$-0x1, %r10
               	imulq	%r10, %r11
               	cmpq	$-0x3, %r11
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movabsq	$-0x1, %r11
               	movabsq	$-0x1, %rax
               	imulq	%r11, %rax
               	movabsq	$-0x1, %r10
               	imulq	%r10, %r11
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xe, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
