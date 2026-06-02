
phi_class_nested_loops.x64:	file format elf64-x86-64

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
               	movslq	%edi, %r11
               	xorq	%r9, %r9
               	movl	%r9d, -0x18(%rbp)
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	cmpq	%r11, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r8)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x20(%rbp)
               	movl	%r9d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %r9
               	cmpq	%r11, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rdi)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %r9
               	movslq	-0x20(%rbp), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x18(%rbp)
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	popq	%rbp
               	jmp	<addr>
