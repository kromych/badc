
mem2reg_value_across_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %r11
               	movq	%r11, %rax
               	addq	$0x7, %rax
               	retq
               	movq	%rdi, %r11
               	shlq	$0x1, %r11
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	leaq	-<rip>, %r12       # <addr>
               	xorq	%r8, %r8
               	movq	%r8, -0x10(%rbp)
               	movq	%r8, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x18(%rbp), %r8
               	cmpq	%rbx, %r8
               	jge	<addr>
               	movq	-0x10(%rbp), %r14
               	movq	-0x18(%rbp), %r15
               	movq	%r15, %rdi
               	callq	<addr>
               	addq	%rax, %r14
               	movq	%r14, -0x10(%rbp)
               	movq	-0x10(%rbp), %r15
               	movq	-0x18(%rbp), %r14
               	movq	%r12, %r11
               	movq	%r14, %rdi
               	callq	*%r11
               	addq	%rax, %r15
               	movq	%r15, -0x10(%rbp)
               	movq	-0x18(%rbp), %rax
               	addq	$0x1, %rax
               	movq	%rax, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	andq	$0x7f, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
