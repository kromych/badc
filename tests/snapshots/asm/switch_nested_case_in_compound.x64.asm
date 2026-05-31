
switch_nested_case_in_compound.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	$0x2, %r9d
               	movslq	%r9d, %r9
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r8
               	cmpq	$0x7, %r8
               	je	<addr>
               	jmp	<addr>
               	movl	$0x64, %r8d
               	movl	%r8d, -0x18(%rbp)
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	movslq	-0x18(%rbp), %r11
               	addq	%r11, %r8
               	movl	%r8d, (%r9)
               	movslq	-0x18(%rbp), %r9
               	cmpq	$0x64, %r9
               	jne	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r9)
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x2, %r11
               	movl	%r11d, (%r9)
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	addq	$0x4, %r8
               	movl	%r8d, (%r9)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r9
               	orq	$0x4000, %r9            # imm = 0x4000
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	cmpq	$0x1, %r9
               	je	<addr>
               	cmpq	$0x2, %r9
               	je	<addr>
               	cmpq	$0x3, %r9
               	je	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r9
               	orq	$0x1000, %r9            # imm = 0x1000
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r11
               	orq	$0x2000, %r11           # imm = 0x2000
               	movl	%r11d, (%r8)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movslq	-0x8(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movl	%r12d, -0x8(%rbp)
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rbx
               	cmpq	$0x106b, %rbx           # imm = 0x106B
               	je	<addr>
               	jmp	<addr>
               	movl	$0x64, %ebx
               	movl	%ebx, -0x20(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rbx
               	movslq	-0x20(%rbp), %r12
               	addq	%r12, %rbx
               	movl	%ebx, (%rax)
               	movslq	-0x20(%rbp), %rax
               	cmpq	$0x64, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rbx
               	addq	$0x1, %rbx
               	movl	%ebx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r12
               	addq	$0x2, %r12
               	movl	%r12d, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rbx
               	addq	$0x4, %rbx
               	movl	%ebx, (%rax)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %rax
               	orq	$0x4000, %rax           # imm = 0x4000
               	movl	%eax, (%r12)
               	jmp	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %rax
               	orq	$0x1000, %rax           # imm = 0x1000
               	movl	%eax, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rbx
               	movslq	(%rbx), %r12
               	orq	$0x2000, %r12           # imm = 0x2000
               	movl	%r12d, (%rbx)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movslq	-0x8(%rbp), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
