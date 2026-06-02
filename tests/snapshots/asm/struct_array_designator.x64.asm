
struct_array_designator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	<rip>, %r11
               	movslq	(%r11), %r9
               	cmpq	$0xa, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x8(%rbp)
               	cmpq	$0x0, %r9
               	jne	<addr>
               	movq	%r11, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r8
               	cmpq	$0xb, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x8(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	movslq	(%r8), %r8
               	cmpq	$0x0, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x10(%rbp)
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movq	%r11, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1e, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x18(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	addq	$0x14, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x1f, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x18(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
