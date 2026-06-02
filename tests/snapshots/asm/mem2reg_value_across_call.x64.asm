
mem2reg_value_across_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	addq	$0x7, %rax
               	retq
               	shlq	$0x1, %rdi
               	movq	%rdi, %rax
               	addq	$0x1, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%rdi, %rbx
               	leaq	-<rip>, %r12       # <addr>
               	xorq	%r8, %r8
               	movq	%r8, -0x10(%rbp)
               	movq	%r8, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x18(%rbp), %r8
               	cmpq	%rbx, %r8
               	jge	<addr>
               	movq	-0x10(%rbp), %rdi
               	movq	-0x18(%rbp), %r8
               	shlq	$0x1, %r8
               	addq	$0x1, %r8
               	addq	%r8, %rdi
               	movq	%rdi, -0x10(%rbp)
               	movq	-0x10(%rbp), %r14
               	movq	-0x18(%rbp), %rdi
               	movq	%r12, %r11
               	callq	*%r11
               	addq	%rax, %r14
               	movq	%r14, -0x10(%rbp)
               	movq	-0x18(%rbp), %rax
               	addq	$0x1, %rax
               	movq	%rax, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	andq	$0x7f, %rdi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
