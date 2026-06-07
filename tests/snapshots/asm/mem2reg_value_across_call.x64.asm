
mem2reg_value_across_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	addq	$0x7, %rdi
               	movq	%rdi, %rax
               	retq
               	movq	%rdi, %rax
               	shlq	$0x1, %rax
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
               	xorq	%r14, %r14
               	movq	%r14, %r15
               	jmp	<addr>
               	cmpq	%rbx, %r14
               	jge	<addr>
               	movq	%r14, %rdi
               	callq	<addr>
               	addq	%rax, %r15
               	movq	%r12, %r11
               	movq	%r14, %rdi
               	callq	*%r11
               	addq	%rax, %r15
               	addq	$0x1, %r14
               	jmp	<addr>
               	movq	%r15, %rcx
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
               	movl	$0x3, %edi
               	callq	<addr>
               	andq	$0x7f, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
