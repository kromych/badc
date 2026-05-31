
typedef_struct_carrier_reset.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	cmpq	$0xa, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r8)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	movq	%r9, %rdi
               	shlq	$0x2, %rdi
               	movq	%r11, %r8
               	addq	%rdi, %r8
               	movl	%r9d, (%r8)
               	movq	%r11, %rdi
               	addq	$0x28, %rdi
               	movslq	-0x8(%rbp), %r8
               	movq	%r8, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rdi
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%rdi)
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r8
               	movslq	-0x8(%rbp), %rdi
               	shlq	$0x2, %rdi
               	movq	%r11, %rsi
               	addq	%rdi, %rsi
               	movslq	(%rsi), %rdx
               	movq	%r11, %rsi
               	addq	$0x28, %rsi
               	addq	%rdi, %rsi
               	movslq	(%rsi), %rdi
               	addq	%rdi, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %r8
               	movl	%r8d, (%r9)
               	jmp	<addr>
               	movq	%r11, %r8
               	addq	$0xa0, %r8
               	movslq	-0x10(%rbp), %rdx
               	movl	%edx, (%r8)
               	addq	$0xa0, %r11
               	movslq	(%r11), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0xa8(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %rbx
               	cmpq	$0x5, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rbx
               	addq	$0x3c, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	addq	$0xa0, %rax
               	movslq	(%rax), %rbx
               	cmpq	$0x64, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
