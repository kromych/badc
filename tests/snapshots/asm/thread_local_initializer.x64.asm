
thread_local_initializer.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %r11
               	subq	$0x18, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x7, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r11
               	subq	$0x10, %r11
               	movslq	(%r11), %r11
               	cmpq	$-0x3, %r11
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r11
               	subq	$0x8, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r11
               	subq	$0x18, %r11
               	movq	%fs:0x0, %rax
               	subq	$0x18, %rax
               	movslq	(%rax), %rax
               	movq	%fs:0x0, %r8
               	subq	$0x10, %r8
               	movslq	(%r8), %r8
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	movl	%eax, (%r11)
               	movq	%fs:0x0, %r8
               	subq	$0x18, %r8
               	movslq	(%r8), %r8
               	cmpq	$0x4, %r8
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
