
object_macro_to_fn_macro_rescan.x64:	file format elf64-x86-64

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
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movslq	%edx, %r14
               	leaq	<rip>, %r15
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x7, %ebx
               	cmpq	$0x7, %rbx
               	jne	<addr>
               	xorq	%r8, %r8
               	andq	$0xff, %r8
               	movq	%r8, -0x28(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %r14
               	movl	$0x13, %r15d
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	jmp	<addr>
               	addq	$0x1, %rbx
               	movslq	%ebx, %rbx
               	cmpq	$0x8, %rbx
               	jne	<addr>
               	xorq	%rax, %rax
               	andq	$0xff, %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %r14
               	movl	$0x14, %ebx
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
