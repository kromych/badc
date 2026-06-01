
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
               	movslq	(%r11), %r11
               	cmpq	$0xa, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x8(%rbp)
               	cmpq	$0x0, %r11
               	jne	<addr>
               	leaq	<rip>, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r9
               	cmpq	$0xb, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x8(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x0, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x10(%rbp)
               	cmpq	$0x0, %r9
               	jne	<addr>
               	leaq	<rip>, %rax
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
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1e, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x18(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %r9
               	addq	$0x14, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x1f, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x18(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
