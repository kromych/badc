
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
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rax
               	retq
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rax
               	retq
               	movabsq	$-0x5, %rax
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movl	$0x7, %eax
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rax
               	cmpq	$-0x7, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	$0x3, %eax
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rax
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movabsq	$-0x1, %rax
               	movabsq	$-0x1, %rcx
               	imulq	%rax, %rcx
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
