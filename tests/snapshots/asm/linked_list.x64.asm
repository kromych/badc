
linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	xorq	%r11, %r11
               	movq	%r11, -0x8(%rbp)
               	movl	%r11d, -0x20(%rbp)
               	movl	%r11d, -0x28(%rbp)
               	jmp	<addr>
               	movslq	-0x28(%rbp), %r11
               	cmpq	$0x5, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x28(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdi
               	movslq	-0x28(%rbp), %rax
               	movq	%rax, (%rdi)
               	movq	-0x18(%rbp), %r9
               	addq	$0x8, %r9
               	movq	-0x8(%rbp), %rax
               	movq	%rax, (%r9)
               	movq	-0x18(%rbp), %rdi
               	movq	%rdi, -0x8(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rdi
               	movq	%rdi, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movslq	-0x20(%rbp), %rax
               	movq	-0x10(%rbp), %rdi
               	movq	(%rdi), %r9
               	addq	%r9, %rax
               	movl	%eax, -0x20(%rbp)
               	addq	$0x8, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %rdi
               	movq	%rdi, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
